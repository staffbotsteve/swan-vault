---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~25 min
status: shipped (worker side); Codex plugin install pending Steven manual step
---

# 2026-04-30 — Iteration 4 shipped: model-routing config + Codex plugin doc

## Task
Build approved proposal #10 — Codex+Claude framework. Per the Mark Kashef video: two layers — install OpenAI codex-plugin-cc for interactive sessions, plus routing.yaml/json for non-coding model decisions in the worker.

## Outcome
**Worker side (deployed-ready)**: created `config/model-routing.json` with per-role defaults + task-type overrides + Codex plugin metadata. New `lib/model-router.ts` exposes `resolveModel(role, taskType?)`. Refactored `agents-config.ts` to use it (hardcoded values stay as safety-net fallback). Models now editable without code changes — restart worker to pick up.

**Codex plugin (manual)**: documented in `app/docs/iteration-4-model-routing.md`. Steve runs `/plugin install github:openai/codex-plugin-cc` in his Claude Code session and `codex login` once. The plugin lives in Claude Code (not the worker), so it powers his INTERACTIVE sessions. The worker SDK does not have direct Codex access yet — async PR review still uses Claude Sonnet.

## Decisions made
- **JSON not YAML** — no yaml parser in deps; kept the channel-routing.json pattern that already exists. Same expressiveness for our needs.
- **Roles + overrides, not flat mapping** — role default for the common case, task-type override for special cases (coding-write/coding-review/classify/embedding/vision/deep-reasoning). Falls through cleanly.
- **Existing models stay** — kept the iteration 3 assignments (Haiku for main/content; Sonnet for research/comms/ops/dev; Opus for legal). The config makes them swappable, but the values themselves are unchanged from before.
- **Codex plugin: manual install, status flag in config** — Steve runs the install. After install, he flips `codex_plugin.installed: true` in routing.json so the dev agent prompt picks up "Codex available" guidance.
- **Worker SDK + Codex: not wired** — codex-plugin-cc is a Claude Code plugin, not an SDK feature. For async tasks the worker still uses Sonnet. Out of scope for iteration 4.

## Files changed
- `app/config/model-routing.json` — new
- `app/src/lib/model-router.ts` — new
- `app/src/lib/agents-config.ts` — refactored
- `app/docs/iteration-4-model-routing.md` — new

## Iteration-4 infographic
`learning-pipeline/infographics/iteration-4-model-routing.html` — shows the routing config, two-layer architecture (Codex in CC + routing.json in worker), three example flows, install instructions.

## Blocked / Needs input
- **Worker restart deploys this** — single command, idempotent.
- **Codex plugin install is interactive** — Steve runs `/plugin install` in any Claude Code session, then `codex login`. Doc in `app/docs/iteration-4-model-routing.md`.

## Next steps
- Iteration 5 = #4 (/dashboard/morning live route). First user-visible UI piece. Pulls from gmail unread, calendar today, stripe MRR, hive.recent_summary, learning-pipeline proposals.
