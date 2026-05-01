---
date: 2026-04-29
source: Claude Code
project: swan-command-center
duration: ~30 min
status: complete
tags: [bugfix, routines-daemon, post-iter10]
---

# Routines Daemon — agent_id Bug Fix

## Task
Verify the routines daemon installed in iter 9 actually works by manually firing `morning-brief`. Bot was just added to Slack `#briefings`.

## Outcome
Found and fixed a latent bug: the routines daemon was inserting tasks with `agent_id` set to the role slug (e.g. `"main"`) instead of the agent_registry UUID. The worker filters claimable tasks by registry UUID, so cron fires would have been silently swallowed — tomorrow's 06:30 morning-brief would never have run. After the fix, the test fire completed in ~60s: brief saved to vault, 3-bullet summary posted to `#briefings`. The daemon now resolves role→UUID at startup (cached) with on-miss refresh.

## Decisions made
- Fix lives in the daemon (`worker/routines.ts`), not the worker — keeps worker's claim logic unchanged and avoids touching the working manual/Slack-driven task flow.
- Cache role→UUID at startup; refresh on first cache miss. Cheap, no TTL needed since registry rarely changes.
- Test methodology: insert task directly into Supabase via one-off node script (cleaner than triggering cron at 6:30am).

## Files changed
- `app/worker/routines.ts` — added `refreshAgentRegistry` + `resolveAgentId`; `enqueueRoutineTask` now resolves role to registry UUID before insert
- Restarted via `launchctl kickstart -k gui/$UID/com.swan.command-routines`

## Verified
- ✅ `morning-brief` task ran end-to-end in ~60s
- ✅ `swan-vault/04-Daily/2026-05-01-morning.md` written
- ✅ 3-bullet summary posted to Slack `#briefings` (channel C0B135J5CNS)
- ✅ Daemon log shows `resolved 7 agent roles → main, research, comms, content, ops, legal, dev` at boot

## Blocked / Needs input
None. Tomorrow's 06:30 PT cron will run unattended.

## Next steps
- Watch tomorrow's 06:30 brief for any new failure modes (calendar API auth, NotebookLM auth)
- The same bug pattern likely existed in any other code path that enqueues tasks with role slugs — worth a sweep, but not urgent
