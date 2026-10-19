#!/usr/bin/env bash
# Repository validation. Run from the repository root: bash scripts/validate.sh
# Exits 0 when every check passes, 1 otherwise. Uses only files on disk, not git.

set -u
cd "$(dirname "$0")/.." || exit 1

failures=0
pass() { echo "PASS  $1"; }
fail() { echo "FAIL  $1"; failures=$((failures + 1)); }

# Folders that are local or generated, never part of the repository content.
skip_dirs=(--exclude-dir=.git --exclude-dir=.gradle --exclude-dir=.idea --exclude-dir=build)
# Ignored local secret files (see .gitignore). They are never committed.
skip_secret_files=(--exclude=.env --exclude='.env.*' --exclude='*.pem' --exclude='*.key')

# 1. Required files and folders exist.
required=(
  AGENTS.md README.md CONTRIBUTING.md CLAUDE.md constitution.md docs/standards.md
  specs/TEMPLATE.md plans/TEMPLATE.md tasks/TEMPLATE.md review/change-template.md
  specs/sample-health-endpoint.md smoke-test/README.md
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

# 3. Relative Markdown links resolve.
# Skipped: code blocks, inline code, <placeholder> links, and smoke-test transcripts,
# which are verbatim records whose links were relative to the repository root at the time.
broken=0
while IFS= read -r file; do
  file=${file#./}
  case "$file" in smoke-test/attempt-*.md) continue ;; esac
  dir=$(dirname "$file")
  links=$(awk '/^```/ { inside = !inside; next } !inside' "$file" \
    | sed -E 's/`[^`]*`//g' \
    | grep -oE '\]\([^)]+\)' | sed -E 's/^\]\(//; s/\)$//; s/#.*$//')
  for link in $links; do
    case "$link" in ''|http://*|https://*|mailto:*|*'<'*) continue ;; esac
    [ -e "$dir/$link" ] || { fail "broken link in $file: $link"; broken=1; }
  done
done < <(grep -rl "${skip_dirs[@]}" --include='*.md' '](' .)
[ "$broken" -eq 0 ] && pass "all relative links resolve"

# 4. Specs have a valid Status. Approved specs are approved by a human, with a date,
#    and have no pending answers.
approved_specs=()
spec_errors=0
agent_names='claude|agent|\bai\b|gpt|copilot|codex|gemini|\bbot\b'
for spec in specs/*.md; do
  [ "$spec" = "specs/TEMPLATE.md" ] && continue
  status=$(grep -m1 '^\*\*Status:\*\*' "$spec" | sed -E 's/^\*\*Status:\*\* *//; s/ *<!--.*//')
  case "$status" in
    Draft|"In Review"|Rejected) ;;
    Approved)
      approved_specs+=("$spec")
      approver=$(grep -m1 '^- \*\*Approved by:\*\*' "$spec" | sed -E 's/^- \*\*Approved by:\*\* *//')
      author=$(grep -m1 '^\*\*Author:\*\*' "$spec" | sed -E 's/^\*\*Author:\*\* *//')
      if [ -z "$approver" ] || [[ "$approver" == *'<'* ]]; then
        fail "$spec is Approved but has no approver name"; spec_errors=1
      elif echo "$approver" | grep -qiE "$agent_names" || [ "$approver" = "$author" ]; then
        fail "$spec is approved by an agent or by its own author: '$approver'"; spec_errors=1
      fi
      grep -qE '^- \*\*Date:\*\* *[0-9]{4}-[0-9]{2}-[0-9]{2}' "$spec" \
        || { fail "$spec is Approved but has no approval date"; spec_errors=1; }
      grep -qiE '\*\*Answer:\*\* *(pending|<[^>]*>)? *$' "$spec" \
        && { fail "$spec is Approved but has unanswered open questions"; spec_errors=1; }
      ;;
    *) fail "$spec has invalid Status: '$status'"; spec_errors=1 ;;
  esac
done
[ "$spec_errors" -eq 0 ] && pass "specs have valid status and human approvals"

# 5. Each skill has all required sections and a recorded run.
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

# 6. Every file in src/ and tests/ is listed in "Files to change" of a plan
#    whose spec is Approved.
planned=""
for plan in plans/*.md; do
  [ "$plan" = "plans/TEMPLATE.md" ] && continue
  spec=$(grep -m1 -oE '^\*\*Spec:\*\* \[[^]]+\]' "$plan" | sed -E 's/^\*\*Spec:\*\* \[//; s/\]$//')
  case " ${approved_specs[*]-} " in *" $spec "*) ;; *) continue ;; esac
  planned+=$(awk '/^## Files to change/ { on = 1; next } /^## / { on = 0 } on' "$plan" \
    | grep -oE '`[^`]+`' | tr -d '`')$'\n'
done
unplanned=0
while IFS= read -r file; do
  [ -n "$file" ] || continue
  grep -qxF "$file" <<< "$planned" \
    || { fail "$file is not in Files to change of a plan with an Approved spec"; unplanned=1; }
done < <(find src tests -type f ! -name .gitkeep 2>/dev/null)
[ "$unplanned" -eq 0 ] && pass "all code is covered by an approved spec and plan"

# 7. No secret values: private keys, known token formats, or quoted values
#    assigned to secret-like names. Placeholders such as "<value>" are allowed.
secret_patterns=(
  -e '-----BEGIN [A-Z ]*PRIVATE KEY-----'
  -e 'gh[pousr]_[A-Za-z0-9]{36,}'
  -e 'AKIA[0-9A-Z]{16}'
  -e 'xox[abprs]-[A-Za-z0-9-]{10,}'
  -e '(password|passwd|secret|token|api[_-]?key)["'"'"']?[[:space:]]*[:=][[:space:]]*["'"'"'][^"'"'"'<>[:space:]]{8,}["'"'"']'
)
secrets=$(grep -rInoiE "${skip_dirs[@]}" "${skip_secret_files[@]}" "${secret_patterns[@]}" . \
  | cut -d: -f1,2 | sort -u)
if [ -n "$secrets" ]; then
  while IFS= read -r hit; do fail "possible secret at ${hit#./} (value not shown)"; done <<< "$secrets"
else
  pass "no secret values found"
fi

echo
if [ "$failures" -eq 0 ]; then
  echo "Validation passed."
  exit 0
fi
echo "Validation failed: $failures problem(s)."
exit 1
