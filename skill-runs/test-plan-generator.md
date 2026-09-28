# Skill run: test-plan-generator

**Skill:** [skills/test-plan-generator/SKILL.md](../skills/test-plan-generator/SKILL.md)
**Date:** 2026-09-28
**Run by:** Claude (AI agent), supervised by Sviatoslav Likhota

## Input

The approved `request-logging` spec from the [spec-generator run](spec-generator.md),
with the human's answers and approval recorded exactly as given.
This spec is a skill exercise and will not be implemented.

```markdown
# Spec: request-logging

**Status:** Approved
**Author:** Claude (AI agent)
**Request:** "Log each incoming request with method, path, and status code."

## Requirements

- **R-1:** Each incoming request produces exactly one log entry.
- **R-2:** Each log entry contains the request method, the request path, and the response status code.

## Acceptance Criteria

- **AC-1** (covers R-1)
  - **Given** the application is running
  - **When** a client sends one request
  - **Then** exactly one log entry is written for that request

- **AC-2** (covers R-2)
  - **Given** the application is running
  - **When** a client sends a GET request to a path and receives a response
  - **Then** the log entry contains the method `GET`, that path, and the response status code

## Open Questions

- **Q-1:** What technology stack should be used? — **Answer:** Not decided; this spec is a skill exercise and will not be implemented.
- **Q-2:** May a logging library be added, or must the standard library be used? — **Answer:** Standard library only; no new dependencies.
- **Q-3:** Where are log entries written? — **Answer:** Standard output.
- **Q-4:** What format should an entry use? — **Answer:** Plain text: `<method> <path> <status>`.
- **Q-5:** Should query strings be included in the logged path? — **Answer:** Removed. Log the path only.
- **Q-6:** Should an entry include other fields? — **Answer:** None, only the three requested fields.
- **Q-7:** What status code is logged for an unhandled error? — **Answer:** 500.

## Human Approval

- **Approved by:** Sviatoslav Likhota
- **Date:** 2026-09-28
```

Problem, Scope, and Security sections are unchanged from the spec-generator run and omitted here.

## Output

### Test cases

Framework: framework per approved stack (Q-1 not decided).

| ID | Covers | Given | When | Then |
|---|---|---|---|---|
| T-1 | AC-1 | the application is running and standard output is captured | a client sends one GET request to `/items` | exactly one log entry is written |
| T-2 | AC-1 | the application is running and standard output is captured | a client sends two requests | exactly two log entries are written, one per request |
| T-3 | AC-2 | the application is running and standard output is captured | a client sends GET `/items` and receives 200 | the log entry is `GET /items 200` |
| T-4 | AC-2 | the application is running and standard output is captured | a client sends GET `/missing` and receives 404 | the log entry is `GET /missing 404` |

Test data notes:
- Entries are read from standard output (Q-3) and matched against `<method> <path> <status>` (Q-4).
- Each entry has exactly three fields (Q-6).

### Coverage

Every AC covered: Yes (AC-1 → T-1, T-2; AC-2 → T-3, T-4)

### Open questions

- **TQ-1:** The answer to Q-5 (query strings removed) describes behavior, but no acceptance criterion covers it.
  Should an AC be added so it can be tested? Suggested: Given a request to `/items?token=abc`, Then the entry is `GET /items 200`.
- **TQ-2:** The answer to Q-7 (unhandled error logs 500) describes behavior, but no acceptance criterion covers it.
  Should an AC be added so it can be tested?

No test cases were written for TQ-1 or TQ-2, because every test must reference an AC ID.

## Quality checks

| Check | Result | Evidence |
|---|---|---|
| Is the spec Status `Approved`? | Yes | `**Status:** Approved`, Sviatoslav Likhota, 2026-09-28 |
| Does every AC have at least one test case? | Yes | AC-1 → T-1, T-2; AC-2 → T-3, T-4 |
| Does every test case reference an AC ID? | Yes | Covers column filled for T-1 to T-4 |
| Does every test case have Given, When, and Then? | Yes | All three columns filled for T-1 to T-4 |
| Was an unspecified test framework chosen? | No | "framework per approved stack" |
| Was any behavior tested that the spec does not state? | No | Q-5 and Q-7 behavior raised as TQ-1 and TQ-2 instead of tested |
