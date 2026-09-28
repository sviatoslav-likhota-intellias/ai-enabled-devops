# Spec: health-endpoint

**Status:** Approved <!-- Draft | In Review | Approved | Rejected -->
**Author:** Claude Code (agent)
**Request:** "Add a health endpoint that returns HTTP 200 with status OK."

## Problem

Clients need a way to check that the application is running.
A health endpoint that answers with HTTP 200 and status OK gives them that check.
The application will probably run in Kubernetes later, where such an endpoint is used for probes.

## Scope

- A new Spring Boot application in Java 25, built with Gradle 9.8.0.
- A public `GET /health` endpoint that returns HTTP 200 with JSON body `{"status":"OK"}`.
- Automated tests for the endpoint, run with `gradle test`.

## Out of Scope

- Checks of downstream dependencies (databases, external services).
- Spring Boot Actuator and its `/actuator/health` endpoint.
- Authentication or authorization.
- Custom host or port configuration.
- Containerization and Kubernetes manifests (deployment target not decided).

## Requirements

- **R-1:** A `GET` request to `/health` returns HTTP status code 200.
- **R-2:** The response body of `GET /health` is the JSON object `{"status":"OK"}`.
- **R-3:** The response of `GET /health` has `Content-Type` `application/json`.
- **R-4:** `GET /health` requires no authentication.
- **R-5:** A request to `/health` with any method other than `GET` returns HTTP 405 Method Not Allowed.
- **R-6:** The application listens on Spring Boot's default port `8080` on its default network interfaces.

## Acceptance Criteria

- **AC-1** (covers R-1)
  - **Given** the application is running
  - **When** a client sends `GET /health`
  - **Then** the response has HTTP status code 200
- **AC-2** (covers R-2)
  - **Given** the application is running
  - **When** a client sends `GET /health`
  - **Then** the response body is the JSON object `{"status":"OK"}`
- **AC-3** (covers R-3)
  - **Given** the application is running
  - **When** a client sends `GET /health`
  - **Then** the response `Content-Type` is `application/json`
- **AC-4** (covers R-4)
  - **Given** the application is running
  - **When** a client sends `GET /health` without any credentials
  - **Then** the response has HTTP status code 200
- **AC-5** (covers R-5)
  - **Given** the application is running
  - **When** a client sends `POST /health`
  - **Then** the response has HTTP status code 405
- **AC-6** (covers R-6)
  - **Given** the application is started with no port configuration
  - **When** it finishes starting
  - **Then** it accepts HTTP requests on port `8080`

## Security and Dependencies

- **Secrets:** None.
- **New dependencies:**
  - Java 25 (JDK) — language and runtime, per Q-1.
  - Gradle 9.8.0, via the Gradle Wrapper — build tool, per Q-1.
  - Gradle plugin `org.springframework.boot` 4.1.1 — builds and runs the Spring Boot application.
  - Gradle plugin `io.spring.dependency-management`, version compatible with Spring Boot 4.1.1 — applies Spring Boot's managed dependency versions.
  - Spring Boot web MVC starter, version managed by Spring Boot 4.1.1 — serves HTTP requests.
  - Spring Boot test starters (includes JUnit Jupiter and MockMvc), versions managed by Spring Boot 4.1.1, test scope only — tests the endpoint.
- **Security impact:** Adds one public, unauthenticated, read-only endpoint. It returns a fixed body and exposes no application data.

## Open Questions

- **Q-1:** What technology stack should be used? — **Answer:** Java 25 with Spring Boot 4.1.1, with Gradle 9.8.0.
- **Q-2:** What URL path should the endpoint use? — **Answer:** `/health`.
- **Q-3:** Which HTTP method or methods should it accept? — **Answer:** Only `GET`.
- **Q-4:** What is the exact response format? — **Answer:** JSON `{"status":"OK"}`, `Content-Type` `application/json`.
- **Q-5:** Should the endpoint require authentication? — **Answer:** Public.
- **Q-6:** What port and host should the application listen on? — **Answer:** Default, 8080 and localhost or the default. Recorded as Spring Boot defaults in R-6.
- **Q-7:** What test framework and test command should be used? — **Answer:** JUnit 5 or whatever is relevant for testing REST endpoints; the Gradle test run is the test command. Recorded as JUnit Jupiter with Spring MockMvc, version managed by Spring Boot 4.1.1, run with `./gradlew test`.
- **Q-8:** What is the deployment target? — **Answer:** Not decided; probably Kubernetes. Recorded as out of scope for this change.
- **Q-9:** What should `/health` return for methods other than `GET`? — **Answer:** 405 is fine. Recorded in R-5 and AC-5.

A spec with unanswered Open Questions cannot be `Approved`.
An answer that defines behavior must also appear in Requirements and Acceptance Criteria before approval.

## Human Approval

An agent cannot approve its own specification.

- **Approved by:** Sviatoslav Likhota
- **Date:** 2026-09-28
- **As given:** "spec: Approved — Sviatoslav Likhota, 2026-09-28"
