---
date: 2026-04-28
source: Claude Code
project: 7702 N Silvercrest — Arixa Refinance — Draw 1
duration_estimate: ~3 hours (across 2 days)
status: Complete — pending Steven sending email to Arixa
---

# Draw 1 Reimbursement Cycle — End to End

## Task
Build a repeatable process for the Arixa construction-loan draw cycle, then execute it for Draw 1 — reconcile invoices/lien releases/payments, update the SOV, and assemble the reimbursement packet for submission to Arixa Capital.

## Outcome
Designed and shipped a complete twice-monthly draw process for 7702 N Silvercrest. Draw 1 is fully prepared: $178,589.08 in payments reconciled across 5 vendors, SOV column O populated, and a 155-page combined PDF packet ready for submission to draws@arixacapital.com. Net reimbursement to Steven: **$177,839.08** (after the $750 Arixa draw fee). The whole process is now codified as a reusable skill so subsequent draws run from a single command.

## Decisions made
- **Reimbursement model.** Steven pays vendors from his personal account via Deluxe eChecks; Arixa reimburses each draw less a $750 processing fee. Loan is reimbursement-based, not direct-pay.
- **Lien-waiver workflow.** Waivers arrive AFTER payment via Buildertrend. Missing waivers are tracking items, never payment blockers — a major correction from the original design.
- **SOV file convention.** Each draw folder owns its own canonical SOV file (`Arixa SOV -- 7702 N Silvercrest Way Refi Draw N.xlsx`). Edited in place; no V-suffix versioning.
- **Vendor → SOV mapping.** Hybrid: subs map to one cost code each (saved to `vendor-sov-mapping.md`); the GC's invoices are read line-by-line and split. Confirmed: AZ Valley Plumbing → row 65 PLUMBING; Elite Custom Supply → row 46 RETAINING WALLS; Montowolf Grading → row 48 GABION WALLS.
- **Draw 1 SOV writes.** $10K SUPERVISION (row 30), $50K BUILDER FEE: (row 143), $1.2K PLUMBING (row 65), $9.061K GABION WALLS (row 48), $108.328K RETAINING WALLS (row 46) — total $178,589.08.
- **Orphan waivers.** 7 trailing waivers ($124,498) for prior bills not in this draw — kept as documentation only, not included in Draw 1 reimbursement.
- **Email handoff.** Assistant drafts the email; Steven sends it manually with two attachments (the SOV xlsx and the packet PDF).

## Files changed
- `Loans/Arixa Refinance/docs/superpowers/specs/2026-04-27-draw-payment-process-design.md` — full process spec (created and updated for the personal-account/post-payment-waiver workflow)
- `Loans/Arixa Refinance/vendor-sov-mapping.md` — vendor → SOV cost-code map
- `Loans/Arixa Refinance/Draws/Draw 1 - 2027.04.27/Arixa SOV -- 7702 N Silvercrest Way Refi Draw 1.xlsx` — Draw 1 amounts written into column O
- `Loans/Arixa Refinance/Draws/Draw 1 - 2027.04.27/Reimbursement Packet/Draw 1 Reconciliation.md`
- `Loans/Arixa Refinance/Draws/Draw 1 - 2027.04.27/Reimbursement Packet/Draw 1 Reimbursement Packet.pdf` — 155-page combined packet
- `Loans/Arixa Refinance/Draws/Draw 1 - 2027.04.27/Reimbursement Packet/Draw 1 Email to Arixa.txt`
- `~/.claude/skills/silvercrest-draw-cycle/SKILL.md` — reusable skill for all future draws

## Blocked / Needs input
Nothing blocking. Two soft items:
- Photos in the packet are unlabeled (all in a generic appendix). Future cycles will go faster if Steven labels HEIC files by vendor scope before the packet step.
- The Draw 1 folder is named `Draw 1 - 2027.04.27` (likely a typo — should be 2026.04.27). Cosmetic only; doesn't affect any logic.

## Next steps
1. Steven reviews `Draw 1 Reimbursement Packet.pdf` and `Draw 1 Email to Arixa.txt`.
2. Steven sends the email to draws@arixacapital.com with both attachments.
3. As lien waivers from Community Dev (#31, #32), AZ Valley (#1034), and Montowolf (#1339) trickle in via Buildertrend, drop them into `Draw 1 - 2027.04.27/Lien Releases/` for the audit trail.
4. When Draw 2 starts, Steven creates the next draw folder; the skill `silvercrest-draw-cycle` runs the cycle end-to-end (reconcile → checks block → SOV update → packet → email draft).
