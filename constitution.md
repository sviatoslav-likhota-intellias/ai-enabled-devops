# Constitution

Seven principles that govern every change. When rules conflict, these win.

## 1. Specification before implementation

No code is written until a human has approved a specification for it.
In practice, this means an agent's first output for a new request is a Draft spec in `specs/`, never code.

## 2. Simplicity

Choose the smallest solution that meets the approved requirements.
In practice, this means no extra features, abstractions, or dependencies beyond what the spec asks for.

## 3. Verifiable quality

A change is done only when it is proven by tests and passing validation.
In practice, this means every acceptance criterion maps to a test and `bash scripts/validate.sh` exits with `0`.

## 4. Security by default

Changes must never expose secrets or weaken existing protections.
In practice, this means no secrets in files or logs, and no disabled, skipped, or loosened tests or checks.

## 5. Documented decisions

Every meaningful decision is written down where the next reader will find it.
In practice, this means choices and their reasons are recorded in the spec, plan, or review, not only in chat.

## 6. Human control of ambiguity

Humans resolve uncertainty; agents do not guess.
In practice, this means unclear points go into the spec's Open Questions and work stops until a human answers.

## 7. Focused changes

Each change does one approved thing.
In practice, this means a change touches only files needed for its spec and never unapproved protected paths.
