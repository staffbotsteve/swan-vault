---
type: moc
updated: 2026-04-20
---

# Projects — Map of Content

Every active project in the SwanBill portfolio. Each row maps:
**project folder** ↔ **GitHub repo** ↔ **OpenClaw workspace** ↔ **live deployment**.

This is the single source of truth for "what exists and where does it live."
When a new project is added, append a row here first, then create the artifacts.

---

## Active

| Project | Folder | Repo | OpenClaw | Deployed | Entity |
|---|---|---|---|---|---|
| [[SwanBill]] | `swanbill/` | `swanbill-site` | `builds/swanbill` | swanbill.biz ✅ | SwanBill (umbrella) |
| [[Project Falcon]] | `project-falcon/` | `swanbill-sis`, `cbhs`, `cbhs-0606856e` | `workspace-projectfalcon` + `builds/school-sis` | — | SwanBill → CBHS |
| [[SOSFiler]] | `sosfiler/` | `sosfiler` | `workspace-sosfiler` + `builds/sosfiler` | ✅ | SwanBill |
| [[PermitVantage]] | `permitvantage/` | `permitvantage` | `workspace-permitapp` + `builds/0325-5-permit-expediting` | ✅ | SwanBill |
| [[RampVantage]] | `rampvantage/` | `rampvantage` | `workspace-aviation-services` | Building | SwanBill |
| [[Sleepy Storybook]] | `sleepy-storybook/` | `sleepy-storybook` | `workspace-sleepy-storybook` + `builds/easter-stories` | ✅ | SwanBill |
| [[Providence Fire & Rescue]] | `providence-fire-rescue/` | — | — | — | Providence Fire & Rescue Inc. |
| [[Providence Heli Watch]] | `providence-fire-rescue/providence-heli-watch/` | `providence-heli-watch` | — | — | Providence |
| [[Blackhawk Rescue Hero]] | `providence-fire-rescue/blackhawk-rescue-hero/` | `blackhawk-rescue-hero` | — | — | Providence |
| [[Incline Tahoe Executive Transport]] | `incline-tahoe-executive-transport/` | — | — | — | Incline Tahoe Executive Transport |
| [[Incline Glide Transport]] | `incline-tahoe-executive-transport/incline-glide-transport/` | `incline-glide-transport` | — | — | Incline Tahoe Exec Transport |
| [[OZ Lease Scout]] | `oz-lease-scout/` | — | `workspace-scoutoz` | — | SwanBill |
| [[Personal Assistant]] | `personal-assistant/` | — | — | — | Personal |
| [[OpenClaw]] | `openclaw/` | — | — | droplet | Ops |
| [[Paperclip]] | `paperclip/` | — | — | droplet | Ops |
| [[Swan Command Center]] | `swan-command-center/` | `swan-command-center` | `builds/command-center` | — | Ops |
| [[Swan Vault]] | `swan-vault/` | `swan-vault` | — | — | Ops |
| [[e2s Hospitality California]] | `e2s-hospitality-california/` | — | — | — | e2s Hospitality CA LLC |
| [[e2s Hospitality NV]] | `e2s-hospitality-nv/` | — | — | — | e2s Hospitality NV LLC |
| [[7702 N Silvercrest]] | `7702-n-silvercrest/` | — | `workspace-7702nsilvercrest` + `builds/silvercrest` | — | Real estate |
| [[6040 N Camelback]] | `6040-n-camelback/` | — | — | — | Real estate |
| [[Mountain Shadows 4120]] | `mountain-shadows-4120/` | — | — | — | Real estate |
| [[623 Tyner Way]] | `623-tyner-way/` | — | — | — | Real estate |
| [[5909 E Sanna]] | `5909-e-sanna/` | — | — | — | Real estate |
| [[N21JZ]] | `n21jz/` | — | — | — | Aviation |
| [[R22 Training]] | `r22-training/` | — | — | — | Aviation |
| [[Taxes]] | `taxes/` | — | — | — | Personal |
| [[CB Extravaganza]] | `cb-extravaganza/` | — | — | — | Personal/event |

## Archived

Folder `archive/` — preserved, not attended to.

- `project-orchard/` — 2022 sale of previous companies
- `prior-ventures/erin/` — Erin App (2021)
- `prior-ventures/staffency/` — Staffency
- `prior-ventures/project-coders/` — Project Coders LLC
- `prior-ventures/amedisys/`
- `prior-ventures/totalmed/`
- `openclaw-experiments/` — 22+ agent-built builds frozen at April 7, 2026 pivot

## Areas

Cross-cutting concerns — link to [[02-Areas/Aviation|Aviation]], [[02-Areas/Real-Estate|Real Estate]], [[02-Areas/Finance|Finance]], [[02-Areas/AI-Infrastructure|AI Infrastructure]], [[02-Areas/Fitness|Fitness]].

Projects are tagged with their areas via YAML frontmatter; Dataview queries in each area note aggregate their projects automatically.
