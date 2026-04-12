# Reference: Zaucha DevOps Playbook

**Source:** Ryan Zaucha (colleague)
**Date received:** 2026-04-12
**Full document:** See original files (not stored in vault to avoid duplication)

---

## Key Principles Adopted

1. **Enforcement beats instruction.** If a behavior matters, enforce it with a hook/gate. Don't ask — block.
2. **Shared config repo.** One repo, symlinked everywhere. This vault IS the shared config.
3. **Three environments.** Dev/preview/production on every project. Preview URL is the approval gate.
4. **75% done problem.** AI agents report complete at 75%. Always verify end-to-end.
5. **Don't build observers.** Every automation either acts or doesn't get built. No dashboard-only monitoring.
6. **Flush stale knowledge.** Delete outdated info completely. No warning labels.
7. **Spec → Plan → QA Runbook → QA Results.** The workflow that kills the last-mile problem.
8. **Skills on second use.** Write a skill the second time you do something, not the first or tenth.

## Applied In This Vault

- Core rules (`/00-System/rules/core-rules.md`) encode principles 1, 4, 5, 6, 8
- Session summary template enforces principle 4 (verification evidence required)
- QA runbook template enforces principle 7
- Vault write system enforces principle 2 (session summary = non-optional)
- Daily rollup is actionable (principle 5) — surfaces items needing Steven's decision
