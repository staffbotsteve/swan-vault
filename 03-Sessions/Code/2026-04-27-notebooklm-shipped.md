---
date: 2026-04-27
source: Claude Code
project: Swan Command Center v2 — NotebookLM integration
duration: ~5h (across resumed session)
status: shipped, working end-to-end
---

# NotebookLM integration — final architecture, working

## Task
Get the Research agent able to query Steven's NotebookLM notebooks from Slack with no manual per-notebook registration step.

## Outcome
End-to-end works. Steven asks a question in Slack referencing a notebook by name; the worker's Research agent calls `notebooklm.search` to resolve the id, then `notebooklm.ask` to get a citation-marked answer back. Auto-discovery of every notebook in the account works — no manual registration. Verified live: a question against the Helicopter Purchase Research notebook returned a clean answer in Slack.

## What it took to get here
Three failed architectures before the working one:
1. **Hand-rolled HTTP companion** (Python FastAPI on Fly, calibrated against captured NotebookLM HARs). Worked locally; broke on Fly within hours because Google rotates session cookies aggressively when the same account is hit from a different IP.
2. **External `notebooklm-mcp` package** (PleasePrompto/notebooklm-mcp, browser automation via Patchright). Stable auth, but its `list_notebooks` tool returns its OWN local library, not the user's NotebookLM account — required pre-registering each notebook by URL. Steven correctly rejected this as unworkable.
3. **Disabling SDK permissions broadly via `bypassPermissions`**. Sandbox blocked the change. Replaced with a targeted `canUseTool` allowlist that permits only `mcp__swan-tools__*` and the SDK's `Task` tool — strictly more restrictive than the prior implicit behavior.

Final architecture: `teng-lin/notebooklm-py` (the package Jack Roberts demos in his 'Claude Code + NotebookLM = Infinite Memory' video). It's a Python CLI + library that auto-discovers notebooks from the signed-in account, persists auth at `~/.notebooklm/storage_state.json`, and exposes everything as JSON. The worker's `src/tools/notebooklm.ts` shells out to it per call. Three in-process MCP tools: `list_notebooks`, `search`, `ask`.

## Decisions made
- **NotebookLM tools live in-process inside swan-tools, not as an external MCP server.** Per-call `spawn` of the CLI is a non-issue (~100–300 ms vs the multi-second LLM call). Keeps the entire worker tool surface inside one auditable allowlist.
- **canUseTool callback** as the headless-worker permission gate. Allowlist = `mcp__swan-tools__*` + `Task`. Anything else gets an explicit deny with a message.
- **Skip notebooklm-py's bundled Claude Code skill**; we use the CLI directly. The Claude Agent SDK isn't Claude Code, and the skill abstraction would just add an unnecessary layer.
- **Drop the Fly deploy.** `swan-notebooklm.fly.dev` is no longer in the architecture. Steven still needs to destroy the app to fully decommission it.

## Files changed (branch: refactor/option-c-local-sdk)
- `src/tools/notebooklm.ts` — full rewrite. Three CLI-shelling-out tools.
- `worker/tools.ts` — register the new tools in swan-tools; drop external mcpServers entry.
- `worker/index.ts` — drop external `notebooklm` MCP server config; add `canUseTool` allowlist; update Research's role tools.
- `src/agents/research.md` — workflow now: search by user's name → ask with id.
- `companion/notebooklm/.venv/` — Python 3.12 venv with notebooklm-py installed.
- `companion/notebooklm/requirements.txt` — narrowed to `notebooklm-py[browser]==0.3.4`.
- `companion/notebooklm/README.md` — rewritten with the working setup steps.
- Removed: `companion/notebooklm/com.swan.notebooklm.plist`, `run-mac.sh`, `.env`, and `~/Library/Application Support/swan/cookies.txt`.

## Commits since last vault entry
- `0819597` switch from in-process companion to notebooklm-mcp (later abandoned)
- `242d47c` explicit MCP allowlist via canUseTool
- `f628c6c` switch to teng-lin/notebooklm-py CLI (auto-discovery)
- `d39ba73` chore: trim companion to the working setup

## Cleanup owed (Steven)
- `~/.fly/bin/fly apps destroy swan-notebooklm --yes` — the Fly app is no longer used.
- Rotate `GITHUB_PAT` — leaked into chat earlier when an unrelated `env` dump appeared in shell output.
- Test in Slack against the second notebook (Providence Fire and Rescue) to confirm the search-by-name path is robust on a notebook with shared (not owner) status.

## Caveats / things that could break
- `notebooklm-py` calls undocumented Google APIs. Same fragility caveat as everything in this space — Google can change endpoints at any time. The package is on PyPI v0.3.4, actively maintained.
- Cookie session at `~/.notebooklm/storage_state.json` persists for weeks/months on the Mac. When it expires, `notebooklm login` re-auths via browser popup — same one-line fix.
- The CLI subprocess timeout is 180s for `ask` and 60s for `list/search`. Long Gemini answers might still cut off — adjust in `src/tools/notebooklm.ts` if it bites.

## Next steps
1. Steven runs the live test against a second notebook to confirm robustness.
2. Merge `refactor/option-c-local-sdk` into main once satisfied.
3. Optional: write a small launchd helper that pings `notebooklm list` weekly so we get a clear failure signal if cookies expire (vs discovering it during a real query).
