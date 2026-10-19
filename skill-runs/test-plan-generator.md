# Skill run: test-plan-generator

**Skill:** [skills/test-plan-generator/SKILL.md](../skills/test-plan-generator/SKILL.md)
**Date:** 2026-09-28
**Run by:** Claude (AI agent), supervised by Sviatoslav Likhota
**Re-recorded:** 2026-10-19, after the input spec was corrected so every behavior answer is a requirement

## Input

The approved `request-logging` spec from the [spec-generator run](spec-generator.md),
with the human's answers applied to Requirements and Acceptance Criteria,
and the human's approval recorded exactly as given.
This spec is a skill exercise and will not be implemented.

```markdown
# Spec: request-logging

**Status:** Approved
**Author:** Claude (AI agent)
**Request:** "Log each incoming request with method, path, and status code."

## Requirements

- **R-1:** Each incoming request produces exactly one log entry.
- **R-2:** Each log entry is one line on standard output in the plain-text format
  `<method> <path> <status>`, with no other fields. (Q-3, Q-4, Q-6)
- **R-3:** The logged path does not include the query string. (Q-5)
- **R-4:** When a request fails with an unhandled error, the logged status is `500`. (Q-7)

## Acceptance Criteria

- **AC-1** (covers R-1)
  - **Given** the application is running
  - **When** a client sends one request
  - **Then** exactly one log entry is written for that request

- **AC-2** (covers R-2)
  - **Given** the application is running
  - **When** a client sends `GET /items` and receives `200`
  - **Then** standard output contains exactly the line `GET /items 200`

- **AC-3** (covers R-3)
  - **Given** the application is running
  - **When** a client sends `GET /items?token=abc` and receives `200`
  - **Then** the log entry is `GET /items 200`

- **AC-4** (covers R-4)
  - **Given** the application is running and the handler for `/fail` throws an unhandled error
  - **When** a client sends `GET /fail`
  - **Then** the log entry is `GET /fail 500`

## Security and Dependencies

- **Secrets:** None.
- **New dependencies:** None. Standard library only (Q-2).
- **Security impact:** Query strings, which may carry sensitive values, are not logged (R-3).

## Open Questions

- **Q-1:** What technology stack should be used? — **Answer:** Not decided; this spec is a skill exercise and will not be implemented.
- **Q-2:** May a logging library be added, or must the standard library be used? — **Answer:** Standard library only; no new dependencies.
- **Q-3:** Where are log entries written? — **Answer:** Standard output. Applied in R-2.
- **Q-4:** What format should an entry use? — **Answer:** Plain text: `<method> <path> <status>`. Applied in R-2.
- **Q-5:** Should query strings be included in the logged path? — **Answer:** Removed. Log the path only. Applied in R-3.
- **Q-6:** Should an entry include other fields? — **Answer:** None, only the three requested fields. Applied in R-2.
- **Q-7:** What status code is logged for an unhandled error? — **Answer:** 500. Applied in R-4.

## Human Approval

- **Approved by:** Sviatoslav Likhota
- **Date:** 2026-10-19
- **As given:** "Approved Sviatoslav Likhota 2026-10-19"
```

Problem, Scope, and Out of Scope are unchanged from the spec-generator run and omitted here.

## Output

### Test cases

Framework: framework per approved stack (Q-1 not decided).

| ID | Covers | Given | When | Then |
|---|---|---|---|---|
| T-1 | AC-1 | the application is running and standard output is captured | a client sends one `GET /items` request | exactly one log entry is written |
| T-2 | AC-1 | the application is running and standard output is captured | a client sends two requests | exactly two log entries are written, one per request |
| T-3 | AC-2 | the application is running and standard output is captured | a client sends `GET /items` and receives `200` | standard output contains exactly the line `GET /items 200` |
| T-4 | AC-2 | the application is running and standard output is captured | a client sends `GET /items` and receives `200` | the entry has exactly three space-separated fields |
| T-5 | AC-3 | the application is running and standard output is captured | a client sends `GET /items?token=abc` and receives `200` | the log entry is `GET /items 200` and does not contain `token=abc` |
| T-6 | AC-4 | the application is running, standard output is captured, and the `/fail` handler throws an unhandled error | a client sends `GET /fail` | the log entry is `GET /fail 500` |

### Coverage

Every AC covered: Yes (AC-1 → T-1, T-2; AC-2 → T-3, T-4; AC-3 → T-5; AC-4 → T-6)

### Open questions

None.

## Quality checks

| Check | Result | Evidence |
|---|---|---|
| Is the spec Status `Approved`? | Yes | `**Status:** Approved`, Sviatoslav Likhota, 2026-10-19 |
| Does every AC have at least one test case? | Yes | AC-1 → T-1, T-2; AC-2 → T-3, T-4; AC-3 → T-5; AC-4 → T-6 |
| Does every test case reference an AC ID? | Yes | Covers column filled for T-1 to T-6 |
| Does every test case have Given, When, and Then? | Yes | All three columns filled for T-1 to T-6 |
| Was an unspecified test framework chosen? | No | "framework per approved stack" |
| Was any behavior tested that the spec does not state? | No | Every Then matches R-1 to R-4 |
