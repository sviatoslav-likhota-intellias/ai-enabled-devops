# Skill: test-plan-generator

## Purpose

Turn the acceptance criteria of an approved spec into a list of test cases,
ready to paste into the plan's **Test strategy** section.

Use it after a spec is `Approved` and before implementation starts.

## Required inputs

| Input | Example |
|---|---|
| Path to an approved spec | `specs/version-endpoint.md` |

## Instructions

1. Read [AGENTS.md](../../AGENTS.md), [docs/standards.md](../../docs/standards.md#testing), and the spec.
2. Confirm the spec's Status is `Approved`.
3. For each acceptance criterion, write at least one test case with:
   ID, covered AC, Given, When, Then, and expected result.
4. Add a failure-case test only when the spec states the failure behavior.
   Otherwise, add an open question.
5. Name the test framework only if the spec names it. Otherwise write "framework per approved stack".
6. Check that every AC has at least one test case.

## Stop conditions

Stop and ask a human when:

- The spec's Status is not `Approved`.
- An acceptance criterion is not testable, for example "should be fast".
- A test would require an unapproved dependency or a protected path.

## Output format

A Markdown section with:

1. A test case table: `ID | Covers | Given | When | Then`.
2. A coverage line: "Every AC covered: Yes/No".
3. A list of open questions, or "None".

## Quality checks

| Check | Pass |
|---|---|
| Is the spec Status `Approved`? | Yes |
| Does every AC have at least one test case? | Yes |
| Does every test case reference an AC ID? | Yes |
| Does every test case have Given, When, and Then? | Yes |
| Was an unspecified test framework chosen? | No |
| Was any behavior tested that the spec does not state? | No |

## Example

**Input:** `specs/version-endpoint.md` (Approved; AC-1: GET `/version` returns HTTP 200 with the version from the build).

**Output:**

```markdown
| ID | Covers | Given | When | Then |
|---|---|---|---|---|
| T-1 | AC-1 | the app runs with version 1.2.0 | a client sends GET /version | status is 200 |
| T-2 | AC-1 | the app runs with version 1.2.0 | a client sends GET /version | body contains "1.2.0" |

Every AC covered: Yes
Open questions: None
```
