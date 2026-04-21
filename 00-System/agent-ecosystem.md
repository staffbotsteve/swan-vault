---
type: reference
updated: 2026-04-21
---

# Swan Agent Ecosystem

How the moving pieces of the portfolio work together — and when each one talks to Obsidian.

![Agent ecosystem diagram](diagrams/agent-ecosystem.svg)

## The three-layer model

| Layer | Location | Role | Write cadence |
|---|---|---|---|
| **Vault (Canonical)** | `~/project-folders/swan-vault/` | Source of truth — projects, decisions, lessons, patterns, agent OS docs | Continuous |
| **Execution (Runtime)** | `~/.claude/` | Skills, settings, hooks. Vault *documents* them; execution happens here. | Rarely — via `/update-config` or skill install |
| **Memory (Ignition)** | `~/.claude/projects/.../memory/` | ~7 tiny pointer files loaded automatically every conversation — "read the vault for X" | Only when something changes about how to collaborate |

**Rule:** vault is canonical. Memory holds pointers, not copies. Duplicating vault content into memory creates two sources of truth that drift.

## Flow

```mermaid
flowchart TD
    User(["👤 Steven"])

    subgraph Agents["🤖 AGENTS — Interfaces"]
        CC["Claude Code<br/>terminal · IDE"]
        CA["claude.ai<br/>browser chat"]
        CW["Cowork<br/>collaborative"]
        OC["OpenClaw / Paperclip<br/>droplet agents"]
    end

    subgraph Vault["📚 OBSIDIAN VAULT — Canonical Knowledge"]
        VM["01-Projects/<br/>MOC + CONTEXT.md"]
        VS["03-Sessions/<br/>Code · Cowork · Chat"]
        VR["05-Reference/<br/>lessons · templates"]
        VY["00-System/<br/>rules · standards · skills"]
    end

    subgraph Memory["🧠 AGENT MEMORY — Ignition"]
        M["~7 pointer entries<br/>auto-loaded every session"]
    end

    subgraph Exec["⚙️ EXECUTION — Runtime"]
        S["~/.claude/<br/>skills · settings · hooks"]
    end

    subgraph Projects["💼 PROJECTS — Work"]
        P["~/project-folders/<project>/<br/>app · engineering · marketing · finance · legal · assets · archive"]
    end

    subgraph Ext["☁️ External"]
        GH["GitHub"]
        LV["Lovable"]
        VCL["Vercel · Supabase"]
    end

    User --> Agents
    Agents -->|READ context, decisions| Vault
    Agents -->|WRITE sessions, learnings| Vault
    Agents -.->|auto-load| Memory
    Memory -.->|pointers| Vault
    Agents -->|invoke| Exec
    Agents -->|edit · run| Projects
    Projects -->|git push| GH
    Vault -->|git push| GH
    Projects <-->|sync| LV
    Projects -->|deploy| VCL

    classDef vaultStyle fill:#EEF2FF,stroke:#4338CA,color:#3730A3
    classDef agentStyle fill:#ECFDF5,stroke:#059669,color:#065F46
    classDef memStyle fill:#FEF3C7,stroke:#D97706,color:#92400E
    classDef execStyle fill:#F1F5F9,stroke:#475569,color:#1E293B
    classDef projStyle fill:#ECFEFF,stroke:#0891B2,color:#155E75
    classDef extStyle fill:#F8FAFC,stroke:#64748B,color:#1E293B

    class VM,VS,VR,VY vaultStyle
    class CC,CA,CW,OC agentStyle
    class M memStyle
    class S execStyle
    class P projStyle
    class GH,LV,VCL extStyle
```

## When each interaction fires

| Interaction | When | What moves |
|---|---|---|
| **Agent → Memory (load)** | Every session start | MEMORY.md + entry files auto-loaded into context |
| **Agent → Vault CONTEXT.md (read)** | Start of project work, before proposing changes | Project truth: status, stakeholders, decisions, folder layout |
| **Agent → Vault sessions (write)** | End of every session | Session summary at `03-Sessions/Code/YYYY-MM-DD-<project>.md` |
| **Agent → Vault lessons (write)** | When a cross-project insight crystallizes | Lesson file at `05-Reference/lessons/<domain>-<slug>.md` |
| **gstack `/learn` → local WAL** | Automatic during skill runs | JSONL append at `~/.gstack/projects/<slug>/learnings.jsonl` |
| **gstack `/learn export` → vault** | Manual (weekly or before handoffs) | WAL markdown → `05-Reference/lessons/` |
| **Agent → ~/.claude/skills** | User invokes `/skill-name` | Skill content loaded and followed |
| **Agent → Project folder** | During active code work | Edit, run, commit |
| **Project → GitHub** | On commit/push | Code repo updated; Lovable syncs if wired |
| **Vault → GitHub** | On `git push` (or Contents API) | `staffbotsteve/swan-vault` gets the update |

## Why this shape

- **Vendor independence.** Obsidian is markdown + git. If Claude Code or claude.ai goes away, the vault is still the company's brain.
- **Cross-project knowledge.** A lesson written for Project Falcon about Lovable's ceiling benefits SOSFiler and PermitVantage the moment it lands in `05-Reference/lessons/`. Memory-scoped knowledge is invisible to other tools.
- **Memory is thin.** Ignition only — 7 pointer files. No CONTEXT.md duplication. No drift.
- **Execution is separate from documentation.** Skills in `~/.claude/` execute. The vault's `00-System/skills/` tells the story.

## Related

- [[00-System/rules/core-rules]]
- [[00-System/vault-write-system]]
- [[00-System/skills/README]]
- [[05-Reference/lessons/README]]
- [[01-Projects/PROJECTS-MOC]]
