---
date: 2026-04-26
source: Claude Code
project: Swan Command Center v2 — NotebookLM companion
duration: ~1h
status: shipped (pending Fly.io deploy)
---

# NotebookLM companion — endpoint calibration

## Task
Replace the 5 stubbed 501 handlers in `companion/notebooklm/app.py` with real call patterns by inspecting the actual NotebookLM web traffic.

## Outcome
All 5 + 1 bonus endpoints are now wired against captured request shapes from sactoswan@gmail.com. The companion can list, create, rename, and ingest sources into notebooks; generate Studio artifacts (mind map confirmed, others extrapolated); and run grounded chat with conversation history. Three iterative HAR captures from Steven's Chrome were parsed, scrubbed of cookies, and used to derive the wire formats.

## Decisions made
- **App name is `LabsTailwindUi`, not `NotebookLmUi`** — original stub guessed wrong; fixed throughout.
- **Bootstrap tokens (`bl`, `f.sid`, `at`) are scraped from the home-page HTML** on first call, cached for 30 minutes, re-scraped on 401/403. No need for ongoing user-side maintenance.
- **Chat does NOT use batchexecute** — it goes to a separate gRPC-style endpoint `GenerateFreeFormStreamed` with a different inner JSON shape and requires the `X-Goog-Ext-353267353-Jspb` header.
- **Mind Map is generated client-side** in NotebookLM's browser — the `yyryJe` kickoff returns generation params and the browser uploads the AI-generated mindmap back via `CYK0Xb`. Server-side artifacts (briefing_doc, audio_overview) likely use the same `yyryJe` rpcid with a different style string; pending confirmation.
- **Answer-text extraction from chat is heuristic** — Chrome's HAR exporter strips streamed response bodies, so the exact envelope shape isn't captured. The extractor walks the parsed envelopes and returns the longest text payload. Will refine on first live test.

## Files changed
- `companion/notebooklm/app.py` — full rewrite of all 5 endpoints + bootstrap-token scraper + streamed-envelope parser. ~395 line delta.
- `.gitignore` — added `__pycache__/` and `*.pyc/.pyo`.

## Commits (branch: refactor/option-c-local-sdk)
- `ced9795` feat(notebooklm): wire 3 of 5 endpoints from HAR calibration
- `15e6683` feat(notebooklm): wire generate_report (yyryJe) from second HAR
- `87f0297` feat(notebooklm): wire chat (GenerateFreeFormStreamed)

## Blocked / Needs input
- **Fly.io deploy** — `fly launch` from `companion/notebooklm/`, set `SHARED_SECRET`, upload `cookies.txt`. ~10 min.
- **First live test** — once deployed, smoke-test `/health` then `/notebooks`. The chat answer extractor will need a real response to validate.
- **Credential rotation** — Steven's Google session cookies were exposed in chat once during the first cURL paste; rotation via https://accounts.google.com/Logout is owed.

## Next steps
1. Steven runs `fly launch` and uploads cookies.txt.
2. Smoke-test the deployed companion. Refine `_extract_answer_text` against a real chat response if the heuristic returns garbage.
3. Add a `notebooklm-research` MCP tool to `worker/tools.ts` that proxies to the Fly URL with the shared-secret bearer.
4. Capture a single briefing-doc generation in NotebookLM to confirm the style string for non-mindmap reports.
