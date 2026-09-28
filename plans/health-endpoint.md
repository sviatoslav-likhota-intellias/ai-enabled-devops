# Plan: health-endpoint

**Spec:** [specs/health-endpoint.md](../specs/health-endpoint.md)
**Spec status:** Approved <!-- Must be Approved before this plan is written. -->

## Approach

Create a single-module Spring Boot 4.1.1 application built with the Gradle 9.8.0 wrapper and a Java 25 toolchain.
A `@RestController` maps `GET /health` to a `HealthResponse` record that Jackson serializes as `{"status":"OK"}`.
No security starter is added, so the endpoint is public, and no port is configured, so Spring Boot's default 8080 applies.
Application code lives under `src/main/java`; tests live under `tests/java`, following the repository folder map.
Spring Boot's BOM is imported with Gradle's `platform()` so no extra dependency-management plugin is needed.

## Files to change

| File | Change | Why |
|---|---|---|
| `settings.gradle.kts` | Create | R-5 |
| `build.gradle.kts` | Create | R-5, R-6 |
| `gradlew`, `gradlew.bat`, `gradle/wrapper/gradle-wrapper.jar`, `gradle/wrapper/gradle-wrapper.properties` | Create | R-5, R-6 |
| `src/main/java/com/example/app/Application.java` | Create | R-4 |
| `src/main/java/com/example/app/health/HealthController.java` | Create | R-1, R-2, R-3 |
| `src/main/java/com/example/app/health/HealthResponse.java` | Create | R-2 |
| `tests/java/com/example/app/health/HealthControllerTest.java` | Create | R-1, R-2, R-3 |
| `tests/java/com/example/app/health/DefaultPortTest.java` | Create | R-4 |
| `.gitattributes` | Modify | Keep `gradlew` LF, `*.bat` CRLF, `*.jar` binary |
| `.gitignore` | Modify | Ignore `build/` and `.gradle/` |
| `AGENTS.md` | Modify | R-6: add `./gradlew test` to validation commands |
| `plans/health-endpoint.md`, `tasks/health-endpoint.md`, `review/health-endpoint.md` | Create | Governance records |

## Protected paths touched

- `AGENTS.md`: add `./gradlew test` under Validation commands.
- `.gitignore`: add `build/` and `.gradle/`.

Approved by Sviatoslav Likhota in the conversation on 2026-09-28: "AGENTS.md and .gitignore changes approved".

## Test strategy

| Acceptance criterion | Test |
|---|---|
| AC-1 | `returnsHttp200` in `tests/java/com/example/app/health/HealthControllerTest.java` |
| AC-2 | `returnsJsonStatusOk` in `tests/java/com/example/app/health/HealthControllerTest.java` |
| AC-3 | `isReachableWithoutCredentials` in `tests/java/com/example/app/health/HealthControllerTest.java` |
| AC-4 | `servesHealthOnDefaultPort8080` in `tests/java/com/example/app/health/DefaultPortTest.java` |
| AC-5 | Inspection of `build.gradle.kts` and `gradle/wrapper/gradle-wrapper.properties`, recorded in the review |
| AC-6 | `./gradlew test` exits `0`, recorded in the review |

## Validation

```bash
bash scripts/validate.sh
./gradlew test
```

## Risks

- `DefaultPortTest` binds real port 8080 and fails if another process is using it.
- The Java package `com.example.app` is a placeholder; renaming it later touches every source file.
