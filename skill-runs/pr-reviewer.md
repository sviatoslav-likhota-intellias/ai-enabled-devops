# Skill run: pr-reviewer

**Skill:** [skills/pr-reviewer/SKILL.md](../skills/pr-reviewer/SKILL.md)
**Date:** 2026-09-28
**Run by:** Claude (AI agent), supervised by Sviatoslav Likhota

## Input

| Input | Value |
|---|---|
| Change reference | `5ff42cf` ("Add workflow templates and contribution guide") |
| Linked spec | none (repository foundation, created before the spec workflow existed) |
| Linked plan | none |

The skill writes `review/<feature-name>.md`. For this recorded run, the output is kept
only in this file so `review/` holds real reviews only.

## Commands run

```text
$ git show --stat 5ff42cf
 CONTRIBUTING.md           | 51 +++
 plans/TEMPLATE.md         | 34 +++
 review/change-template.md | 24 +++
 specs/TEMPLATE.md         | 47 +++
 tasks/TEMPLATE.md         | 13 +++
 5 files changed, 169 insertions(+)

$ git show 5ff42cf | grep -inE "password|secret|token|api[_-]?key|BEGIN .*PRIVATE KEY"
127:+| 5 | Are secrets absent? | `git diff main \| grep -inE "password\|secret\|token\|api[_-]?key\|BEGIN .*PRIVATE KEY"` returns no matches | | |
173:+- **Secrets:** <None, or the variable names used.>

$ bash scripts/validate.sh
bash: scripts/validate.sh: No such file or directory
```

## Output

```markdown
# Change Review: workflow-templates

**Change:** 5ff42cf
**Reviewer:** Claude (AI agent)

| # | Question | Answer | Evidence |
|---|---|---|---|
| 1 | Is an approved specification linked? | Not applicable | Foundation commit; the spec workflow is defined by this change. Files are required by the assignment brief, deliverables 2, 3 and 5. |
| 2 | Is the change within scope? | Yes | `git show --stat` lists 5 files; all 5 were proposed as Step 3 and approved by Sviatoslav Likhota in the conversation on 2026-09-28. |
| 3 | Are acceptance criteria covered by tests? | Not applicable | Documentation only; no acceptance criteria and no code. `src/` and `tests/` untouched. |
| 4 | Did validation pass? | No | `scripts/validate.sh` does not exist: "No such file or directory". |
| 5 | Are secrets absent? | Yes | Secret scan matched 2 lines (127, 173). Both are template text naming the word "secret", not secret values. |
| 6 | Are dependencies justified? | Yes | None added. `git show --stat` lists only `.md` files. |
| 7 | Are protected paths unchanged or approved? | Yes | All 5 files are protected paths. Created with approval from Sviatoslav Likhota in the conversation on 2026-09-28 ("yes, proceed"). |
| 8 | Are relevant documents updated? | Yes | `AGENTS.md` links all 5 files (lines 45–51, added in 7775159). |

## Result

- **Ready to merge:** No
- **Required fixes:** Add `scripts/validate.sh` and run it on this change (question 4).
```

## Quality checks

| Check | Result | Evidence |
|---|---|---|
| Are all 8 questions answered? | Yes | Rows 1–8 filled |
| Is every answer `Yes`, `No`, or `Not applicable`? | Yes | Answer column |
| Does every answer have evidence? | Yes | Evidence column filled for all 8 rows |
| Does every `Not applicable` have a reason? | Yes | Rows 1 and 3 give reasons |
| Is Ready to merge `No` whenever any answer is `No`? | Yes | Row 4 is `No`; Ready to merge is `No` |
| Was any file other than the review file changed? | No | Only this run record was written |
