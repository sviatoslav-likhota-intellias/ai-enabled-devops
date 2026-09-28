# Change Review: <feature-name>

**Change:** <commit, branch, or PR link>
**Reviewer:** <name or agent>

Answer every question with **Yes**, **No**, or **Not applicable**.
Every answer needs evidence: a link, command output, or file reference.
An answer without evidence counts as **No**.

| # | Question | Expected evidence | Answer | Evidence |
|---|---|---|---|---|
| 1 | Is an approved specification linked? | Link to the spec with Status `Approved` and the approver's name | | |
| 2 | Is the change within scope? | `git diff --stat main` output matches the plan's "Files to change" | | |
| 3 | Are acceptance criteria covered by tests? | Each AC ID mapped to a test name and file | | |
| 4 | Did validation pass? | `bash scripts/validate.sh` output and exit code `0` | | |
| 5 | Are secrets absent? | `git diff main \| grep -inE "password\|secret\|token\|api[_-]?key\|BEGIN .*PRIVATE KEY"` returns no matches | | |
| 6 | Are dependencies justified? | "None added", or a link to the spec's dependency entry | | |
| 7 | Are protected paths unchanged or approved? | `git diff --stat main` lists no protected path, or a link to the approval | | |
| 8 | Are relevant documents updated? | Changed doc files, or "Not applicable" with the reason | | |

## Result

- **Ready to merge:** <Yes only if no answer is No.>
- **Required fixes:** <None, or list.>
