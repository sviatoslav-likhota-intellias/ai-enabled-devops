# Skill: spec-generator

## Purpose

Turn a feature request into a Draft specification based on [specs/TEMPLATE.md](../../specs/TEMPLATE.md).

Use it when a new feature or behavior change is requested and no spec exists yet.

## Required inputs

| Input | Example |
|---|---|
| Request text, quoted exactly | "Add a version endpoint that returns the app version." |
| Feature name in `kebab-case` | `version-endpoint` |

If the feature name is not given, derive it from the request and state it in the output.

## Instructions

1. Read [AGENTS.md](../../AGENTS.md), [constitution.md](../../constitution.md), and [specs/TEMPLATE.md](../../specs/TEMPLATE.md).
2. Check that `specs/<feature-name>.md` does not already exist.
3. Copy the template to `specs/<feature-name>.md`.
4. Set **Status** to `Draft` and quote the request exactly.
5. Write **Problem** using only what the request states.
6. Write **Requirements** only for behavior the request states explicitly.
7. Write one Given/When/Then **Acceptance Criterion** per requirement.
8. Fill in **Security and Dependencies**. Write "None" only if none are needed; otherwise ask.
9. Add an **Open Question** for every detail the request does not state, such as:
   technology stack, URL path, response format, authentication, and deployment target.
10. Leave **Human Approval** blank.
11. Stop and ask a human to review the spec and answer the open questions.

## Stop conditions

Stop and ask a human when:

- The request is empty or does not describe a behavior.
- `specs/<feature-name>.md` already exists.
- The request conflicts with [constitution.md](../../constitution.md).
- The spec draft is complete. Always stop here; never continue to a plan or code.

## Output format

1. The file `specs/<feature-name>.md` with Status `Draft`.
2. A chat message listing the spec path and every open question, numbered.

## Quality checks

| Check | Pass |
|---|---|
| Is Status `Draft`? | Yes |
| Is every template section present? | Yes |
| Does every requirement come from the request text? | Yes |
| Does every requirement have a Given/When/Then criterion? | Yes |
| Is every unstated detail recorded as an Open Question? | Yes |
| Was a technology chosen that the request did not name? | No |
| Is Human Approval left blank? | Yes |
| Was any code, test, plan, or task file created? | No |

## Example

**Input:** "Add a version endpoint that returns the app version." Feature name: `version-endpoint`.

**Output (excerpt of `specs/version-endpoint.md`):**

```markdown
**Status:** Draft

## Requirements
- **R-1:** A request to the version endpoint returns the application version.

## Acceptance Criteria
- **AC-1** (covers R-1)
  - **Given** the application is running
  - **When** a client requests the version endpoint
  - **Then** the response contains the application version

## Open Questions
- **Q-1:** What technology stack should be used? — **Answer:** pending
- **Q-2:** What URL path should the endpoint use? — **Answer:** pending
- **Q-3:** Where does the version value come from? — **Answer:** pending
```
