# Spec: health-endpoint

**Status:** Approved <!-- Draft | In Review | Approved | Rejected -->
**Author:** Claude (spec-generator skill)
**Request:** "Add a health endpoint that returns HTTP 200 with status OK."

## Problem

Clients need a health endpoint that confirms the application is up by returning HTTP 200 with status OK.

## Scope

- A Java 25 / Spring Boot 4.1.1 application built with Gradle 9.8.0.
- One public endpoint, `GET /health`, that returns HTTP 200 with JSON body `{"status":"OK"}`.
- Automated tests for the endpoint, run with `./gradlew test`.

## Out of Scope

- Checks of downstream dependencies (databases, external services).
- Spring Boot Actuator and its `/actuator/health` endpoint.
- Authentication or authorization.
- Kubernetes manifests, container images, and other deployment configuration.
- Any other endpoint or behavior not stated in the request.

## Requirements

- **R-1:** `GET /health` returns HTTP status code 200.
- **R-2:** The response body of `GET /health` is the JSON object `{"status":"OK"}` with content type `application/json`.
- **R-3:** `GET /health` is reachable without authentication.
- **R-4:** The application listens on Spring Boot's default port, 8080, with the default bind address.
- **R-5:** The application uses Java 25 and Spring Boot 4.1.1, and builds with the Gradle wrapper pinned to Gradle 9.8.0.
- **R-6:** `./gradlew test` runs the endpoint tests and exits with code `0` when they pass.

## Acceptance Criteria

- **AC-1** (covers R-1)
  - **Given** the application is running
  - **When** a client sends `GET /health`
  - **Then** the response has HTTP status code 200
- **AC-2** (covers R-2)
  - **Given** the application is running
  - **When** a client sends `GET /health`
  - **Then** the response content type is `application/json` and the body is `{"status":"OK"}`
- **AC-3** (covers R-3)
  - **Given** the application is running
  - **When** a client sends `GET /health` with no credentials
  - **Then** the response has HTTP status code 200
- **AC-4** (covers R-4)
  - **Given** the application is started with no port configured
  - **When** a client sends `GET /health` to port 8080
  - **Then** the response has HTTP status code 200
- **AC-5** (covers R-5)
  - **Given** the repository is checked out
  - **When** the build files and Gradle wrapper properties are inspected
  - **Then** they declare Java 25, Spring Boot 4.1.1, and Gradle 9.8.0
- **AC-6** (covers R-6)
  - **Given** the repository is checked out with JDK 25 available
  - **When** `./gradlew test` runs
  - **Then** the tests for AC-1 to AC-4 run and the command exits with code `0`

## Security and Dependencies

- **Secrets:** None.
- **New dependencies:**
  - Gradle 9.8.0, via the Gradle wrapper — build tool.
  - Spring Boot Gradle plugin 4.1.1 — builds and runs the application.
  - Spring Boot web MVC starter 4.1.1 — serves HTTP requests.
  - Spring Boot test starters 4.1.1 (JUnit Jupiter and Spring MVC test support, versions managed by Spring Boot 4.1.1) — tests the endpoint.
- **Security impact:** Adds one public, unauthenticated endpoint that returns a fixed value and exposes no application data.

## Open Questions

- **Q-1:** What technology stack should be used? — **Answer:** Java 25 with Spring Boot 4.1.1, with Gradle 9.8.0.
- **Q-2:** What URL path and HTTP method should the endpoint use? — **Answer:** `GET /health`.
- **Q-3:** What exact response body and content type should represent "status OK"? — **Answer:** JSON `{"status":"OK"}`.
- **Q-4:** What test framework and test command should be used? — **Answer:** JUnit 5 or whatever is relevant for testing REST endpoints; the Gradle test run is the test command.
- **Q-5:** Does the endpoint require authentication? — **Answer:** Public.
- **Q-6:** What is the deployment target, and on which host and port should the app listen? — **Answer:** Keep the default, 8080 on localhost; not decided, but it will probably run in Kubernetes.

A spec with unanswered Open Questions cannot be `Approved`.
An answer that defines behavior must also appear in Requirements and Acceptance Criteria before approval.

## Human Approval

An agent cannot approve its own specification.

- **Approved by:** Sviatoslav Likhota
- **Date:** 2026-09-28
- **Approval as given:** "Approved — Sviatoslav Likhota, 2026-09-28"
