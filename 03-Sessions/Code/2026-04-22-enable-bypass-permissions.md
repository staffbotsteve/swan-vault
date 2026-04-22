---
date: 2026-04-22
source: Claude Code
project: Claude Code config
duration: ~5 min
status: Complete
---

# Enable bypass-permissions mode globally

## Task
Make `--dangerously-skip-permissions` the default for every Claude Code session.

## Outcome
Updated global Claude Code settings so every session auto-launches without permission prompts. No per-project flag or shell alias needed. Takes effect on next session start.

## Decisions made
- Applied at user scope (`~/.claude/settings.json`), not per-project — matches "all sessions going forward" intent
- Used `permissions.defaultMode: "bypassPermissions"` (the settings equivalent of the CLI flag)
- `skipDangerousModePermissionPrompt` was already true, so no dialog will appear

## Files changed
- `~/.claude/settings.json` — added `permissions.defaultMode: "bypassPermissions"`

## Blocked / Needs input
None.

## Next steps
None — change is live on next launch. To scope to a single project later, move the `permissions` block into that project's `.claude/settings.json`.
