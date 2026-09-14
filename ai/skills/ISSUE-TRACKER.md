# Issue Tracker Configuration

This repository uses GitHub Issues and Pull Requests through the `gh` CLI.
Resolve the repository from the current Git remote; do not hard-code a fork.

## Triage role mapping

The skills use canonical roles internally. Apply these repository labels:

| Canonical role | GitHub label |
| --- | --- |
| `bug` | `bug` |
| `enhancement` | `enhancement` |
| `needs-triage` | `status:needs-review` |
| `needs-info` | `status:needs-clarification` |
| `ready-for-agent` | `status:queued` |
| `ready-for-human` | `manual-setup` |
| `wontfix` | `wontfix` |

Treat `status:in-progress`, `status:blocked`, and `status:review` as downstream delivery states, not triage states. Before changing labels, comments, issue state, relationships, or assignees, summarize the intended mutation and obtain the user's confirmation unless their current request already explicitly authorizes that exact mutation.

An external pull request is one whose author is not the repository owner, member, or collaborator. Use the author association exposed by GitHub rather than guessing from the username.

## Wayfinding operations

Wayfinder uses GitHub issues. Prefer GitHub sub-issues and issue dependencies when the available GitHub tooling exposes them; otherwise use explicit linked sections in issue bodies without pretending the relationship is native.

The following labels are required by Wayfinder but are not currently part of the repository label set:

- `wayfinder:map`
- `wayfinder:research`
- `wayfinder:prototype`
- `wayfinder:grilling`
- `wayfinder:task`

On first use, report any missing labels and ask before creating them. Never silently create or rename repository labels.
