# Plan: health-endpoint

**Spec:** [specs/health-endpoint.md](../specs/health-endpoint.md)
**Spec status:** Approved <!-- Must be Approved before this plan is written. -->

## Approach

Create a minimal Spring Boot 4.1.1 application built by a Gradle 9.8.0 wrapper at the repository root.
One `@RestController` maps `GET /health` and returns `{"status":"OK"}` as `application/json`.
Spring MVC's default handling returns 405 for other methods, and no security starter is added, so the endpoint is public.
No server configuration is added, so Spring Boot's default port `8080` applies.
Tests use JUnit Jupiter with MockMvc for AC-1 to AC-5, and a real HTTP call to port `8080` for AC-6.

## Files to change

| File | Change | Why |
|---|---|---|
| `settings.gradle.kts` | Create | R-1 to R-6 (build setup) |
| `build.gradle.kts` | Create | R-1 to R-6 (build setup, dependencies from spec) |
| `gradlew`, `gradlew.bat`, `gradle/wrapper/gradle-wrapper.jar`, `gradle/wrapper/gradle-wrapper.properties` | Create | Gradle 9.8.0 wrapper (spec Q-1, Q-7) |
| `src/main/java/com/intellias/aidevops/Application.java` | Create | R-6 |
| `src/main/java/com/intellias/aidevops/health/HealthController.java` | Create | R-1 to R-5 |
| `src/test/java/com/intellias/aidevops/health/HealthControllerTest.java` | Create | AC-1 to AC-5 |
| `src/test/java/com/intellias/aidevops/ApplicationPortTest.java` | Create | AC-6 |
| `tests/README.md` | Create | D-4: points to `src/test/java` for Java tests |
| `.gitignore` | Modify | Ignore `build/` and `.gradle/` |
| `.gitattributes` | Modify | Keep `gradlew` LF, `*.bat` CRLF, `*.jar` binary |
| `AGENTS.md` | Modify | Add `./gradlew test` to Validation commands (spec Q-7); D-4: folder map rows for `src/` and `tests/` |
| `CONTRIBUTING.md` | Modify | D-4: say where Java tests go |
| `tasks/health-endpoint.md` | Create | Task breakdown |
| `review/health-endpoint.md` | Create | Review checklist for this change |

## Decisions not in the spec

A decision is any value chosen that the spec does not state, including names, defaults, and placeholders.
Test: could a human reasonably want a different value? If Yes, it is a decision.

| Decision | Chosen value | Approved by |
|---|---|---|
| D-1 Build script language | Gradle Kotlin DSL (`build.gradle.kts`, `settings.gradle.kts`) at the repository root | Sviatoslav Likhota, 2026-09-28 |
| D-2 Gradle project name (artifactId) | `aidevops` (replaces the earlier `ai-enabled-devops`) | Sviatoslav Likhota, 2026-09-28 |
| D-3 Base Java package | `com.intellias.aidevops` | Sviatoslav Likhota, 2026-09-28 |
| D-3a Gradle `group` (groupId) | `com.intellias` | Sviatoslav Likhota, 2026-09-28 |
| D-4 Source layout | Standard Spring Boot layout: code in `src/main/java`, tests in `src/test/java`. `tests/README.md` points there; `CONTRIBUTING.md` and the `AGENTS.md` folder map are updated to match | Layout: Sviatoslav Likhota, 2026-09-28. Protected doc edits: Sviatoslav Likhota, 2026-09-28 |
| D-5 Class names | `Application`, `HealthController`, `HealthControllerTest`, `ApplicationPortTest` | Sviatoslav Likhota, 2026-09-28 |
| D-6 Response body type | `Map.of("status", "OK")` serialized by Spring's default JSON support | Sviatoslav Likhota, 2026-09-28 |
| D-7 Spring Boot version management | Gradle `platform(SpringBootPlugin.BOM_COORDINATES)` instead of the `io.spring.dependency-management` plugin (one plugin fewer, no unpinned plugin version) | Sviatoslav Likhota, 2026-09-28 |
| D-8 Starter artifacts | `spring-boot-starter-webmvc`; test scope `spring-boot-starter-webmvc-test` (Spring Boot 4 names) | Sviatoslav Likhota, 2026-09-28 |
| D-9 Java version | Gradle Java toolchain `languageVersion = 25` | Sviatoslav Likhota, 2026-09-28 |
| D-10 Gradle wrapper | Generate with `gradle wrapper --gradle-version 9.8.0 --distribution-type bin` using the Gradle 9.8.0 already cached locally, and commit the wrapper files | Sviatoslav Likhota, 2026-09-28 |
| D-11 AC-6 test method | `@SpringBootTest(webEnvironment = DEFINED_PORT)` with the JDK `java.net.http.HttpClient` calling `http://localhost:8080/health` (no extra dependency) | Sviatoslav Likhota, 2026-09-28 |

- This section is "None", or every row is approved by a human before implementation.
- A Risk must not describe a guess. A placeholder or assumption belongs here instead.

## Protected paths touched

- `AGENTS.md`: add `./gradlew test` under **Validation commands**.
  Approved by Sviatoslav Likhota in the conversation on 2026-09-28: "approve AGENTS.md test command change".
- `AGENTS.md`: update the folder map rows for `src/` and `tests/` (D-4).
  Approved by Sviatoslav Likhota in the conversation on 2026-09-28: "2. approve".
- `CONTRIBUTING.md`: say where Java tests go (D-4).
  Approved by Sviatoslav Likhota in the conversation on 2026-09-28: "1. approve".

## Test strategy

| Acceptance criterion | Test |
|---|---|
| AC-1 | `getHealthReturns200` in `src/test/java/com/intellias/aidevops/health/HealthControllerTest.java` |
| AC-2 | `getHealthReturnsStatusOkBody` in `src/test/java/com/intellias/aidevops/health/HealthControllerTest.java` |
| AC-3 | `getHealthReturnsJsonContentType` in `src/test/java/com/intellias/aidevops/health/HealthControllerTest.java` |
| AC-4 | `getHealthWithoutCredentialsReturns200` in `src/test/java/com/intellias/aidevops/health/HealthControllerTest.java` |
| AC-5 | `postHealthReturns405` in `src/test/java/com/intellias/aidevops/health/HealthControllerTest.java` |
| AC-6 | `acceptsRequestsOnDefaultPort8080` in `src/test/java/com/intellias/aidevops/ApplicationPortTest.java` |

## Validation

```bash
bash scripts/validate.sh
./gradlew test
```

## Risks

- The AC-6 test binds port `8080`. It fails if another process already uses that port on the test machine.
