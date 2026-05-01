---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~30 min
status: shipped
---

# 2026-04-30 — Iteration 8 shipped: /research route chain (with NotebookLM)

## Task
Build approved proposal #6: route that chains existing tools (vault.search, notebooklm, youtube.search, vault.write) into one /research request.

## Outcome
New /research page + /api/research orchestrator. Six-step pipeline:

1. vault.search — prior work on the topic
2. notebooklm.search — match topic to Steven`s curated notebooks by title
3. notebooklm.ask × N — query top 1-2 notebooks
4. youtube.search — surface video source candidates
5. synthesize (Gemini Flash) — draft a wiki entry citing all 3 source blocks
6. vault.write_file — save to 02-Areas/Research/<slug>-<YYYY-MM>.md

Per-step audit (status, duration_ms, summary, details) returned in the response. Steven sees a 6-dot pipeline indicator in the UI plus a GitHub link to the output file.

## Decisions made
- **Course correction mid-iteration** — first version deferred NotebookLM to "8.1". Steven flagged it as missing. Per his earlier "non-negotiable" directive, NotebookLM IS in the chain on every research run. Synthesis explicitly notes when no notebook matched.
- **Reuse registered tools via getTool()** — the orchestrator calls each tool`s handler directly through the in-process registry. No re-implementation, no API hop.
- **maxDuration: 120s** — chain typically completes in 60-120s (NotebookLM is the long pole). Vercel/Next default is 10s for serverless; bumped explicitly.
- **Sequential NotebookLM calls** — CLI doesn`t handle parallel `ask` calls reliably. Top 2 candidates queried in sequence.
- **Synthesis prompt prioritizes NotebookLM** — explicit "highest signal" framing for citations from Steven`s curated notebooks. Vault next, YouTube last (titles only).

## Files changed
- `app/src/app/api/research/route.ts` — new
- `app/src/app/research/page.tsx` — new
- `app/src/components/Header.tsx` — added "Research" to NAV

## Iteration-8 infographic
`learning-pipeline/infographics/iteration-8-research-chain.html` — 6-step pipeline visualization, architecture diagram, sequence diagram of a real run.

## Blocked / Needs input
- Test at http://localhost:3000/research with a real topic (e.g. "Karpathy autoresearch pattern" or "Claude Routines for SOPs"). Output lands in swan-vault/02-Areas/Research/.

## Out of scope (8.1 if useful)
- NotebookLM mind-map / audio overview generation — CLI calls take 30-90s each and are flaky on cold sessions
- Streaming progress updates — current chain returns one shot when done; could SSE-stream per-step status if latency feels long
- /research as MCP tool — currently route-only; expose to research agent if useful

## Next steps
- Iteration 9 = #8 (Remote Claude Code routines). Scheduling spine — directly enables the daily Gmail-scanner feature you asked for early in this session, plus morning brief, end-of-day vault sync, weekly retro.
