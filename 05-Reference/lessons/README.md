---
type: reference-index
updated: 2026-04-21
---

# Lessons Learned

Cross-project lessons, patterns, pitfalls, preferences, and architectural learnings that outlive any single project.

## What belongs here

- **Patterns** — approaches that worked and should be reused (e.g., "rigid 6-bucket project folder template")
- **Pitfalls** — dead-ends and failure modes worth preventing on future projects
- **Preferences** — decisions made once that should persist (e.g., "Lovable for SIS kernel, Claude Code for integration layer")
- **Architecture** — reusable technical decisions (e.g., "Supabase RLS per `tenant_id`")

## What does NOT belong here

- Project-specific context — that's in `01-Projects/<Project>/CONTEXT.md`
- Code recipes — the code itself is the record
- Personal/agent-collaboration preferences — those are in agent memory (`~/.claude/projects/.../memory/`), not the vault

## Naming

`<domain>-<short-slug>.md` — e.g., `lovable-ceiling-for-complex-integrations.md`, `supabase-rls-per-tenant.md`.

## Sources

- **Manual capture** — write directly here when you notice something that'll save time next project
- **gstack `/learn` export** — see [[../../00-System/skills/gstack-learn-integration]] for the sync pattern
- **Post-mortems** — distilled from session summaries and retrospectives

## Index

_(populate as entries land; organize by area/domain once > ~10)_
