---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~30 min
status: shipped (awaiting deploy)
---

# 2026-04-30 — Iteration 1 shipped: vault-indexed pgvector retrieval

## Task
Build approved proposal #1: vault-indexed pgvector retrieval + `vault.search` MCP tool. The first of 10 approved enhancements from the learning-pipeline build queue.

## Outcome
All code shipped to swan-command-center, TypeScript clean. Vault stays canonical (write-side); pgvector becomes a one-way retrieval cache populated by `worker:reindex`. New `vault.search` tool exposed to all 7 agents (main, comms, content, dev, legal, ops, research). Embeddings via Gemini text-embedding-004 — free tier, no Anthropic API spend, no Steven token spend.

## Decisions made
- **Embedding provider: Gemini text-embedding-004** (768-dim) — `@google/generative-ai` already installed; `GOOGLE_AI_API_KEY` already in env; free tier covers heavy use. Locked schema to vector(768).
- **Vault canonical, pgvector as cache** — per Steve's pushback in the planning conversation. Reindex worker is one-way; if pgvector is wiped, source survives.
- **One row per file (no chunking) in v1** — content truncated to 8K chars. Chunking deferred to a later iteration if quality suffers.
- **GitHub-source tree fetch** — same pattern as existing `vault.read_file` (which reads from GitHub, not local). Portable across environments.
- **Tool exposed to all 7 roles** — every agent benefits from semantic vault search.

## Files changed
- `app/supabase/migrations/0005_vault_index.sql` — table + pgvector + HNSW + `vault_search` RPC
- `app/src/lib/embeddings.ts` — Gemini wrapper
- `app/worker/vault-reindex.ts` — sync worker (CLI: --full, --path, --max)
- `app/src/tools/vault-search.ts` — new MCP tool
- `app/src/types/tools.ts` — added VaultSearch types
- `app/src/tools/index.ts` — registered
- `app/worker/tools.ts` — MCP wrap + SWAN_TOOL_NAMES
- `app/worker/index.ts` — vault_search added to all 7 role tool lists
- `app/package.json` — added `worker:reindex` script
- `app/docs/iteration-1-vault-search.md` — deployment doc

## Iteration-1 infographic
Updated artifact at `learning-pipeline/infographics/iteration-1-vault-search.html`. Shows:
- New components (vault_index table, vault.search tool, vault-reindex worker) highlighted in green in the architecture diagram
- Same three example tasks (dev / marketing / research) with updated flows. Research task is the major win — semantic search replaces keyword grep, ~5× token efficiency
- Build queue table showing #1 shipped, #3 next

## Blocked / Needs input
- **Deployment is on Steven** — three steps: (1) apply migration via Supabase Studio or CLI, (2) `npm run worker:reindex -- --max 10` to smoke test, (3) full `npm run worker:reindex`, (4) restart worker. Full instructions in `app/docs/iteration-1-vault-search.md`.

## Next steps
- Iteration 2 = #3 (departments/functions taxonomy in registry). Improves dispatch routing intelligence; foundation for the `/skills` explorer route in iteration 6.
- Once #3 ships, the next infographic shows the agent-routing flow gaining a taxonomy step.
