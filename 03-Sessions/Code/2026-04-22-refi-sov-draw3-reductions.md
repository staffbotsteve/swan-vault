# 2026-04-22 — ReFi SOV: Draw 3 reductions applied

- **Date:** 2026-04-22
- **Source:** Claude Code
- **Project:** 7702 N Silvercrest (Arixa refinance SOV)
- **Duration:** ~45 min
- **Status:** Complete (pending lender approval of remapped line items)

## Task
Translate Draw 3 amounts from the original Arixa construction loan SOV into reductions against category budgets in the new Arixa refinance SOV, since Draw 3 had already been funded before the refi closed.

## Outcome
Applied $181,072 of Draw 3 line-item reductions across 9 categories in the ReFi SOV budget (column G). All buckets non-negative. Total loan amount reduces from $4,592,000 to $4,410,928 once Excel recalculates the SUM formula in the Total row. Created a timestamped backup of the ReFi SOV before writing. No formulas disturbed — only raw budget values in column G were overwritten.

## Decisions
- Lender term alignment: "Erixa" → Arixa, "Rex Erixa SOV" → Arixa ReFi SOV (voice-dictation normalization).
- Mapped 9 Draw 3 line items to 8 ReFi categories. Draw 3 used Community Development's taxonomy (176 items); ReFi uses Arixa's standardized taxonomy (166 items with ~45 reserved empty slots). Descriptions don't line up 1:1 — this was a real mapping exercise, not a copy.
- #18 Concrete Footings Hard Dig ($30,998) split 50/50 between #33 FOOTINGS, STEMS, SLAB (concrete side) and an excavation pool (dig side).
- #27 EXCAVATION had $0 budget in the ReFi — cannot go negative, so the $44,000 Excavation line + $15,499 dig-half of #18 = $59,499 excavation pool was redistributed to #17 UTILITY CONNECTIONS/TRENCH, #30 GABION WALLS, and #32 BACKFILL/DRAINAGE/FINAL GRADE.
- #17 zeroed out ($50K reduction max). Remaining $32,923 split 60/40 between #30 and #32 per Scenario D.
- #96 GC Management Fee @ 12% ($50,000) mapped to #116 BUILDER FEE (not #13 SUPERVISION).

## Final reductions (column G in 'Arixa SOV' sheet)
- R32 #15 TEMPORARY FENCING: $3,000 → $450 (−$2,550)
- R34 #17 UTILITY CONNECTIONS/TRENCH: $50,000 → $0 (−$50,000)
- R46 #28 RETAINING WALLS: $227,000 → $207,000 (−$20,000)
- R48 #30 GABION WALLS: $40,000 → $20,246 (−$19,754)
- R50 #32 BACKFILL, DRAINAGE, FINAL GRADE: $30,000 → $16,831 (−$13,169)
- R52 #33 FOOTINGS, STEMS, SLAB: $102,000 → $86,501 (−$15,499)
- R65 #44 PLUMBING: $55,000 → $45,500 (−$9,500)
- R143 #116 BUILDER FEE: $500,000 → $450,000 (−$50,000)
- R190 #163 DRAW FEE: $13,500 → $12,900 (−$600)

## Files changed
- `finance/Loans/Arixa Refinance/Arixa SOV -- 7702 N Silvercrest Way(REFI).xlsx` — budget column updated
- `finance/Loans/Arixa Refinance/Arixa SOV -- 7702 N Silvercrest Way(REFI).backup-before-draw3-reduction-20260422.xlsx` — pre-modification backup

## Blocked / Needs input
None. Ready for Steven to open in Excel to verify Total row recalculates to $4,410,928.

## Next steps
- Open the ReFi xlsx in Excel/Numbers to trigger SUM formula recalc on the Total row.
- If lender wants the same treatment for Draw 1 and Draw 2, repeat the mapping exercise for those draws (same 166-bucket Arixa taxonomy as target).
- Delete the backup file after confirming the lender accepts the refi SOV.