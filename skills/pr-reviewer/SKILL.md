# Skill: pr-reviewer

## Purpose

Review a change against the checklist in [review/change-template.md](../../review/change-template.md)
and record every answer with evidence.

Use it before submitting or merging any change.

## Required inputs

| Input | Example |
|---|---|
| Change reference: commit, commit range, or branch | `main..feature/version-endpoint` |
| Linked spec path, or "none" | `specs/version-endpoint.md` |
| Linked plan path, or "none" | `plans/version-endpoint.md` |

## Instructions

1. Read [AGENTS.md](../../AGENTS.md) and [review/change-template.md](../../review/change-template.md).
2. Copy the checklist to `review/<feature-name>.md`.
3. List the changed files: `git diff --stat <change>`.
4. Answer each of the 8 questions in order, using the template's **Expected evidence** column.
5. Answer only `Yes`, `No`, or `Not applicable`.
6. Attach evidence to every answer: a link, command output, or file reference.
7. If evidence cannot be found, answer `No`.
8. Use `Not applicable` only with a written reason.
9. Fill in **Result**: Ready to merge is `Yes` only if no answer is `No`.
10. List required fixes for every `No`.

## Stop conditions

Stop and ask a human when:

- The change reference cannot be resolved by git.
- The checklist template is missing or has changed questions.
- A secret is found. Report the file and line, never the value.

Never fix code, approve a spec, or merge a change during a review.

## Output format

The file `review/<feature-name>.md`: the completed checklist with every row filled
and the Result section complete.

## Quality checks

| Check | Pass |
|---|---|
| Are all 8 questions answered? | Yes |
| Is every answer `Yes`, `No`, or `Not applicable`? | Yes |
| Does every answer have evidence? | Yes |
| Does every `Not applicable` have a reason? | Yes |
| Is Ready to merge `No` whenever any answer is `No`? | Yes |
| Was any file other than the review file changed? | No |

## Example

**Input:** change `abc123`, spec `specs/version-endpoint.md`, plan `plans/version-endpoint.md`.

**Output (excerpt of `review/version-endpoint.md`):**

```markdown
| # | Question | Answer | Evidence |
|---|---|---|---|
| 1 | Is an approved specification linked? | Yes | specs/version-endpoint.md — Status Approved by J. Doe, 2026-01-10 |
| 4 | Did validation pass? | No | `bash scripts/validate.sh` exited 1: "FAIL T-2: body does not contain 1.2.0" |

- **Ready to merge:** No
- **Required fixes:** Fix the version value so test T-2 passes.
```
