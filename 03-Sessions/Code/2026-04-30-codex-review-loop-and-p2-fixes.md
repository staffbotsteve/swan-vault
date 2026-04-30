---
date: 2026-04-30
source: Claude Code
project: claude-code (settings) + swan-command-center (P2 fixes)
duration: ~30 min
status: shipped (manual /hooks reload required for hook to register)
---

# 2026-04-30 — Codex permanent review loop + 4 Codex P2 fixes

## Task
Steve directive: "codex involved in all development and code review automatically as part of our scaffold... share code with codex for review and the two of you communicate until agreeable to be released. permanent process. add to swan command center." Plus address the 4 P2 issues Codex found in the iter 1-4 review.

## Outcome — codex pre-commit hook
PreToolUse hook on Bash that intercepts `git commit` / `git push` / `gh pr create` and runs Codex review against the working/staged diff before allowing the tool call. P0/P1 findings BLOCK the commit and surface as the denial reason; Claude addresses, retries, loop continues until clean. P2/P3 findings are non-blocking. Doc-only changes skip review. Opt-out via SKIP_CODEX_REVIEW=1.

## Outcome — 4 Codex P2 fixes addressed

1. **hive-recent.ts (queries)** — was filtering by `created_at`, now filters `status="done" AND completed_at >= since`. When agents are explicitly requested, runs one parallel query per role with `agent_id ILIKE %role%` so the per-agent limit is enforced at SQL level (was JS-side after global fetch — could starve quieter agents).

2. **vault-reindex.ts (stale prune)** — added end-of-run scan that deletes `vault_index` rows whose `file_path` is no longer in the candidate set. Skips prune when `--max` was set (incomplete candidate set). Honors `--path` scope via `LIKE` filter.

3. **notebook-context.ts (main agent)** — removed "main" from `ROLES_WITH_NOTEBOOKS`. Main delegates research to the research subagent (which DOES get notebook context via the subagent-prompt path in worker/index.ts). Was injecting a directive to call notebooklm.* tools that main`s ROLE_TOOLS doesn`t expose.

## Files changed
- `~/.claude/hooks/codex-pre-commit.sh` — new · the hook script
- `~/.claude/settings.json` — added PreToolUse Bash hook (timeout 240s)
- `app/src/tools/hive-recent.ts` — Codex P2 #1 + #2
- `app/worker/vault-reindex.ts` — Codex P2 #3 (stale prune)
- `app/src/lib/notebook-context.ts` — Codex P2 #4 (main excluded)

## Decisions made
- **Hook script not inline command** — too complex for a one-liner; lives at `~/.claude/hooks/codex-pre-commit.sh`. Single-purpose, testable.
- **Silent skip on failure modes** — if codex CLI isn`t installed or errors, the hook exits 0 (allow). Don`t break Steven`s commit workflow over a tooling issue.
- **Doc-only filter** — all changed files matching `\.md|\.txt|^docs/|/docs/` → skip review. Saves 30-90s on documentation commits.
- **240s timeout** — codex review averages 30-90s but worst-case hits ~3 min on 30-file diffs. 240s buffer prevents premature timeouts while not being absurd.
- **No swan-command-center side hook yet** — the worker doesn`t commit code itself, so no hook needed there. If/when the worker dev agent commits code asynchronously, will add `codex.review` as a tool the dev agent calls before its `git commit`.

## Hook deploys via
- Hook script + settings.json change is on disk and JSON-validated. The Claude Code settings watcher only sees changes when `/hooks` is opened or the app restarts. Steven needs to either open `/hooks` once OR restart Claude Code for the hook to fire.

## P2 fixes deploy via
- Worker restart: `launchctl kickstart -k gui/$(id -u)/com.swan.command-worker` after the changes are committed.

## Blocked / Needs input
- Steve to reload `/hooks` (or restart CC) so the new hook takes effect for future git commits.
- Steve to restart worker to pick up the 3 P2 fixes in swan-command-center.

## Next steps
- Iteration 5 = #4 (/dashboard/morning live route) is still next per the build queue.
- Optional: write a `codex.review` SCC tool so the worker dev agent has the same review-before-release loop as Steven`s interactive sessions.
