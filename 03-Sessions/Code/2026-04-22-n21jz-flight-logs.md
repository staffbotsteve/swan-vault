---
date: 2026-04-22
source: Claude Code
project: n21jz (aircraft flight logs)
duration: ~45 min
status: complete
---

# N21JZ flight log consolidation — 2023 to current

## Task
Gather all flight logs for N21JZ from 2023 to current, assemble into a readable log.

## Outcome
Assembled a complete consolidated flight log for N21JZ: 436 unique flights, 587.8 block hours, 91 airports, 253 unique routes, spanning 2023-01-03 → 2026-03-30. Steve downloaded 26 FlightAware Commercial History CSVs (the full paid-subscription archive). These were merged with pre-existing FlightAware exports already in the project, deduplicated by (origin, destination, departure time), filtered to 2023+, and sorted chronologically. Produced a browsable HTML flight log (grouped by month, with summary stats + top airports/routes), a clean master CSV, and a monthly-summary CSV. Also repaired `~/.zshrc` GITHUB_PAT (old token was revoked/invalid) and verified vault writes work.

## Decisions made
- Stored downloaded CSVs in a dedicated `Aviation/FlightAware-History/` folder rather than leaving them in `Downloads/`.
- Produced three artifacts: clean CSV (for re-processing), browsable HTML (readable log), monthly-summary CSV (for quick stats).
- Kept all rows (incl. position-only / diverted) — no lossy filtering.
- Dedup key: (Origin, Destination, Departure datetime). Earliest report (FlightAware_N21JZ.csv, 290 rows) already spanned 2022-2024 so newer monthly reports were treated as overlays.
- Placed all outputs under `/Users/stevenswan/project-folders/n21jz/Aviation/FlightLog/`.

## Files changed
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightAware-History/*.csv (26 files copied from ~/Downloads)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightLog/N21JZ_flight_log_2023-present.csv (master)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightLog/N21JZ_flight_log_2023-present.html (readable)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightLog/N21JZ_monthly_summary_2023-present.csv (rollups)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightAware_History_Reports.html (index, earlier)
- /Users/stevenswan/project-folders/n21jz/Aviation/FlightAware_History_Reports.csv (index twin)
- /Users/stevenswan/project-folders/n21jz/Aviation/Approach-Charts/N21JZ_Flights_2023-present_consolidated.csv (earlier interim)
- ~/.zshrc (GITHUB_PAT rotated to new fine-grained token)

## Blocked / Needs input
- None for this task. Token pasted in chat should be rotated at convenience for hygiene.

## Next steps
- Archive / delete ~/Downloads/FlightAware_N21JZ*.csv copies (already duplicated into project folder).
- Optional: plot monthly flight hours or generate a PDF version of the readable log.
- Optional: integrate pre-2023 flights (2022-05 onward) — data is already in the source CSVs if needed.
