---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~25 min
status: shipped (batched deploy with iter 2 — pending one migration + worker restart)
---

# 2026-04-30 — Iteration 3 shipped: hive-mind task-log shared memory

## Task
Build approved proposal #2: cross-agent visibility layer so any SCC agent can answer "what has X been doing?" without parsing JSONB output dumps.

## Outcome
Reused the existing `tasks` table (already the cross-agent ledger) instead of creating a duplicative `hive_log` table. Migration 0006 adds `summary text` + `tags text[]` columns. Worker now auto-fills `summary` on task completion (first sentence, capped at 200 chars). New `hive.recent_summary` tool returns rollups grouped by agent: total + per-agent count + scannable summaries. TypeScript clean.

## Decisions made
- **No new table** — `tasks` already serves the role. Two new columns + a partial index is the right surface.
- **Auto-summarization at task completion** — worker extracts first sentence (no Haiku call). Heuristic, but token-free and adequate for "scannable".
- **Two complementary read tools** — `hive.query` (existing, full task rows for one filter) vs. `hive.recent_summary` (new, cross-agent rollup with summaries). Different jobs.
- **Role extraction from agent_id** — agent_ids in `tasks` are role-prefixed strings like `agent_research_v1`. Extract the role token (research/comms/ops/etc.) and bucket by it.
- **Tagged in iteration-2 taxonomy** — `hive.recent_summary` registered with departments=all 7, function=search, tags=[supabase,memory,task-log,hive].
- **Main agent prompt strengthened** — explicit guidance to call `hive.recent_summary` on "what has the team been doing" / "what did X do today" questions.

## Files changed
- `app/supabase/migrations/0006_tasks_summary.sql` — new migration · 2 columns + partial index + GIN tag index
- `app/src/tools/hive-recent.ts` — new tool
- `app/src/types/tools.ts` — HiveRecentSummary types
- `app/src/tools/index.ts` — register
- `app/worker/tools.ts` — MCP wrap + SWAN_TOOL_NAMES
- `app/worker/index.ts` — summarizeOutput helper · summary write on completion · hive_recent_summary in all 7 role lists
- `app/src/agents/main.md` — added guidance for "what has X been doing" pattern

## Iteration-3 infographic
`learning-pipeline/infographics/iteration-3-hive-mind.html` — sample output of `hive.recent_summary`, updated architecture with hive-mind layer highlighted, three example flows (dev/marketing/research) showing duplicate-detection, in-flight visibility, and citation chains.

## Blocked / Needs input
- Steve will deploy iter 2 + iter 3 together: (1) paste 0006_tasks_summary.sql into Supabase Studio · (2) restart worker. Per his "we will deploy after iteration 3" instruction.

## Next steps
- Iteration 4 = #10 (model-routing yaml + Codex plugin install). Per the Mark Kashef video ingested earlier, this is two layers: install OpenAI codex-plugin-cc for native Claude+Codex coexistence, then routing.yaml for non-coding model decisions.
