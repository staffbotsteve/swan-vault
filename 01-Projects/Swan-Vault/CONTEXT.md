---
project: swan-vault
entity: Operations
slack: "#swan-vault"
github: staffbotsteve/swan-vault
created: 2026-04-29
---

# Swan Vault

Steven's Git-backed Obsidian vault. Persistent knowledge layer spanning all Claude surfaces, agent sessions, and companies.

## Architecture

```
This vault ← Git repo (GitHub: staffbotsteve/swan-vault, private)
     ↑ write                    ↓ read
Agents (Contents API)     Obsidian desktop (auto-pull)
```

- Agents write via the GitHub Contents API and commit directly.
- Steven reads via Obsidian, which auto-pulls every 10 min.
- No VPS, no laptop dependency — Git is the sync layer.

## Folder taxonomy

- `00-Inbox/` — unsorted incoming
- `01-Projects/` — one folder per active project (mirrors Slack channels)
- `02-Areas/` — cross-cutting concerns (Companies, Aviation, Real-Estate, Finance, AI-Infrastructure, Memory, Comms, Research, Ops, Legal, Engineering)
- `03-Sessions/` — Code sessions (`Code/`) and Cowork sessions (`Cowork/`)
- `04-Daily/` — daily notes
- `05-Reference/`

## When responding in this channel

If Steven says "the vault" he means this repo. Always reference paths relative to the repo root (e.g. `02-Areas/Research/INDEX.md`).
