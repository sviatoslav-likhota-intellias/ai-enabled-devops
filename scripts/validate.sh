#!/usr/bin/env bash
# Repository validation. Run from the repository root: bash scripts/validate.sh
# Exits 0 when every check passes, 1 otherwise.

set -u
cd "$(dirname "$0")/.." || exit 1

failures=0
pass() { echo "PASS  $1"; }
fail() { echo "FAIL  $1"; failures=$((failures + 1)); }

# 1. Required files and folders exist.
required=(
  AGENTS.md README.md CONTRIBUTING.md CLAUDE.md constitution.md docs/standards.md
  specs/TEMPLATE.md plans/TEMPLATE.md tasks/TEMPLATE.md review/change-template.md
  src tests skills skill-runs
)
missing=0
for path in "${required[@]}"; do
  [ -e "$path" ] || { fail "required path missing: $path"; missing=1; }
done
[ "$missing" -eq 0 ] && pass "required files and folders exist"

# 2. AGENTS.md links every governance document.
governance=(
  README.md CONTRIBUTING.md constitution.md docs/standards.md
  specs/TEMPLATE.md plans/TEMPLATE.md tasks/TEMPLATE.md review/change-template.md
)
for dir in skills/*/; do governance+=("${dir}SKILL.md"); done
unlinked=0
for doc in "${governance[@]}"; do
  grep -qF "]($doc)" AGENTS.md || { fail "AGENTS.md does not link $doc"; unlinked=1; }
done
[ "$unlinked" -eq 0 ] && pass "AGENTS.md links all governance documents"

# 3. Relative Markdown links resolve. Code blocks, inline code, and <placeholder> links are skipped.
broken=0
while IFS= read -r file; do
  dir=$(dirname "$file")
  links=$(awk '/^```/ { inside = !inside; next } !inside' "$file" \
    | sed -E 's/`[^`]*`//g' \
    | grep -oE '\]\([^)]+\)' | sed -E 's/^\]\(//; s/\)$//; s/#.*$//')
  for link in $links; do
    case "$link" in ''|http://*|https://*|mailto:*|*'<'*) continue ;; esac
    [ -e "$dir/$link" ] || { fail "broken link in $file: $link"; broken=1; }
  done
done < <(git ls-files --cached --others --exclude-standard '*.md')
[ "$broken" -eq 0 ] && pass "all relative links resolve"

# 4 and 5. Specs have a valid Status; Approved specs name a human and a date.
approved=0
spec_errors=0
for spec in specs/*.md; do
  [ "$spec" = "specs/TEMPLATE.md" ] && continue
  status=$(grep -m1 '^\*\*Status:\*\*' "$spec" | sed -E 's/^\*\*Status:\*\* *//; s/ *<!--.*//')
  case "$status" in
    Draft|"In Review"|Rejected) ;;
    Approved)
      approved=1
      grep -qE '^- \*\*Approved by:\*\* *[^< ]' "$spec" \
        || { fail "$spec is Approved but has no approver name"; spec_errors=1; }
      grep -qE '^- \*\*Date:\*\* *[0-9]{4}-[0-9]{2}-[0-9]{2}' "$spec" \
        || { fail "$spec is Approved but has no approval date"; spec_errors=1; }
      ;;
    *) fail "$spec has invalid Status: '$status'"; spec_errors=1 ;;
  esac
done
[ "$spec_errors" -eq 0 ] && pass "specs have valid status and approvals"

# 6. Each skill has all required sections and a recorded run.
sections=("## Purpose" "## Required inputs" "## Instructions" "## Stop conditions"
  "## Output format" "## Quality checks" "## Example")
skill_errors=0
for dir in skills/*/; do
  name=$(basename "$dir")
  for section in "${sections[@]}"; do
    grep -qxF "$section" "${dir}SKILL.md" 2>/dev/null \
      || { fail "skills/$name/SKILL.md is missing '$section'"; skill_errors=1; }
  done
  [ -f "skill-runs/$name.md" ] || { fail "skill-runs/$name.md is missing"; skill_errors=1; }
done
[ "$skill_errors" -eq 0 ] && pass "skills are complete and have recorded runs"

# 7. src/ and tests/ stay empty until a spec is Approved.
code_files=$(find src tests -type f ! -name .gitkeep 2>/dev/null)
if [ -n "$code_files" ] && [ "$approved" -eq 0 ]; then
  fail "src/ or tests/ contain files but no spec is Approved"
else
  pass "no code without an approved spec"
fi

echo
if [ "$failures" -eq 0 ]; then
  echo "Validation passed."
  exit 0
fi
echo "Validation failed: $failures problem(s)."
exit 1
