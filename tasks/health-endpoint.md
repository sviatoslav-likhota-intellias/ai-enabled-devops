# Tasks: health-endpoint

**Spec:** [specs/health-endpoint.md](../specs/health-endpoint.md)
**Plan:** [plans/health-endpoint.md](../plans/health-endpoint.md)

Each task is small, ordered, and done only when its check is Yes.

| # | Task | Covers | Done when | Done? |
|---|---|---|---|---|
| 1 | Generate Gradle 9.8.0 wrapper and build files | R-5 | `./gradlew --version` reports Gradle 9.8.0 | Yes |
| 2 | Add `build/` and `.gradle/` to `.gitignore`; wrapper rules to `.gitattributes` | — | `git status` shows no build output | Yes |
| 3 | Write tests for AC-1 to AC-4 | AC-1, AC-2, AC-3, AC-4 | Tests exist and fail before implementation | Yes |
| 4 | Implement application, controller, and response record | R-1, R-2, R-3, R-4 | `./gradlew test` exits 0 | Yes |
| 5 | Add `./gradlew test` to `AGENTS.md` validation commands | R-6 | `AGENTS.md` lists the command | Yes |
| 6 | Run validation | — | `bash scripts/validate.sh` and `./gradlew test` exit 0 | Yes |
| 7 | Complete review checklist | — | `review/health-endpoint.md` filled in for this change | Yes |
