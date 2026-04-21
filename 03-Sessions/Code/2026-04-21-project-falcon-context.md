---
type: session
date: 2026-04-21
source: claude-code
project: Project Falcon
duration: ~3h
status: complete
---

# Project Falcon — CONTEXT.md + Folder Reorg

## Task
Create `01-Projects/Project-Falcon/CONTEXT.md` from source material; along the way, reorganize `~/project-folders/project-falcon/` into a rigid, intuitive structure.

## Outcome
Project Falcon now has a fully populated vault CONTEXT.md (phase status, stakeholders, decisions, folder layout, external references) and the filesystem folder is reorganized into a consistent 6-bucket layout (`app/`, `research/`, `docs/`, `decks/`, `assets/`, `archive/`). Lovable connectivity verified live (remote unchanged, HEAD matches). The vault's MOC row remains accurate — folder path, repos, and OpenClaw workspace unchanged.

## Decisions
- **Lovable stays the MVP build platform** through Phase 10. Claude Code planned to take over Phase 11+ where repo-level engineering dominates (integration layer, AI intelligence, multi-tenant, Stripe billing, SOC 2).
- **Adopted rigid 6-bucket project-folder template** — `app/`, `research/`, `docs/`, `decks/`, `assets/`, `archive/`. Should be applied to the other 27 projects in the portfolio.
- **Naming convention**: lowercase-hyphen for files (`white-paper.md`, not `PROJECT-FALCON-WHITE-PAPER.md`). No dates in filenames unless intrinsically dated.
- **GitHub repos NOT renamed.** Local folders renamed (`cbhs-0606856e → app`, `swanbill-sis → research`) to get clean names without risking Lovable sync.
- **Deprecated the `cbhs` repo** (old Lovable fork) in favor of `cbhs-0606856e` (active). `cbhs-old` archived locally; GitHub remote preserved.
- **Stray Vite scaffold archived** — `project-falcon/project-falcon/` was a Phase-1-only fresh build unlinked from Lovable. Moved to `archive/vite-scaffold/`.
- **Orphan `.git/`** at project-falcon root (1 commit, no remote, 2 deleted SQL files) — extracted files to `archive/early-schema/` with ORIGIN.txt, then removed the `.git/`.

## Files changed
- `swan-vault/01-Projects/Project-Falcon/CONTEXT.md` — rewritten from minimal April 12 stub to full CONTEXT (preserved the Gamma URL)
- `project-folders/project-falcon/README.md` — new, points to vault CONTEXT.md
- `project-folders/project-falcon/` — reorganized into 6-bucket structure
- `project-folders/project-falcon/archive/early-schema/` — preserved 2 SQL files + ORIGIN.txt before removing orphan `.git/`
- Deleted: `stitch/`, `stitch.zip`, `.DS_Store`, orphan `.git/` at project-folder root

## Blocked / Needs input
None.

## Next steps
- Apply the 6-bucket folder template to the remaining 27 projects (0 of 28 CONTEXT.md files completed before today; 1 of 28 now).
- Continue per-project CONTEXT.md population.
- When Phase 10 nears completion, plan the Lovable → Claude Code handoff for Phase 11+.
- Decide whether to rename GitHub repos (`cbhs-0606856e` is ugly) once Phase 10 ships and Lovable sync is less load-bearing.

## Related
- [[01-Projects/Project-Falcon/CONTEXT]]
- [[01-Projects/PROJECTS-MOC]]
- [[03-Sessions/Chat/2026-04-21-portfolio-consolidation]]
