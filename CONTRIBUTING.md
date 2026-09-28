# Contributing

Every change, by a human or an agent, follows this flow:

```
request → specification → human approval → plan → tasks → implementation → validation → review
```

Follow [constitution.md](constitution.md) and [docs/standards.md](docs/standards.md) throughout.

## 1. Write and approve a specification

1. Copy [specs/TEMPLATE.md](specs/TEMPLATE.md) to `specs/<feature-name>.md`.
   The [spec-generator](skills/spec-generator/SKILL.md) skill can draft it.
2. Set **Status** to `Draft`. Fill in every section.
3. Put anything unclear in **Open Questions**. Do not guess.
4. Set **Status** to `In Review` and ask a human to review.
5. The human answers open questions, then approves or rejects the spec by either:
   - stating it in the conversation with their name and date, for example
     "Approved, Jane Doe, 2026-01-10", so the agent records it exactly as given; or
   - editing **Status** and **Human Approval** in the file themselves.

An agent never approves its own spec. Do not continue until Status is `Approved`.
See [AGENTS.md](AGENTS.md#approvals) for all approval rules.

## 2. Create a plan and tasks

1. Copy [plans/TEMPLATE.md](plans/TEMPLATE.md) to `plans/<feature-name>.md`.
   Map each acceptance criterion to a test.
   The [test-plan-generator](skills/test-plan-generator/SKILL.md) skill can help.
2. Copy [tasks/TEMPLATE.md](tasks/TEMPLATE.md) to `tasks/<feature-name>.md`.
   Break the plan into small, ordered tasks.

## 3. Implement and test approved scope

1. Change only the files listed in the plan.
2. Write tests for every acceptance criterion in `tests/`.
3. Put application code in `src/`.
4. Do not add unapproved dependencies or touch protected paths (see [AGENTS.md](AGENTS.md)).
5. If something new comes up, stop and update the spec's Open Questions.

## 4. Validate and submit a change

1. Run validation from the repository root:

   ```bash
   bash scripts/validate.sh
   ```

   It must exit with code `0`.
2. Copy [review/change-template.md](review/change-template.md) and answer every question with evidence.
   The [pr-reviewer](skills/pr-reviewer/SKILL.md) skill can fill it in.
3. Commit using the format in [docs/standards.md](docs/standards.md#change-submission).
4. Submit the change with the completed review checklist attached.
