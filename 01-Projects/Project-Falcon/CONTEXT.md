---
type: project
entity: SwanBill
status: building
repo: https://github.com/staffbotsteve/cbhs-0606856e
folder: project-falcon/
openclaw_workspace: workspace-projectfalcon
deployed_url: https://cbhs.lovable.app
areas: [ai-infrastructure]
updated: 2026-04-21
---

# Project Falcon

## What this is
Unified, AI-native Student Information System being built pro bono for Christian Brothers High School (CBHS), Sacramento — SwanBill's pilot customer. Replaces 16+ fragmented vendor platforms (PowerSchool, Finalsite, FACTS, SCOIR, Schoology, ParentSquare, SchoolAdmin, FinalForms, and more) with one platform spanning inquiry through alumni. Architectural core is the **perpetual student record** — one person, one immutable Falcon ID, from 8th-grade inquiry through alumnus/donor. Three-tier architecture: kernel (every school gets it) + add-on modules (optional) + integration layer (30+ external platforms via LTI 1.3 / OneRoster / REST). Built on Lovable (React + TypeScript + Vite + shadcn-ui + Tailwind + Supabase + Capacitor). After CBHS pilot stabilizes, expands to the Lasallian network and the broader independent-school market.

## Current state
- ✅ Done: Phases 1–7B. Core SIS, College Readiness, Essay Evaluation, Scheduling + Common App Prep (13 bug fixes), College Application Tracking. 5 roles with RLS, 21 Supabase migrations applied, ~70 pages live. Lovable prototype at cbhs.lovable.app.
- 🔨 In progress: Phases 8A–10 — Scheduling, Extracurriculars/Athletics, Communication Hub, Reporting/Analytics, Health Records, Discipline, Admissions, Billing. Prompts submitted to Lovable.
- ⏳ Queued: Phase 11 (integration layer — LTI 1.3, OneRoster, Stripe Connect), Phase 12 (SAT/ACT API import), Phase 13 (AI intelligence layer), Phase 14 (Advancement/CRM), Phase 15+ (multi-tenant + Lasallian rollout). Focus groups, SOC 2 hardening, native mobile apps (Capacitor scaffolding in place).
- ❌ Known broken: none tracked

## Stakeholders
- Owner: Steven
- Partners: Jason McCabe (developer); Swanbot agent team (Lovable build)
- Customers/users: Dave Perry — President, Christian Brothers High School (pilot). Downstream: Lasallian network, independent-school market.

## Secrets & access
Names only, never values.
- `SUPABASE_URL`, `SUPABASE_ANON_KEY` — Supabase project — stored in `app/.env` (not committed)
- `ANTHROPIC_API_KEY` — AI holistic analysis, essay scoring, NL queries — Supabase Edge Function secrets
- `COLLEGE_SCORECARD_API_KEY` — US DOE college data — Supabase Edge Function secrets
- Stripe keys — billing (Phase 10) — not yet provisioned

## Folder layout (`~/project-folders/project-falcon/`)
Uses the role-first 7-folder template (see `05-Reference/templates/project-folder.md`).
- `app/` — live Lovable app. Remote: `staffbotsteve/cbhs-0606856e`. Lovable syncs here.
- `engineering/` — strategic analysis, status summary, phase specs, chat summaries, and `research/` subfolder (specs, design system, Lovable review — remote: `staffbotsteve/swanbill-sis`)
- `marketing/` — white paper, stakeholder update, `decks/` (falcon-update + archived presentations)
- `assets/` — architecture / data-flow / mind-map diagrams
- `archive/` — deprecated: `cbhs-old/` (superseded Lovable fork), `vite-scaffold/` (stray standalone build), `early-schema/` (pre-Lovable SQL prototype), `steven-swan-full-project-summary.md` (April 7 cross-project summary, now stale)

## Key decisions (most recent first)
- **2026-04-21**: Kept Lovable as the MVP build platform; Claude Code planned to take over for Phase 11+ (integration layer, AI intelligence, multi-tenant) where repo-level engineering dominates.
- **2026-04-21**: Reorganized folder into rigid layout (`app/`, `research/`, `docs/`, `decks/`, `assets/`, `archive/`). GitHub remotes untouched — Lovable connectivity preserved.
- **2026-04-16**: Admissions reclassified Add-On → Kernel. Private/independent schools (Falcon's primary market) cannot operate without an admissions pipeline; charging extra for it would nickel-and-dime the target customer.
- **2026-04**: Build/buy/integrate triage across 51 ed-tech platforms — 11 kernel + 5 add-ons to build, 9 to integrate, 26 redundant. Canvas: build kernel academics AND integrate via LTI 1.3. FACTS: integrate for pilot, replace with native Stripe billing in Year 2. SCOIR: confirm Counseling module feature parity before removing.
- **2026-04**: Stack locked — React + TypeScript + Vite + shadcn-ui + Tailwind, Supabase (Postgres + RLS + Auth + Edge Functions), Lovable for no-code acceleration, Vercel deployment target, Capacitor for iOS/Android wrappers.
- **Architectural**: Perpetual student record with immutable Falcon ID, temporal versioning on all person data, relationship graph (parent/sibling/teacher/counselor/coach/alumnus).

## External references
- Gamma presentation: https://gamma.app/docs/PROJECT-FALCON-zu8cq987ovv49jg
- Master spreadsheet (platform classification): https://docs.google.com/spreadsheets/d/1CYeim0fUWkQKEezfz0Fr5FLIbUgDEcV7ahGCdSiTzLA
- Google Drive (source files): https://drive.google.com/drive/folders/1jj_GLvRXCDcqYiC2hmFsGZ8HQT1bxy7N

## Related
- [[SwanBill]]
- [[02-Areas/AI-Infrastructure]]

## Recent sessions
- [[03-Sessions/Chat/2026-04-21-portfolio-consolidation]]
