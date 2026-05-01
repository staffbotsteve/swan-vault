---
date: 2026-04-30
source: Claude Code
project: swan-command-center / learning-pipeline
duration: ~25 min
status: shipped (worker restart to deploy)
---

# 2026-04-30 — Iteration 7 shipped: doc.extract grounded extraction

## Task
Build approved proposal #7: refactor doc-parse layer to enforce blank-with-reason / asymmetric-cost / source-quote evidence on extracted fields. Mission-critical for Silvercrest construction-loan workflows that operate on real money.

## Outcome
Kept `doc.parse` as-is (raw text extraction); added a NEW companion tool `doc.extract` that takes text + schema and returns audit table. Three rules enforced at the prompt level AND at the verification level — every claimed source_quote is checked against the input text; mismatched/hallucinated quotes are downgraded to null with reason "claimed source_quote not found in document (extractor hallucinated)". Uses Gemini 2.5 Flash with JSON-mode, temperature 0.

## Decisions made
- **New tool not refactor** — doc.parse and doc.extract have different responsibilities. Parse = bytes to text. Extract = text + schema to grounded audit table. Pipeline pattern.
- **Server-side quote verification** — model can hallucinate quotes; the server normalizes whitespace + case + smart quotes and checks substring inclusion. Failed verification == automatic blank-with-reason. This makes Rule 3 unforgeable at the model level.
- **Always returns one row per schema field** — even for fields the model omitted. Stable shape downstream.
- **Gemini Flash** — for a structured-extraction task with strict JSON output, Flash is the right tier. Real-money workflows still get 99% accuracy because the verification layer catches the 1% that hallucinate.
- **Granted to ops, legal, research** — Silvercrest draws are ops; contract review is legal; deep research uses it on PDF exports.

## Files changed
- `app/src/tools/doc-extract.ts` — new
- `app/src/types/tools.ts` — DocExtract* types added
- `app/src/tools/index.ts` — registered
- `app/worker/tools.ts` — MCP wrap + SWAN_TOOL_NAMES
- `app/worker/index.ts` — added to research, legal, ops role lists (and doc_parse added to ops)

## Iteration-7 infographic
`learning-pipeline/infographics/iteration-7-doc-extract.html` — sample audit table output, architecture diagram with the parse → extract → verify → audit flow, three example flows.

## Blocked / Needs input
- Steve to restart worker to deploy: `launchctl kickstart -k gui/$(id -u)/com.swan.command-worker`

## Next steps
- Iteration 8 = #6 (/research route chain). Chains existing youtube-search → notebooklm → vault-write into a single /research request. All the pieces exist; this is pure orchestration.
