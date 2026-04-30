---
date: 2026-04-30
source: Claude Code
project: learning-pipeline
duration: ~90 min
status: review queue ready
---

# 2026-04-30 — Categorization complete: 153 transcripts → 115 proposals

## Task
Categorize the 153 ingested YouTube transcripts and generate concrete action proposals (skills, plugins, agents, command-center routes, scaffolding, settings) for Steven's AI architecture, structured for thumbs-up/down review.

## Outcome
All 153 transcripts categorized via 5 parallel general-purpose subagents (token-only, no API key). 123 raw proposals produced; aggregator deduplicated convergent themes by target_location + title similarity to 115 unique proposals. Each proposal lives in `learning-pipeline/proposals/NNN-slug.md` with frontmatter (rank, action_type, target_project, target_location, cluster_score, source_videos) and a body (summary, existing-overlap analysis, 3-5 concrete implementation steps, source video links, approval checkbox). `proposals/INDEX.md` is the review queue ordered by cluster score and grouped by action type.

## Decisions made
- **Token-only execution** — Steven directed no API key spend; all categorization via Claude Code subagents under his subscription. Future scheduled daily pipeline will run via /schedule or launchd + claude CLI, same model.
- **5-batch parallel split** — 31/31/31/31/29 transcripts per subagent; each emitted JSON to `data/categorizations/batch-N.json`.
- **Deduplication strategy** — exact target_location match OR (same action_type + same target_project + title similarity ≥ 0.65). Caught 8 multi-video clusters; conservative on purpose to avoid merging adjacent-but-distinct proposals.
- **Cluster score** — max fit_score + small bonus per duplicate (capped 0.10) to surface convergent themes.
- **Off-topic filter working** — 16 videos correctly tagged `off_topic: true` (sleep, music, motivation, real estate listings, aviation, political), zero proposals generated for them.

## Files changed
- `learning-pipeline/scripts/categorizer-spec.md` — categorization schema + project landscape doc
- `learning-pipeline/scripts/aggregate.py` — batch-merge + cluster + markdown rendering
- `learning-pipeline/data/categorizations/batch-{0..4}.json` — per-batch raw output
- `learning-pipeline/data/proposals-master.json` — aggregated machine-readable
- `learning-pipeline/proposals/{001..115}-{slug}.md` — individual proposal files
- `learning-pipeline/proposals/INDEX.md` — review queue

## Top recurring themes (cross-video signal)
- **Memory architecture** — open-brain Postgres (Supabase pgvector) appears in 4+ videos as the recommended layer for shared agent memory
- **Karpathy four-principle CLAUDE.md block** — referenced in 3 videos as the canonical agentic prompting pattern
- **CLAUDE.md / skill rot discipline** — 2 videos (Boris Cherny + audit pattern) → `/prompt-detox` skill proposal
- **Claude Routines** — convert daily/weekly SOPs into scheduled routines (2 videos)
- **Vault-as-canonical-context** — refactor skills to reference swan-vault context files instead of duplicating ICP/voice/brand blocks
- **Token management** — 4 videos converged on a `/token-coach` skill + settings.json audit
- **Obsidian RAG layering** — raw-notes/wiki-distillation pattern across 4 videos

## Top 5 proposals by cluster score
1. **0.91** Configure allow/deny rules in `~/.claude/settings.json` (3× convergence, action: setting)
2. **0.90** Set "opus plan" as default model strategy across projects (action: setting)
3. **0.90** Session-start + pre-compact hooks that auto-promote conversations into swan-vault (action: setting)
4. **0.90** Open-brain Postgres memory layer in swan-command-center Supabase (action: scaffolding)
5. **0.88** Adopt Karpathy four-principle block in global CLAUDE.md (2× convergence, action: doc)

## Counts by action type
- skill: 39
- scaffolding: 23
- doc: 19
- tool: 9
- dependency: 7
- route: 7
- setting: 6
- agent: 3
- plugin: 2

## Counts by target project
- _general_ (cross-cutting): 47
- swan-command-center: 43
- swan-vault: 12
- deftforge: 5
- ai-consulting-company: 3
- learning-pipeline (meta): 3
- providence-fire-rescue: 2

## Blocked / Needs input
- Steven now has 115 proposals to review at `learning-pipeline/proposals/INDEX.md`. Each has approve/reject checkboxes. Approved ones become real changes in implementation pass.
- Daily email-scan feature still pending — was scoped earlier in session, deferred until categorization-output format is approved.

## Next steps
1. Steven reviews top 10-20 proposals (start with cluster_score ≥ 0.85) and marks decisions
2. Implementation pass: convert approved proposals into actual skill files, command-center patches, etc.
3. Build daily Gmail scanner that feeds new YouTube URLs through this same pipeline (existing /Users/stevenswan/project-folders/swan-command-center/app/src/tools/gmail.ts is the foundation)
4. Wire a swan-command-center "Learning Feed" route that surfaces incoming proposals in the UI for review
