---
date: 2026-04-22
source: Claude Code
project: n21jz (aircraft flight logs)
duration: ~30 min
status: in-progress (awaiting user download of FlightAware reports)
---

# N21JZ flight log consolidation — 2023 to current

## Task
Gather all flight logs for N21JZ from 2023 to current, using public/paid sources.

## Outcome
Consolidated existing FlightAware CSVs into a single deduped flight record covering 2023-01-03 → 2025-10-12 (206 flights). Identified two major coverage gaps: June 2024 – July 2025 (14 months) and November 2025 – present (6 months). Discovered Steve has a monthly FlightAware Commercial History subscription (23 reports on file, May 2024 onward) via Gmail search; produced a clickable HTML index of all 23 download URLs and a CSV equivalent for easy access. Opened the HTML in his browser.

## Decisions made
- Chose to consolidate what we already have first before scraping external sources (ADS-B Exchange / OpenSky).
- Treated `N21JZ_Logbook_Master.xlsx` as a maintenance log, not flight log — excluded from consolidation.
- Used Gmail MCP tools to find the paid subscription reports rather than scraping FlightAware directly.
- Generated an HTML table (one-click links) as primary artifact; CSV as sheet-format backup.

## Files changed
- /Users/stevenswan/project-folders/n21jz/Aviation/Approach-Charts/N21JZ_Flights_2023-present_consolidated.csv (created)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightAware_History_Reports.html (created)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightAware_History_Reports.csv (created)

## Blocked / Needs input
- FlightAware download URLs require authenticated session; Steve needs to click through the HTML index from a logged-in browser and save the CSVs.

## Next steps
- Steve downloads the most recent report (Apr 2026, #820970) to check if reports are cumulative.
- If cumulative: merge that single file into the consolidated dataset — done.
- If not cumulative: download all 23 reports, merge in date order, dedupe.
- Optional backfill for Jun 2023 and pre-May-2024 gaps via ADS-B Exchange historical.
