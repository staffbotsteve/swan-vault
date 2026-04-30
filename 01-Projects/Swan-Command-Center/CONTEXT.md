---
project: swan-command-center
entity: Operations
slack: "#swan-command-center"
github: staffbotsteve/swan-command-center
created: 2026-04-29
---

# Swan Command Center

This is the meta-project: Steven's multi-agent operations layer itself. The Next.js dashboard (`/`, `/hive`, `/memory`, `/registry`, `/assistant`), the local worker on Steven's Mac, the Slack/Telegram inbound webhooks, the per-channel routing, the vault auto-injection, the NotebookLM integration, the voice war room.

## Folder layout

`/Users/stevenswan/project-folders/swan-command-center/app/`:
- `src/` — Next.js dashboard + API routes
- `worker/` — Claude Agent SDK worker (LaunchAgent on Mac)
- `companion/notebooklm/` — local notebooklm-py CLI integration
- `companion/war-room/` — Gemini Live voice war room
- `docs/` — channel-routing.json, specs, architecture
- `scripts/` — bootstrap-project.mjs, seed scripts

## Channel routing

This channel routes to the **Dev** agent (`agent_role: dev`) — engineering questions about the command center itself land here.

## When responding in this channel

If Steven says "the worker", "the dashboard", "the bot", or "the agent" without further qualification, he's talking about this codebase. Reference file paths in `/Users/stevenswan/project-folders/swan-command-center/app/` when discussing changes.
