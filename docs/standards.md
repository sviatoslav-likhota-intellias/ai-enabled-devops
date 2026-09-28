# Standards

Conventions for every change. Each has one good and one bad example.

## Naming

- Files and folders use lowercase `kebab-case`.
- Specs, plans, and tasks for one feature share the same name.

| Good | Bad |
|---|---|
| `specs/version-endpoint.md`, `plans/version-endpoint.md` | `specs/VersionEndpoint_v2 FINAL.md` |

## Change submission

- One change implements one approved spec.
- Commit messages are imperative and name the change.
- The review checklist is completed before submitting.

| Good | Bad |
|---|---|
| `Add version endpoint (specs/version-endpoint.md)` | `fixes and stuff` |

## Documentation

- Every new behavior is described in its spec.
- Documents stay short and focused on one topic.
- Links use relative paths.

| Good | Bad |
|---|---|
| `See [standards](docs/standards.md).` | `See the standards doc somewhere on the wiki.` |

## Dependencies

- A new dependency requires approval in a spec's **Security and dependencies** section.
- The reason and version are recorded.

| Good | Bad |
|---|---|
| Spec lists: "HTTP library, pinned version 4.19.2 — needed to serve requests. Approved by J. Doe." | Agent installs a utility package because it was convenient, with no spec entry. |

## Security

- No secrets in files, commits, logs, or chat.
- Secrets are referenced by environment variable name.

| Good | Bad |
|---|---|
| `token = env("API_TOKEN")` | `token = "sk-live-12ab34cd..."` |

## Testing

- Each Given/When/Then acceptance criterion has at least one test.
- Tests are never deleted, skipped, or weakened to make validation pass.

| Good | Bad |
|---|---|
| Test `returns 200 with status OK` covers criterion AC-1. | Marking a failing test as `skip` to get green validation. |
