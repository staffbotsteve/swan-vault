---
type: session
date: 2026-04-21
source: claude.ai-chat
---

# Portfolio Consolidation — Session Summary

## What was done
- Consolidated ~226 items in ~/Downloads/ into flat ~/project-folders/ (30 projects)
- Moved Obsidian vault out of iCloud-synced ~/Documents/ to ~/project-folders/swan-vault/
- Cloned 12 active GitHub repos into their project folders
- Secured SwanBill_Key.pem to ~/.ssh/swan/ with mode 600
- Seeded vault with PROJECTS-MOC.md and CONTEXT/LESSONS templates
- Diagnosed and fixed OpenClaw auth failure (OAuth deprecation → API key via `openclaw configure`)
- Installed Claude Code (resolved x64 Rosetta vs native arm64 Node issue)
- Rotated Gemini API key and all 8 Telegram bot tokens

## Key decisions
- **Flat filesystem, relational vault**: no categories on disk; Areas and MOCs handle relationships
- **SwanBill is umbrella**: projects graduate out when they become their own entity
- **e2s entities are distinct businesses**: not one bucket
- **Project Falcon absorbs**: swanbill-sis, cbhs, cbhs-0606856e, all Falcon Downloads artifacts
- **RampVantage = aviation-services workspace**: OpenClaw workspace-aviation-services is the code home
- **Killed**: tahoe-concierge (not related to Incline Tahoe Executive Transport)

## Still open (deferred)
- Droplet: archive 22 abandoned OpenClaw builds from April 7 pivot
- Droplet: agent renames via `openclaw configure` (permitapp→permitvantage, aviation-services→rampvantage, scoutoz→oz-lease-scout, projectfalcon→project-falcon)
- Droplet: rsync builds/silvercrest/ to Mac ~/project-folders/7702-n-silvercrest/engineering/
- Per-project CONTEXT.md population (0 of 28 — Project Falcon next in Claude Code)

## Related
- [[01-Projects/PROJECTS-MOC]]
- [[05-Reference/templates/CONTEXT-template]]
