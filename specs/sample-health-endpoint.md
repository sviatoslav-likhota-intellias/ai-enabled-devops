<!-- Smoke-test Draft, preserved verbatim as the agent first wrote it from the bare prompt
     (smoke-test attempt 2, 2026-09-28 16:26 UTC; transcript: smoke-test/attempt-2.md).
     The answered, approved, and implemented version is specs/health-endpoint.md. -->
# Spec: health-endpoint

**Status:** Draft <!-- Draft | In Review | Approved | Rejected -->
**Author:** Claude Code (agent)
**Request:** "Add a health endpoint that returns HTTP 200 with status OK."

## Problem

Clients need a way to check that the application is running.
A health endpoint that answers with HTTP 200 and status OK gives them that check.

## Scope

- A health endpoint that returns HTTP 200 with status OK.

## Out of Scope

- Checks of downstream dependencies (databases, external services).
- Any response other than HTTP 200 with status OK.

## Requirements

- **R-1:** A request to the health endpoint returns HTTP status code 200.
- **R-2:** The response from the health endpoint indicates status OK.

## Acceptance Criteria

- **AC-1** (covers R-1)
  - **Given** the application is running
  - **When** a client requests the health endpoint
  - **Then** the response has HTTP status code 200
- **AC-2** (covers R-2)
  - **Given** the application is running
  - **When** a client requests the health endpoint
  - **Then** the response indicates status OK

## Security and Dependencies

- **Secrets:** None.
- **New dependencies:** Pending Q-1. The application has no stack yet, so a runtime and possibly an HTTP library will be needed.
- **Security impact:** Pending Q-5. A new network-reachable endpoint is added.

## Open Questions

- **Q-1:** What technology stack should be used (language, runtime, HTTP framework, versions)? — **Answer:** pending
- **Q-2:** What URL path should the endpoint use (for example `/health`)? — **Answer:** pending
- **Q-3:** Which HTTP method or methods should it accept (for example `GET` only)? — **Answer:** pending
- **Q-4:** What is the exact response format for "status OK" (for example JSON `{"status":"OK"}` or plain text `OK`), and what `Content-Type`? — **Answer:** pending
- **Q-5:** Should the endpoint require authentication? — **Answer:** pending
- **Q-6:** What port and host should the application listen on, and how is that configured? — **Answer:** pending
- **Q-7:** What test framework and test command should be used, to be added to AGENTS.md validation? — **Answer:** pending
- **Q-8:** What is the deployment target, if any, for this change? — **Answer:** pending

A spec with unanswered Open Questions cannot be `Approved`.
An answer that defines behavior must also appear in Requirements and Acceptance Criteria before approval.

## Human Approval

An agent cannot approve its own specification.

- **Approved by:**
- **Date:**
