---
date: 2026-04-27
source: Claude Code
project: Swan Command Center v2
duration: ~8h (full day, multiple resumed sessions)
status: shipped, merged to main
---

# Session close — voice war room + Phase C.3 + shared Header

## Task
Close out the broader v2 TODO after the NotebookLM thread settled. Three items: voice channel, drop the Managed Agents API client, shared dashboard chrome.

## Outcome
All three shipped and merged to main via direct merge (`e293303`). Branch `refactor/option-c-local-sdk` is fully drained.

**Voice war room (`companion/war-room/`).** Single-process Python script that runs locally on the Mac. Reads default mic at 16kHz, streams to Gemini Live (`gemini-2.5-flash-native-audio-latest`), plays the 24kHz response back through default speaker. Three real tools wired: `hive_query` (Supabase task queue), `vault_read_file` (GitHub Contents API on swan-vault), `slack_send_message` (Slack chat.postMessage). System prompt knows Steven's twelve-channel taxonomy and is tuned to send-on-dictation rather than ask-for-permission. Live tested end-to-end: voice in, transcripts displayed, tool fired, Slack message landed, audio response heard. Cost: per-second native-audio Flash rates, ~$0.50–$2 per 10-min session.

**Phase C.3.** Deleted `src/lib/anthropic.ts` (261-line Managed Agents API client, `agent-api-2026-03-01` beta header, custom session/event polling). Rewrote `src/app/api/dispatch/route.ts` as enqueue-only — keeps auto-assign + spend-cap, drops synchronous `runTurn`. Added `src/app/api/tasks/[id]/route.ts` for status polling. Reworked `DispatchPanel.tsx` to enqueue then poll until status is terminal (5-minute deadline). UX trade-off: 1.5-sec poll latency vs synchronous result, but matches how Slack/Telegram already work.

**Shared `<Header>`.** New `src/components/Header.tsx` with title + subtitle + 5-link nav (auto-highlights via `usePathname`) + sign-out + `rightActions` slot + `belowBar` slot. Threaded through `/`, `/hive`, `/memory`, `/registry`, `/assistant`. Replaces five hand-rolled headers with inconsistent navs and missing sign-out links. Net 140 lines deleted.

## Decisions made
- **Voice war room runs on the Mac, not Fly.** Same hosting model as the worker — when the laptop is on, the assistant is reachable. No WebRTC/Daily.co/Twilio yet (deferred to v2/v3).
- **Send-on-dictation for Slack from voice.** Voice prompt explicitly tells the agent NOT to wait for a separate 'yes, send it' confirmation — the dictation IS the authorization. Read back what's being sent as the tool fires.
- **Enqueue-only dispatch with polling.** Kills the last bit of Managed-Agents-shaped code. Dashboard polls `/api/tasks/[id]` every 1.5 sec; matches the Slack inbound flow.
- **Direct local merge to main.** Skipped opening PR #4 — the prior PR-based flow (PR #2 / PR #3) was for landing larger discrete features; this final tranche is a tail of the same branch and a PR adds no review value.

## Files changed (this session, all merged)
- New: `src/components/Header.tsx`, `src/app/api/tasks/[id]/route.ts`, `companion/war-room/{run.py,run.sh,requirements.txt,README.md}`, `src/tools/notebooklm.ts` (rewritten), `companion/notebooklm/.venv/` (Python 3.12 + notebooklm-py)
- Modified: `src/app/page.tsx`, `src/app/hive/page.tsx`, `src/app/memory/page.tsx`, `src/app/registry/page.tsx`, `src/app/assistant/page.tsx`, `src/app/api/dispatch/route.ts`, `src/components/DispatchPanel.tsx`, `worker/index.ts`, `worker/tools.ts`, `src/agents/research.md`, `companion/notebooklm/{README.md,requirements.txt}`
- Deleted: `src/lib/anthropic.ts`, `companion/notebooklm/{com.swan.notebooklm.plist,run-mac.sh,.env}`

## Final architecture (post-merge)
- Worker on Mac (LaunchAgent `com.swan.command-worker`) → Anthropic Claude Agent SDK → in-process `swan-tools` MCP server with 30+ tools
- NotebookLM via `notebooklm-py` CLI shelled out per-call (`list_notebooks`, `search`, `ask`)
- Voice war room launched on demand by `./companion/war-room/run.sh` — Gemini Live + same three tools as the worker (Supabase, vault, Slack)
- Dashboard at `/`, `/hive`, `/memory`, `/registry`, `/assistant` with shared Header
- Slack as primary channel; Telegram backup; iMessage outbound for Comms; voice on demand

## Cleanup owed (Steven)
- Credential rotation sweep — Anthropic API key, GitHub PAT, Google OAuth tokens, Slack bot token + signing secret, Stripe restricted key. All passed through chat at various points across the day.

## Open items (deferred, not started this session)
- War room v2: WebRTC trigger so Steven can join from his phone instead of needing the Mac
- War room v3: Twilio number that calls the war room when ringing it
- Voice agent tool surface beyond the three current tools (gmail send, calendar read, etc.)
