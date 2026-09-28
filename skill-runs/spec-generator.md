# Skill run: spec-generator

**Skill:** [skills/spec-generator/SKILL.md](../skills/spec-generator/SKILL.md)
**Date:** 2026-09-28
**Run by:** Claude (AI agent), supervised by Sviatoslav Likhota

## Input

| Input | Value |
|---|---|
| Request text | "Log each incoming request with method, path, and status code." |
| Feature name | `request-logging` |

## Output

The skill writes `specs/request-logging.md`. For this recorded run, the output is kept
only in this file so `specs/` holds real features only.

### Output 1: spec file

```markdown
# Spec: request-logging

**Status:** Draft
**Author:** Claude (AI agent)
**Request:** "Log each incoming request with method, path, and status code."

## Problem

There is no record of the requests the application receives. Operators cannot see
which requests were made or what status code each one returned.

## Scope

- Writing one log entry for each incoming request.
- Including the request method, path, and response status code in each entry.

## Out of Scope

- Logging request or response bodies or headers.
- Metrics, dashboards, or alerting.
- Log storage, rotation, or retention.

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

## Security and Dependencies

- **Secrets:** None used. Request paths may contain sensitive query values; see Q-5.
- **New dependencies:** Unknown until the stack is chosen; see Q-1 and Q-2.
- **Security impact:** Logs may expose data carried in request paths; see Q-5.

## Open Questions

- **Q-1:** What technology stack should be used? — **Answer:** pending
- **Q-2:** May a logging library be added, or must the standard library be used? — **Answer:** pending
- **Q-3:** Where are log entries written: standard output, a file, or another destination? — **Answer:** pending
- **Q-4:** What format should an entry use: plain text or structured (for example JSON)? — **Answer:** pending
- **Q-5:** Should query strings be included in the logged path, or removed? — **Answer:** pending
- **Q-6:** Should an entry include other fields, such as a timestamp or duration? — **Answer:** pending
- **Q-7:** What status code is logged when a request fails with an unhandled error? — **Answer:** pending

A spec with unanswered Open Questions cannot be `Approved`.

## Human Approval

An agent cannot approve its own specification.

- **Approved by:**
- **Date:**
```

### Output 2: chat message

> Draft spec created: `specs/request-logging.md` (Status: Draft).
> Please review it and answer these open questions before approval:
>
> 1. Q-1: What technology stack should be used?
> 2. Q-2: May a logging library be added, or must the standard library be used?
> 3. Q-3: Where are log entries written: standard output, a file, or another destination?
> 4. Q-4: What format should an entry use: plain text or structured (for example JSON)?
> 5. Q-5: Should query strings be included in the logged path, or removed?
> 6. Q-6: Should an entry include other fields, such as a timestamp or duration?
> 7. Q-7: What status code is logged when a request fails with an unhandled error?
>
> I have stopped. I will not create a plan or code until the spec is approved.

## Quality checks

| Check | Result | Evidence |
|---|---|---|
| Is Status `Draft`? | Yes | `**Status:** Draft` |
| Is every template section present? | Yes | All 9 sections of `specs/TEMPLATE.md` present |
| Does every requirement come from the request text? | Yes | R-1 "each incoming request"; R-2 "method, path, and status code" |
| Does every requirement have a Given/When/Then criterion? | Yes | R-1 → AC-1, R-2 → AC-2 |
| Is every unstated detail recorded as an Open Question? | Yes | Stack, library, destination, format, query strings, extra fields, error status: Q-1 to Q-7 |
| Was a technology chosen that the request did not name? | No | Stack left as Q-1 |
| Is Human Approval left blank? | Yes | Both fields blank |
| Was any code, test, plan, or task file created? | No | Only this run record was written |
