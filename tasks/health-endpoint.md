# Tasks: health-endpoint

**Spec:** [specs/health-endpoint.md](../specs/health-endpoint.md)
**Plan:** [plans/health-endpoint.md](../plans/health-endpoint.md)

Each task is small, ordered, and done only when its check is Yes.

| # | Task | Covers | Done when | Done? |
|---|---|---|---|---|
| 1 | Get human approval for plan decisions D-1 to D-11, D-3a, and the D-4 doc edits | — | Every row in the plan's **Decisions not in the spec** names an approver | Yes |
| 2 | Create Gradle build files and wrapper | R-1 to R-6 | `./gradlew --version` reports Gradle 9.8.0 | Yes |
| 3 | Update `.gitignore` and `.gitattributes` | — | `git status` shows no `build/` or `.gradle/` files | Yes |
| 4 | Write tests for AC-1 to AC-5 | AC-1 to AC-5 | Tests exist and fail before the controller exists | Yes |
| 5 | Write test for AC-6 | AC-6 | Test exists in `ApplicationPortTest.java` | Yes |
| 6 | Create `Application` and `HealthController` | R-1 to R-6 | `./gradlew test` passes | Yes |
| 7 | Add `./gradlew test` to AGENTS.md Validation commands | — | AGENTS.md lists the command | Yes |
| 8 | Run validation | — | `bash scripts/validate.sh` and `./gradlew test` exit 0 | Yes |
| 9 | Complete review checklist | — | `review/health-endpoint.md` filled in for this change | Yes |
