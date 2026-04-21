---
type: reference
updated: 2026-04-21
---

# gstack `/learn` → vault integration

## Problem

gstack's `/learn` skill stores per-project learnings as JSONL at `~/.gstack/projects/<slug>/learnings.jsonl`. Without a sync, that knowledge is:

1. **Invisible outside gstack.** Other agents (Claude Code general, claude.ai, cowork, OpenClaw) can't read it.
2. **Project-scoped.** A learning from Project Falcon about Lovable's ceiling doesn't reach SOSFiler or PermitVantage.
3. **Opaque to the user.** Not in the vault, not human-browsable.

The vault (`05-Reference/lessons/`) solves all three — but only if learnings actually end up there.

## Storage locations

| Location | Format | Scope | Role |
|---|---|---|---|
| `~/.gstack/projects/<slug>/learnings.jsonl` | JSONL | per-project | gstack's native write-ahead log |
| `~/project-folders/swan-vault/05-Reference/lessons/*.md` | Markdown | cross-project | canonical source of truth |

**Vault is canonical. Gstack JSONL is a WAL.**

## Manual export workflow

```bash
# 1. In the project directory
/learn export

# 2. gstack emits markdown; save to vault with domain-slug naming
#    e.g., ~/project-folders/swan-vault/05-Reference/lessons/lovable-ceiling-for-complex-integrations.md

# 3. Commit + push the vault
cd ~/project-folders/swan-vault
git add 05-Reference/lessons/ && \
  git commit -m "lessons: capture <topic> from <project>" && \
  git push
```

## Naming

`<domain>-<slug>.md`:
- `lovable-ceiling-for-complex-integrations.md`
- `supabase-rls-per-tenant.md`
- `stripe-for-private-schools.md`

Domain = the technology/area the lesson relates to. Slug = 3–6 word description in kebab-case.

## Linking from a project

When a lesson applies to an active project, link it from that project's `CONTEXT.md`:

```markdown
## Related
- [[05-Reference/lessons/lovable-ceiling-for-complex-integrations]]
```

## Proposed: scheduled sync (not yet implemented)

Options, cheapest first:
1. **Weekly cron via gstack `/schedule`** — safest, low noise
2. **Post-`/ship` hook** — export every time a PR lands
3. **Post-session hook** — fires whenever `/learn` writes

For now, export manually when a learning has crystallized. Track whether manual discipline holds; promote to automation if it drifts.
