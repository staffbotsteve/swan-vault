# Swan Second Brain

**Owner:** Steven Swan
**Vault type:** Git-backed Obsidian vault
**Purpose:** Persistent knowledge layer spanning all Claude surfaces, agent sessions, and companies.

---

## Architecture

```
This vault ← Git repo (GitHub private)
     ↑ write                    ↓ read
Managed Agents           Obsidian desktop
(via GitHub API)         (via Obsidian Git plugin)
```

- **Agents write** by calling the GitHub Contents API to create/update files and commit directly.
- **You read** by opening Obsidian, which auto-pulls on launch and every 10 minutes.
- **No VPS, no laptop dependency.** Git is the sync layer.

## Setup

1. Create a private GitHub repo: `steven-swan/swan-vault`
2. Clone locally to your Obsidian vaults directory
3. Install the **Obsidian Git** community plugin
4. Configure auto-pull interval (10 min recommended)
5. Create a GitHub Personal Access Token (fine-grained, repo-scoped) for agent writes
6. Store the PAT as a secret in your Managed Agents environment

## Vault Rules (enforcement, not instruction)

1. **Agents MUST write a session summary on task completion.** This is enforced in every agent system prompt.
2. **Stale content is deleted, never labeled.** No "⚠️ STALE" markers. Update or flush.
3. **One source of truth.** If information exists in code, don't duplicate it here. If it exists here, don't duplicate it in agent memory.
4. **Project context files are authoritative.** Agent system prompts reference these files. Edit the vault, agents inherit the change.
5. **Daily rollup at 06:00 MST.** A scheduled agent summarizes all overnight activity into a daily note.
