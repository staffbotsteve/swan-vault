---
date: 2026-04-26
source: Claude Code
project: Swan Command Center v2
duration: ~6h (across resumed session)
status: shipped
---

# Swan Command Center v2 — Slack-first cutover & local SDK runtime

## Task
Land the Slack-as-primary-channel cutover plus per-channel routing, fix the two cascading hallucination bugs in Comms, and verify the full pipeline runs on the local Claude Code SDK worker against the Max-tier subscription (zero marginal API cost).

## Outcome
Slack inbound + outbound is live. Steven now talks to the assistant in Slack across 12 channels (5 `#assistant-*` always-on plus 7 LLC channels in mentions-only mode), each tagged automatically with the right company and project. The local Claude Code SDK worker on Steven's Mac runs every turn — 33+ MCP tools wired through `createSdkMcpServer`, per-role tool isolation enforced, vault context auto-injected per role, and the active-memory pipeline classifies and persists each turn. PR #3 merged to main; production deploy verified on commit `6c78502`.

## Decisions made
- **Slack > Telegram** as the primary human channel. Telegram stays as a backup; iMessage is reserved for Comms outbound.
- **Channel routing table** drives company/project tagging plus a `mentions_only` flag so the bot stays quiet in human-conversation channels until @-mentioned.
- **Local SDK runtime (Option C)** — every agent turn runs against the Max-tier subscription. Marginal cost per turn: $0. Hosted Managed Agents API code paths removed from the Telegram route; residual cleanup tracked.
- **Per-role tool isolation** via `ROLE_TOOLS` allowlist. Legal cannot send email; Comms cannot read Stripe; Dev cannot post to Slack channels it does not own.
- **MCP tool naming** standardised on underscores (`mcp__swan-tools__calendar_list_events`). The SDK silently normalises dots, so any dot-form name resolves to zero tools — that was the root cause of the Comms 'grant access in Claude settings' hallucination.
- **NotebookLM Path A** — build our own Python companion (FastAPI on Fly.io) against the unofficial endpoints. Stubs return 501 pending Steven's network-tab calibration session.

## Files changed
- `src/app/api/channels/slack/route.ts` — URL verification, HMAC signature check, mentions-only filter, allow-list
- `src/lib/channels/slack-send.ts` — outbound Slack helper, wired into the worker dispatcher
- `src/lib/ingest.ts` — channel-routing-aware ingest threading company/project into every task row
- `src/lib/vault-context.ts` — per-role auto-injection of vault context at session start
- `src/lib/memory-pipeline.ts` — classify + persist each turn
- `src/lib/auto-assign.ts` — Gemini Flash router for the dashboard's 'auto' agent picker
- `worker/index.ts` + `worker/tools.ts` — 33+ MCP tools, all names underscored, per-role allowedTools
- `worker/com.swan.command-worker.plist` — LaunchAgent for auto-start
- `src/agents/main.md`, `src/agents/comms.md` — hard delegation table; anti-hallucination block forbidding 'Claude settings' connector language
- `supabase/migrations/0003_channel_routing_extend.sql`, `0004_channel_routing_mentions_only.sql`
- `docs/channel-routing.json` — Steven's 12-channel map
- `companion/notebooklm/` — FastAPI scaffold + Dockerfile + fly.toml (deploy deferred)

## Blocked / Needs input
- **NotebookLM endpoint calibration** — Steven needs to inspect Chrome DevTools network tab while clicking through NotebookLM, paste request URLs/payloads back so the 5 stubbed endpoints (currently 501) can be wired to real internal API calls. ~1 hour pairing.
- **NotebookLM Fly.io deploy** — `fly launch` + cookies.txt upload from Steven's machine.
- **Voice war room** (Pipecat + Gemini Live) — not started; ~1.5 days build, ~$5–10/mo Fly.io.
- **Credential rotation owed** — Anthropic API key, GitHub PAT, Google OAuth tokens, Slack bot token + signing secret, Stripe restricted key all passed through chat history during this session.

## Next steps
1. Pair on NotebookLM network-tab calibration; replace 501 stubs with real calls.
2. Deploy the NotebookLM companion to Fly.io.
3. Build the voice war room (Pipecat + Gemini Live) on Fly.io.
4. Phase C.3 cleanup — strip residual Managed Agents code paths from `src/lib/anthropic.ts` and `src/app/api/dispatch/route.ts`.
5. Cross-page sign-out and shared `<Header>` component for `/hive`, `/memory`, `/registry`, `/assistant`.
6. Rotate the credentials listed above.
