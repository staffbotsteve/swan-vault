---
type: reference-index
updated: 2026-04-21
---

# Skills — Agent OS Reference

This folder **documents** the skills the agent OS can invoke. It is reference, not code — executable skill files live at `~/.claude/skills/` (Claude Code built-ins and gstack) and plugin-specific paths.

## What belongs here

- **Skill inventory** — what exists, when to use it, how it integrates with the vault
- **Integration notes** — how a skill relates to vault content (e.g., gstack `/learn` → `05-Reference/lessons/`)
- **Usage patterns** — recipes that combine multiple skills

## What does NOT belong here

- The skill's own documentation (that lives with the skill itself)
- Project-specific invocation history (that's in session summaries)

## Files

- `whisper-voice-integration.md` — whisper voice capture → vault workflow
- `gstack-learn-integration.md` — gstack `/learn` learnings → `05-Reference/lessons/` sync
