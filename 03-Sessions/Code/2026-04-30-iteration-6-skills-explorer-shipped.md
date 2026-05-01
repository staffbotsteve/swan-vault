---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~25 min
status: shipped (no migration; rebuild + restart to deploy)
---

# 2026-04-30 — Iteration 6 shipped: /skills explorer route

## Task
Build approved proposal #5: auto-indexed view of every installed capability — Claude Code user skills, plugin skills (gstack/superpowers/codex/caveman), SCC tools, SCC agents — with the iter-2 taxonomy rendered as visual filters.

## Outcome
New `/skills` route in swan-command-center with searchable, filterable card grid. Aggregator at `/api/skills` returns the unified inventory; `lib/skills-discovery.ts` walks `~/.claude/skills/`, the plugin cache, the in-process tool registry, and the agents directory in parallel. Last-used timestamps for SCC tools/agents joined from the tasks table.

## Decisions made
- **Filesystem walks for CC + plugins; in-process registry for SCC** — avoids duplicating data; the tool registry already has the full iter-2 taxonomy attached.
- **Light frontmatter parser** — wrote a tiny YAML extractor in skills-discovery.ts (handles single-line scalars, quoted strings, multi-line `|` blocks). Avoids adding a yaml package dep for this single use case.
- **Three-source filter UI** — kind (user/plugin/scc-tool/scc-agent), source (specific plugin or "user" or "swan-command-center"), department. Plus search. Layered, all client-side over the in-memory inventory.
- **Recurses one extra level into plugin caches** — caveman has nested layout; the simple `cache/<mkt>/<plg>/skills/` pattern misses it. Walk pattern handles `cache/<mkt>/<plg>/<version>/skills/<name>/`.
- **Last-used only for SCC** — Claude Code skills have no telemetry stream into our DB, so we can`t timestamp them. Reasonable v1 limitation.

## Files changed
- `app/src/lib/skills-discovery.ts` — new
- `app/src/app/api/skills/route.ts` — new
- `app/src/app/skills/page.tsx` — new
- `app/src/components/Header.tsx` — Skills added to NAV

## Iteration-6 infographic
`learning-pipeline/infographics/iteration-6-skills-explorer.html` — UI mock showing the filterable card grid, architecture diagram with the new route highlighted.

## Blocked / Needs input
- Steve to test at http://localhost:3000/skills (after `npm run dev` or rebuild).

## Next steps
- Iteration 7 = #7 (doc-parse grounding rules). Refactor existing doc-parse tool to enforce blank-with-reason / asymmetric cost / source-quote evidence on extracted fields, return audit table. Mission-critical for Silvercrest construction-loan workflows.
