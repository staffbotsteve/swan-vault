---
date: 2026-04-29
source: Claude Code
project: cpl (proposed — Commercial Pilot License study workspace)
duration: ~30 min
status: closed without alignment
---

# 2026-04-29 — CPL workspace brainstorming (no alignment)

## Task
Brainstorm a new `cpl` project workspace, intended to be added under swan-command-center, for studying for the FAA Commercial Pilot — Airplane (Single-Engine Land) certification.

## Outcome
Brainstorming session ended without a design or any work product. Steven asked Claude to act as him and extract the full Sheppard Air Flight Test 5.0 question bank (laptop-locked product he paid for), then to ingest content from his $39.95 ASA Test Prep digital book (cloud reader at library.asa2fly.com), and finally from prepware.com (also ASA). Claude declined each, citing single-device EULAs and compilation copyright on licensed test-prep products. Steven elected to use a different tool/model. No folders, files, or vault entries were created in `~/project-folders/` during the session.

## Decisions made
- **Scope confirmed (before impasse):** whole CPL Airplane (SEL) end-to-end — written first, then maneuvers re-currency, then checkride. Steven holds PPL + IR; CPL maneuvers training completed long ago and needs refresh.
- **Real frustration identified:** Steven owns paid licenses to Sheppard Air and ASA Test Prep, both single-device DRM-locked, neither lets him study while driving or going to bed (his actual use case).
- **Claude's offered alternative (declined by user):** generate ~400–600 ACS-aligned CPL questions from public FAA source material (PHAK, AFH, FAR/AIM, ACS), build a TTS audio-rotation app with driving / bed / drill modes, weak-area weighting, and a workflow where Steven dictates questions from his ASA book during legitimate study sessions to grow his personal corpus.
- **Line Claude held:** would not programmatically extract or transcribe content from Sheppard, ASA, or Prepware — bulk extraction violates EULA and ASA/Sheppard compilation copyright regardless of access mechanism (laptop app, cloud reader, web preview).

## Files changed
- None

## Blocked / Needs input
- Steven moving to a different agent / tool to pursue the extraction approach. No further action from Claude on this task.

## Next steps
- If Steven returns and wants the FAA-public-sources audio companion build, the conversation can resume from that proposal.
- Honest note for next session: Claude's prior recommendation to "buy ASA Test Prep — their format is parseable" was inconsistent with the line Claude later held. That recommendation cost Steven $39.95. Future sessions should be more careful before suggesting purchases tied to extraction tooling.
