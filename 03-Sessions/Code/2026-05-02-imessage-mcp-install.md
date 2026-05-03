# iMessage MCP Install

- Date: 2026-05-02
- Source: Claude Code
- Project: Tooling / MCP
- Duration: ~10 min
- Status: Done

## Task
Install third-party iMessage MCP server for Claude Code.

## Outcome
Installed `mac-messages-mcp` (carterlasalle/mac_messages_mcp) at user scope. Provides full read/send access to iMessage including group chats, attachments, contacts. Server connects healthy. iMessage now usable from any Claude Code session.

## Decisions made
- Chose carterlasalle/mac_messages_mcp over read-only options (anipotts) — wanted send capability.
- Pinned `mcp==1.6.0` because published package incompatible with current `mcp.server.fastmcp.FastMCP` (upstream removed `description` kwarg).
- Installed at user scope (`~/.claude.json`) so all projects inherit.

## Files changed
- `~/.claude.json` — added `messages` MCP server entry: `uvx --with mcp==1.6.0 mac-messages-mcp`

## Blocked / Needs input
- User must grant Full Disk Access to terminal/Claude Code in System Settings → Privacy & Security → Full Disk Access, then restart, before MCP can read `~/Library/Messages/chat.db`.

## Next steps
- Grant Full Disk Access.
- Restart Claude Code session.
- Test: ask Claude to list recent iMessage threads.