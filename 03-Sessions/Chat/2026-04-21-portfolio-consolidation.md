---
type: session
date: 2026-04-21
source: claude.ai-chat
duration: 2-day spread
---

# Portfolio Consolidation — Day 1-2 Summary

## What was done
- Consolidated ~226 items in ~/Downloads/ into flat ~/project-folders/ structure (30 projects)
- Moved Obsidian vault out of iCloud-synced ~/Documents/ to ~/project-folders/swan-vault/
- Cloned 12 active GitHub repos into their project folders
- Secured SwanBill_Key.pem to ~/.ssh/swan/ with mode 600
- Seeded vault with PROJECTS-MOC.md and CONTEXT/LESSONS templates
- Archived 22 abandoned OpenClaw builds from April 7 pivot (still pending: droplet execution)
- Diagnosed and fixed OpenClaw auth failure (OAuth deprecation → switched to API key via `openclaw configure`)
- Installed Claude Code after resolving x64 Rosetta vs native arm64 Node issue

## Key decisions
- **Flat filesystem, relational vault**: no categories on disk; Areas and MOCs in Obsidian handle relationships
- **SwanBill is umbrella**: projects graduate out when they become their own entity
- **e2s entities are distinct businesses**: not one bucket
- **Project Falcon absorbs**: swanbill-sis, cbhs, cbhs-0606856e, all Falcon Downloads artifacts
- **RampVantage = aviation-services workspace**: OpenClaw workspace-aviation-services is the code home
- **Killed**: tahoe-concierge (not related to Incline Tahoe Executive Transport)

## Still open
- Telegram bot token rotation (8 bots — confirm all rotated)
- Droplet: 02-droplet-consolidate.sh not executed yet
- Droplet: agent renames via `openclaw configure` (permitapp→permitvantage, aviation-services→rampvantage, scoutoz→oz-lease-scout, projectfalcon→project-falcon)
- Droplet: pull builds/silvercrest/ down to Mac ~/project-folders/7702-n-silvercrest/engineering/
- Per-project CONTEXT.md population (0 of 28 done — starting with Project Falcon in Claude Code)

## Related
- [[01-Projects/PROJECTS-MOC]]
- [[05-Reference/templates/CONTEXT-template]]
