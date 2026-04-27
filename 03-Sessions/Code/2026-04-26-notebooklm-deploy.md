---
date: 2026-04-26
source: Claude Code
project: Swan Command Center v2 — NotebookLM companion deploy
duration: ~1h
status: shipped
---

# NotebookLM companion — Fly.io deploy + live calibration

## Task
Deploy the calibrated NotebookLM companion to Fly.io and validate every endpoint against the real NotebookLM service with Steven's logged-in cookies.

## Outcome
Companion is live at https://swan-notebooklm.fly.dev/. All five intended endpoints are working against the real NotebookLM web app. The Research agent now has a Path A capability to query NotebookLM notebooks and get back clean, citation-marked answers — no third-party harness, no public API dependency.

## Decisions made
- **Cookies via Fly secret, not volume** — `COOKIES_TXT_B64` env var decoded to /tmp/cookies.txt on app startup. One `fly secrets set` rotates them; no SSH or volume mounting needed.
- **Auto-stop machines** with `min_machines_running = 0` — companion stops itself when idle. Cold-start latency on first call after idle is ~5–15 sec, then warm. Estimated cost: $0–2/mo.
- **Bootstrap-token regex fixed** — the WIZ_global_data blob keys tokens as `KjTSIf` (bl), `FdrFJe` (f.sid), `SNlM0e` (at). My initial guess of `"bl"` was wrong; live HTML inspection corrected it.
- **Answer extractor: walk envelopes in reverse, take last `wrb.fr`'s `payload[0][0]`** — earlier streamed envelopes contain Gemini's chain-of-thought trace ('Initiating the Analysis…'); the LAST `wrb.fr` envelope contains the complete final answer. The previous longest-string heuristic returned thinking traces when answers were short.

## Files changed
- `companion/notebooklm/app.py` — bootstrap-regex fix; cookies-via-env-var support; deterministic answer extractor
- `companion/notebooklm/fly.toml` — removed volume mount; rely on Fly secret instead
- `app/.env.local` — added `NOTEBOOKLM_COMPANION_URL` and `NOTEBOOKLM_COMPANION_SECRET` so the worker can call the companion

## Live test results (against https://swan-notebooklm.fly.dev/)
- `GET /health` → 25 cookies loaded ✓
- `GET /notebooks` → returned Steven's real notebook list ✓
- `POST /notebooks` → created notebook `d5218fba-e392-45b0-b390-d930efac5911` ✓
- `POST /sources` (YouTube) → added Rick Astley video, source id `4139c36a…` ✓
- `POST /query` → returned clean prose answers with `[1-4]` citation markers ✓
- `POST /sources` (non-YouTube web URL) → returned empty payload; likely needs a different source-type code. Pending real research-agent use case to refine.
- `POST /reports`, `PATCH /notebooks/{id}` → wired, not yet exercised live.

## Commits (branch: refactor/option-c-local-sdk)
- `d4568d6` chore(notebooklm): inject cookies via Fly secret instead of volume
- `a8de079` fix(notebooklm): use correct WIZ_global_data key names
- `6eb4a26` fix(notebooklm): unfold nested JSON envelopes (intermediate)
- `2f69a99` fix(notebooklm): extract last wrb.fr envelope's payload[0][0]

## Cleanup owed
- Delete `swan-companion-smoke-2026-04-26` notebook from NotebookLM UI (test artifact).
- **Rotate GITHUB_PAT** — was leaked into chat transcript when an unrelated `env` dump appeared in shell output. Token starts with `github_pat_11ALR5G4A…`. Rotate at https://github.com/settings/tokens.

## Next steps
1. Add a `notebooklm_research` MCP tool to `worker/tools.ts` that proxies queries through the companion. Wire into Research agent's allowedTools.
2. Investigate the empty-payload issue with non-YouTube URLs — capture a single 'add web article' action in NotebookLM UI to see if `izAoDd` takes a different source-type code or if there's a separate rpcid for web sources.
3. Capture a single 'generate briefing doc' action to confirm the style string for non-mindmap report types.
4. Merge `refactor/option-c-local-sdk` into main once you're satisfied with the smoke tests.
