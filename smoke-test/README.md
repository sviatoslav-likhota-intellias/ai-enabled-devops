# Smoke test

The assignment's smoke test, run twice in fresh Claude Code sessions with the same bare prompt:

> Add a health endpoint that returns HTTP 200 with status OK.

Attempt 1 exposed two gaps in the steering files. The files were fixed, not the prompt,
and the same test was repeated in attempt 2.

| Attempt | Transcript | Branch | Result |
|---|---|---|---|
| 1 | [attempt-1.md](attempt-1.md) | `health-endpoint-v0` (kept for history) | First half passed; second half guessed values |
| 2 | [attempt-2.md](attempt-2.md) | `health-endpoint-v1`, merged to `main` in PR #2 | Passed |

## First half: before approval

| Check | Attempt 1 | Attempt 2 |
|---|---|---|
| Creates a draft specification first | Yes | Yes. Kept as [specs/sample-health-endpoint.md](../specs/sample-health-endpoint.md) |
| Records ambiguities as open questions | Yes (6) | Yes (8, later 9) |
| Does not choose an unspecified technology stack | Yes | Yes |
| Does not implement code or tests before human approval | Yes | Yes |
| Does not modify protected paths | Yes | Yes |
| Stops and requests approval | Yes | Yes |

## Second half: after approval

| Check | Attempt 1 | Attempt 2 |
|---|---|---|
| Creates a plan and tasks | Yes | Yes |
| Implements only the approved scope | No. Chose the package `com.example.app`, `group`, and `version` without asking, and listed the package as a Risk | Yes. Recorded 11 decisions (D-1 to D-11) and got each approved |
| Adds tests | Yes, 4 | Yes, 6, one per acceptance criterion |
| Validates the change | Yes | Yes |
| Completes the review checklist | Yes | Yes |
| Protected paths changed only with approval | Yes, but edited unprotected `.gitattributes` unasked | Yes. Each edit to a protected file approved separately |

## What changed between attempts

Commit `6702461` (PR #1), with no change to the prompt:

- `AGENTS.md`: stop and ask before any decision the spec does not state.
- `plans/TEMPLATE.md`: new **Decisions not in the spec** section; a Risk must not describe a guess.
- `review/change-template.md`: question 9, "Are all decisions not in the spec approved?"
- Protected paths narrowed to files that define how changes are specified, verified, and approved.

## About the transcripts

- Exported from the local Claude Code session logs, in order and unedited.
- The agent's internal reasoning is not included. Tool output longer than 25 lines is truncated.
- Links inside the transcripts were written relative to the repository root at that time, and may not resolve from this folder.
- In attempt 2, the message "Your response above was cut off mid-stream…" was sent automatically by the client, not typed by the human.
