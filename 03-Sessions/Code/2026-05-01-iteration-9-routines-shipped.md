---
date: 2026-05-01
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~30 min
status: shipped (launchd install required to deploy)
---

# 2026-05-01 — Iteration 9 shipped: scheduled routines daemon

## Task
Build approved proposal #8: scheduling spine for recurring ops, including the daily Gmail-scan-for-YouTube-URLs feature Steven asked for at the start of this session.

## Outcome
Markdown-driven routines + cron daemon + launchd install. Five starter routines covering Steve`s real ops loops:
- daily-gmail-yt-scan @ 6am — directly fulfills the original ask
- morning-brief @ 6:30am — composes brief + Telegram TL;DR
- end-of-day-vault-sync @ 10pm — distill day to a daily reflection
- silvercrest-draw-reminder @ Mon 9am — pings if 28+ days since last draw
- weekly-retro @ Sun 6pm — week-in-review + Telegram TL;DR

Daemon loads specs, schedules with node-cron (timezone=PT), enqueues tasks on cron tick. Existing main worker drains the queue and runs through agent roles. Decoupling = adding a new routine is one .md file + daemon restart, no code edits.

Smoke test: `ROUTINES_DRY_RUN=1 npm run routines:dry` loaded all 5 specs cleanly, validated cron expressions, announced "5 routines active." TypeScript clean.

## Decisions made
- **Markdown spec format** matches the agent-prompt convention (frontmatter + body). Easy to read, edit, copy.
- **Cron in PT** by default (matches Steven`s timezone). Per-routine override via frontmatter `timezone` field.
- **Reuse existing worker** — daemon just enqueues tasks. Zero new agent execution code.
- **node-cron over alternatives** — small dep, no native bindings, well-known. Validated each spec at startup; invalid cron expressions skip the routine with a warning.
- **DRY_RUN + ONLY env vars** for ops/testing — `ROUTINES_DRY_RUN=1` logs without writing tasks; `ROUTINES_ONLY=slug1,slug2` filters to specific routines.
- **launchd plist** mirrors the existing worker plist convention. Logs land in `~/Library/Logs/swan-command-routines.{log,err.log}`.

## Files changed
- `app/routines/{daily-gmail-yt-scan,morning-brief,end-of-day-vault-sync,silvercrest-draw-reminder,weekly-retro}.md` — five new routine specs
- `app/worker/routines.ts` — new cron daemon
- `app/worker/com.swan.command-routines.plist` — new launchd plist
- `app/package.json` — added node-cron + 3 npm scripts
- `app/docs/iteration-9-routines.md` — install + add-a-routine + troubleshooting

## Iteration-9 infographic
`learning-pipeline/infographics/iteration-9-routines.html` — schedule grid, sequence diagram of a real fire (the Gmail-YT scan), build queue progress.

## Blocked / Needs input
- Steven needs to install the launchd plist + start the daemon (3 commands in `app/docs/iteration-9-routines.md`).

## Next steps
- Iteration 10 = #9 (Vault-clip browser bookmarklet). Final iteration. Closes the intake loop — anything Steven sees on the web is one click away from the framework.
