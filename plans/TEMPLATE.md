# Plan: <feature-name>

**Spec:** [specs/<feature-name>.md](../specs/<feature-name>.md)
**Spec status:** Approved <!-- Must be Approved before this plan is written. -->

## Approach

<How the approved requirements will be met, in a few sentences.>

## Files to change

| File | Change | Why |
|---|---|---|
| `<path>` | Create / Modify | <requirement ID> |

## Decisions not in the spec

A decision is any value chosen that the spec does not state, including names, defaults, and placeholders.
Test: could a human reasonably want a different value? If Yes, it is a decision.

| Decision | Chosen value | Approved by |
|---|---|---|
| <decision, or None> | <value> | <human name, or pending> |

- This section is "None", or every row is approved by a human before implementation.
- A Risk must not describe a guess. A placeholder or assumption belongs here instead.

## Protected paths touched

<None, or list each path with the human approval reference.>

## Test strategy

| Acceptance criterion | Test |
|---|---|
| AC-1 | <test name and file> |

## Validation

```bash
bash scripts/validate.sh
```

## Risks

- <Risk, or None.>
