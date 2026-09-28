# AGENTS.md

Canonical instructions for any AI coding agent working in this repository.
These rules apply regardless of the agent platform or vendor.

## Purpose

This repository is a governed foundation for AI-assisted development.
Every change follows a specification approved by a human.

## Folder map

| Path | Contents |
|---|---|
| `AGENTS.md` | This file. Rules for agents. |
| `CLAUDE.md` | Pointer to this file for Claude Code. No rules of its own. |
| `README.md` | Project overview for humans. |
| `CONTRIBUTING.md` | How to propose, build, and submit a change. |
| `constitution.md` | Seven guiding principles. |
| `docs/standards.md` | Naming, submission, docs, dependency, security, testing conventions. |
| `specs/` | Specifications. `TEMPLATE.md` is the blank form. |
| `plans/` | Implementation plans. `TEMPLATE.md` is the blank form. |
| `tasks/` | Task breakdowns. `TEMPLATE.md` is the blank form. |
| `review/` | `change-template.md`, the review checklist. |
| `skills/` | Reusable AI skills, one folder per skill with `SKILL.md`. |
| `skill-runs/` | One reference run per skill. Not updated for normal changes. |
| `scripts/` | Validation scripts. |
| `src/` | Application code. Empty until an approved spec. |
| `tests/` | Tests. Empty until an approved spec. |

## Validation commands

Run from the repository root:

```bash
bash scripts/validate.sh
```

A change is valid only when the command exits with code `0`.
Once a technology stack is approved, its test command is added here.

## Governance documents

- [README.md](README.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [constitution.md](constitution.md)
- [docs/standards.md](docs/standards.md)
- [specs/TEMPLATE.md](specs/TEMPLATE.md)
- [plans/TEMPLATE.md](plans/TEMPLATE.md)
- [tasks/TEMPLATE.md](tasks/TEMPLATE.md)
- [review/change-template.md](review/change-template.md)
- [skills/spec-generator/SKILL.md](skills/spec-generator/SKILL.md)
- [skills/pr-reviewer/SKILL.md](skills/pr-reviewer/SKILL.md)
- [skills/test-plan-generator/SKILL.md](skills/test-plan-generator/SKILL.md)

## Required rules

Each rule is answerable with Yes or No.

1. Is there an approved specification before any feature implementation? Must be **Yes**.
2. Did applicable validation run and pass before submitting? Must be **Yes**.
3. Are any secrets exposed, or are security checks or tests weakened? Must be **No**.
4. Was a protected path modified without explicit human approval? Must be **No**.
5. Were unclear requirements guessed instead of asked? Must be **No**.
6. Did the agent approve its own specification? Must be **No**.

## Approvals

An approval is valid only if a human gives it in the conversation or edits the file themselves.

| What | Valid approval | Recorded in |
|---|---|---|
| Spec | Human states approval with their name and date | The spec's **Human Approval** section, copied exactly as given |
| Protected path change | Human approves that specific path and change | The plan's **Protected paths touched** section |

- Never invent, assume, or reuse an approval.
- Approving a spec does not approve protected path changes.
- "Looks fine" without a name and date is not a spec approval. Ask for both.

## Skill runs

- `skill-runs/<skill-name>.md` holds one reference run per skill.
- Do not add skill runs for normal changes. Skill output goes to `specs/`, `plans/`, or `review/`.
- Re-record a skill's run only when its `SKILL.md` changes.

## Protected paths

Protected paths define how changes are specified, verified, and approved.
They are protected so a change cannot make itself easier by editing its own rules.

Do not create, modify, or delete these without explicit human approval in the conversation:

- `AGENTS.md`, `CLAUDE.md`
- `constitution.md`
- `CONTRIBUTING.md`
- `docs/standards.md`
- `specs/TEMPLATE.md`, `plans/TEMPLATE.md`, `tasks/TEMPLATE.md`
- `review/change-template.md`
- `skills/**`
- `scripts/**`
- Any spec whose Status is `Approved`

## Secret handling

- Never commit secrets, tokens, passwords, keys, or `.env` files.
- Never print secret values in chat, logs, or files.
- Reference secrets only by variable name, for example `API_TOKEN`.
- If a secret is found in the repository, stop and tell a human.

## Stop and ask a human when

- A requirement is ambiguous, missing, or contradictory.
- A technology, framework, or dependency is not specified.
- A change would touch a protected path.
- A specification is not `Approved`.
- Validation fails and the fix would change scope, tests, or security.
- The task would add a new dependency.
- You are about to make a decision the spec does not state.
  See the definition in [plans/TEMPLATE.md](plans/TEMPLATE.md#decisions-not-in-the-spec).

When stopping, record the question in the spec's **Open Questions** section,
or in the plan's **Decisions not in the spec** section, and wait.
