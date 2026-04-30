---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~25 min
status: shipped (awaiting worker restart)
---

# 2026-04-30 — Iteration 2 shipped: departments/functions taxonomy

## Task
Build approved proposal #3: tag every SCC tool with department + function + tags so the main agent can route intelligently and the future /skills explorer (#5) has structured data to render.

## Outcome
Extended ToolDefinition with three optional fields (`departments`, `functions`, `tags`). Tagged all 37 tool definitions across 21 files (~120 taxonomy assignments). Added query helpers (listToolsByDepartment / listToolsByFunction / listToolsByTag / findCapabilities) and a new `registry.list_capabilities` MCP tool that any agent can call to introspect. Strengthened main.md with explicit guidance: introspect the registry before guessing tool names. TypeScript clean.

## Decisions made
- **Departments match the 7 agent roles** — main, research, comms, content, ops, legal, dev. Universal tools (vault.*, classify, hive_query, registry.list_capabilities) tag all 7.
- **8 functions** — read, write, search, classify, dispatch, generate, execute, ask. Search separated from read because routing logic differs ("find me X" vs. "read this file").
- **Free-form tags** for the unbounded axis (gmail, stripe, vault, github, slack, etc.). Keeps the type system clean while letting the registry stay queryable on side concerns.
- **Untagged tools are universal** — `findCapabilities` treats absence of `departments` as "any". Backwards compatible.
- **Main agent gets registry.list_capabilities** in its allowlist + prompt guidance. It introspects rather than guesses.

## Files changed
- `app/src/tools/registry.ts` — Department + ToolFunction types, query helpers
- `app/src/tools/registry-list.ts` — NEW · registry.list_capabilities tool
- `app/src/tools/*.ts` (21 files) — taxonomy fields added to all 37 tools
- `app/src/types/tools.ts` — ListCapabilities types
- `app/src/tools/index.ts` — register registry-list
- `app/worker/tools.ts` — MCP wrap + SWAN_TOOL_NAMES
- `app/worker/index.ts` — registry_list_capabilities in all 7 role lists
- `app/src/agents/main.md` — new "Taxonomy-aware routing" section

## Iteration-2 infographic
`learning-pipeline/infographics/iteration-2-taxonomy.html` — shows the new taxonomy grid (7 departments, 8 functions), updated architecture diagram with the registry layer highlighted, and three example flows (dev/marketing/research) updated to show main introspecting the registry before delegating.

## Blocked / Needs input
- Deploy: single step — restart worker (`launchctl kickstart -k gui/$(id -u)/com.swan.command-worker`).

## Next steps
- Iteration 3 = #2 (hive-mind task-log shared memory). Adds a queryable cross-agent task log so any agent can ask "what has X been doing?". Foundation for /dashboard/morning (#4) widget showing yesterday-across-the-team.
