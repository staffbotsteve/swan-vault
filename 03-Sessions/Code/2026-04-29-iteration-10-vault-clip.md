---
date: 2026-04-29
source: Claude Code
project: swan-command-center
duration: ~14 hours (cumulative across compactions)
status: complete
tags: [scaffolding, build-queue, final-iteration, vault-clip, bookmarklet, roadmap-complete]
---

# Iteration 10 — Vault-Clip Bookmarklet (final ship)

## Task
Ship the 10th and final approved enhancement from `learning-pipeline/proposals/APPROVED.md`: a browser bookmarklet that captures any web page (URL, title, page text, optional selection, optional note) into `swan-vault/00-Inbox/clipped/{date}-{slug}.md`.

## Outcome
The 10-iteration roadmap is complete. The framework now has a memory spine (vault-indexed pgvector retrieval), taxonomy-aware orchestration (departments + functions + tags across 37 tools), cross-agent visibility (hive-mind summaries), multi-model routing (with Codex plugin coexistence and pre-commit review hook), three new user-facing routes (/dashboard/morning, /skills, /research), grounded extraction for real-money workflows, a routines daemon firing 5 scheduled jobs, and the intake loop closed at both ends — Gmail forwards from iter 9 plus this bookmarklet from iter 10. Anything Steven sees on the web is one click away from the framework.

## Decisions made
- Token-auth via `X-Clip-Token` header (shared secret in `VAULT_CLIP_TOKEN` env var) rather than OAuth — minimum viable path that's still safe for personal use.
- CORS-enabled POST so the bookmarklet works cross-origin from any page.
- GET endpoint serves the bookmarklet source, gated so the embedded token is only included when `?include_token=1` is passed (the install page reveals it after a button click).
- Same-day re-clips of the same URL are idempotent overwrites (sha-aware PUT to GitHub Contents API).
- Output path is `swan-vault/00-Inbox/clipped/{YYYY-MM-DD}-{url-slug}.md` — keeps clipped material in the inbox triage flow rather than pre-categorizing.
- Clip page added to main NAV alongside Research, Skills, Morning so the install path is discoverable.

## Files changed
- `app/src/types/tools.ts` — added `VaultClipInput` / `VaultClipOutput`
- `app/src/tools/vault-clip.ts` — NEW · the `vault.clip` MCP tool
- `app/src/app/api/vault-clip/route.ts` — NEW · POST endpoint (token + CORS) and GET that returns the bookmarklet source
- `app/src/app/clip/page.tsx` — NEW · install page with reveal-token button + draggable bookmarklet
- `app/src/tools/index.ts` — registered `vault-clip`
- `app/worker/tools.ts` — MCP wrap + `SWAN_TOOL_NAMES`
- `app/src/components/Header.tsx` — added "Clip" to NAV
- `learning-pipeline/infographics/iteration-10-vault-clip.html` — final-iteration scaffolding visual

## Blocked / Needs input
None. Steve needs to do the deploy work himself:
1. `openssl rand -hex 32` to generate a token
2. Add `VAULT_CLIP_TOKEN=<token>` to `app/.env.local`
3. `npm run build && npm run start` from `swan-command-center/app/`
4. Open `/clip`, click "Reveal bookmarklet", drag to bookmarks bar
5. Also pending from iter 9: `launchctl load ~/Library/LaunchAgents/com.swan.command-routines.plist` and add the bot to Slack `#briefings`

## Roadmap roundup — all 10 enhancements shipped
| # | Iteration | Status |
|---|---|---|
| 1 | Vault-indexed pgvector retrieval | ✓ shipped |
| 2 | Departments / functions taxonomy | ✓ shipped |
| 3 | Hive-mind task-log with auto-summary | ✓ shipped |
| 4 | Model routing + Codex plugin + pre-commit review hook | ✓ shipped |
| 5 | /dashboard/morning route | ✓ shipped |
| 6 | /skills explorer route | ✓ shipped |
| 7 | doc.extract grounded extraction | ✓ shipped |
| 8 | /research orchestrator (NotebookLM mandatory) | ✓ shipped |
| 9 | Routines daemon (5 starter routines) | ✓ shipped |
| 10 | Vault-clip bookmarklet | ✓ shipped |

## Next steps (post-roadmap, ordered by leverage)
1. Process the 153-transcript proposal backlog through a /ship-style flow; consider a weekly routine that picks 1–2 high-cluster proposals and ships them.
2. Wire `/dashboard/morning`'s "queued proposals" card to allow inline approve/reject.
3. Add Gmail unread + calendar today to `/dashboard/morning` (deferred from iter 5; needs Google OAuth).
4. Add a `/routines` route showing fires + outcomes (data is in `tasks` tagged with the routine slug).
5. NotebookLM mind-map / audio-overview generation in `/research` (deferred from iter 8).
6. Or pause for a week and let the routines + Codex review loop + research orchestrator run unsupervised; see what surfaces.
