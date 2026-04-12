# QA Runbook Template

**Project:** {{project-name}}
**Feature:** {{feature-name}}
**Author:** {{agent-id}}
**Date:** {{YYYY-MM-DD}}

---

## Pre-conditions

{{What must be true before testing begins — environments up, data seeded, credentials configured}}

## Test Cases

### TC-01: {{Test name}}
- **Action:** {{What to do}}
- **Expected:** {{What should happen}}
- **Actual:** {{Fill in during test}}
- **Status:** ⬜ Pass | ⬜ Fail | ⬜ Blocked

### TC-02: {{Test name}}
- **Action:** {{What to do}}
- **Expected:** {{What should happen}}
- **Actual:** {{Fill in during test}}
- **Status:** ⬜ Pass | ⬜ Fail | ⬜ Blocked

## Edge Cases

{{List edge cases that must be tested — empty inputs, expired tokens, concurrent access, etc.}}

## Verification Evidence

{{Screenshots, API responses, log excerpts, commit SHAs — proof it was actually tested}}

## Sign-off

- [ ] All test cases passing
- [ ] Edge cases verified
- [ ] Evidence attached
- [ ] Session summary written to vault

**Approved by:** {{steven | agent-id}}
**Date:** {{YYYY-MM-DD}}
