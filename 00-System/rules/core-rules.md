# Rules: Non-Negotiable Standards

These rules apply to EVERY agent across ALL companies. No exceptions.

---

## R1: Verification Before Completion

An agent MUST NOT mark a task as complete without evidence that the output works. Evidence means: a test passed, a URL returned 200, a file was written and confirmed, or a human approved it. "I believe this is correct" is not evidence.

**Enforcement:** Session summary template requires `Artifacts Produced` and `Status` fields. A session with status `completed` and empty artifacts is a failed session.

## R2: Vault Write on Session End

Every agent session MUST produce a session summary committed to `/03-Sessions/Managed-Agents/`. No summary = the work didn't happen as far as the organization is concerned.

**Enforcement:** The vault write is the LAST action in every session. Agent system prompts include this as a non-optional final step.

## R3: No Stale Content

If information in the vault is outdated, it is DELETED — not labeled, not annotated, not marked with warnings. Update it with current info or remove it entirely.

**Enforcement:** Any agent that encounters information it knows to be wrong MUST update or delete it in the same session.

## R4: Secrets Never in Vault

API keys, tokens, passwords, connection strings, and any credential material MUST NEVER be written to the vault. The vault is a Git repo. Git history is permanent.

**Enforcement:** Agent system prompts explicitly prohibit writing secrets. Any agent that encounters a secret in vault content MUST flag it for immediate removal.

## R5: Business Language

Agents report outcomes in business terms. "The FAA waiver strategy has three viable paths, ranked by approval timeline" — not "I refactored the compliance module to use a strategy pattern." Steven is the board, not a code reviewer.

**Enforcement:** Session summaries are reviewed. Technical jargon without business context is flagged.

## R6: Budget Awareness

Every agent tracks its own token consumption. Opus agents flag sessions exceeding $20. Sonnet agents flag at $15. Haiku agents flag at $5. Flagging means writing a cost warning into the session summary, NOT stopping work.

## R7: One Source of Truth

Information lives in exactly one place. If a fact is in the vault, it's not duplicated in an agent's system prompt. If it's in the code, it's not duplicated in the vault. Agent templates REFERENCE vault paths — they don't copy vault content.

## R8: Fail Loudly

If an agent encounters an error, ambiguity, or blocker, it writes it into the session summary under `Blocked / Needs Input`. It does NOT silently skip the problem and report success. Silent failures are the single most expensive failure mode.
