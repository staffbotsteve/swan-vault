---
date: 2026-04-29
source: Claude Code
project: learning-pipeline (AI architecture intake)
duration: ~75 min
status: in progress — transcripts ready, awaiting categorization gate
---

# 2026-04-29 — YouTube transcript pipeline (153 videos)

## Task
Build a pipeline to ingest the transcripts of YouTube videos Steve has downloaded on his iPhone, so the corpus can feed AI architecture decisions (skills, plugins, agents, command-center upgrades). Goal of this session: get all transcripts in hand for downstream categorization.

## Outcome
End-to-end pipeline built and run successfully. From 39 iPhone screenshots of the YouTube Downloads view, the pipeline OCR-extracted 195 video occurrences, deduplicated to 163 unique videos, resolved 155 to canonical YouTube IDs (95% resolution rate), and fetched clean transcripts for 153 unique videos (3.5M chars total, 22.8K avg per video). Corpus is heavily Claude Code / Cowork / Karpathy skills content — exactly the AI-architecture material targeted. No paid extraction; everything sourced from public auto-captions via yt-dlp.

## Decisions made
- **Pivot:** session pivoted away from CPL (commercial pilot) workspace after Claude declined to extract licensed Sheppard Air / ASA Test Prep content. New purpose became enhancing AI architecture via a learning pipeline.
- **Intake mechanism:** screenshots of YouTube iPhone Downloads tab (39 PNGs in Archive.zip) — bypassing the fact that Downloads is invisible to Google Takeout.
- **OCR via Claude vision (subagent):** extracted title + channel + duration + views from each screenshot, output JSON.
- **Two-pass dedupe:** by (channel, duration, views) then by title-prefix similarity within channel — handled OCR cropping that left some entries with NULL duration.
- **Resolver:** yt-dlp ytsearch10 with cleaned channel + cleaned title; channel-match (0.55) + duration-match (0.30) + title-similarity (0.15) scoring; truncation cleaning (strip unmatched parens, trailing 1-3-char fragments, trailing ellipsis on channels).
- **Auto-caption parser:** YouTube-specific — keep only cues with `<c>` word-timing tags (the rolling-caption "new content" lines), skip the duplicate transition cues. Cut transcript size 3x while preserving full content.
- **Confidence gating:** transcripts only fetched for confidence ≥ 0.5; the 8 low-confidence resolutions (5%) were correctly identified as wrong matches and skipped.

## Files changed
- `/tmp/yt-pipeline/dedupe.py` — two-pass deduplication
- `/tmp/yt-pipeline/resolve.py` — title→video-ID resolver with multi-candidate scoring
- `/tmp/yt-pipeline/fetch_transcripts.py` — yt-dlp transcript fetcher with YT auto-caption parser
- `/tmp/yt-pipeline/transcripts/` — 153 markdown transcript files with frontmatter (3.5M chars, 3.8MB)
- `/tmp/yt-pipeline/transcripts-index.json` — manifest of all fetched transcripts
- `/tmp/yt-pipeline/resolved-videos.json` — full resolved video metadata
- `/tmp/yt-pipeline/unique-videos.json` — deduplicated screenshot extraction

(All output files are in /tmp; pending decision on permanent home in swan-vault or swan-command-center.)

## Corpus stats
- 153 unique videos, ~3.5M characters of clean transcript
- 92% high-confidence resolution (150/163), 95% transcripts fetched (155/163, with 2 file-level dedup collisions yielding 153 unique on disk)
- Top channels: Nate Herk | AI Automation (15), Chase AI (13), Greg Isenberg (7), Simon Scrapes (6), Cole Medin (5), Jay E | RoboNuggets (5)
- Top topics: claude code (45), karpathy (10), cowork (9), obsidian (9), tutorial (8), claude design (7), opus (6)

## Blocked / Needs input
- **Permanent home for transcripts** — currently /tmp; waiting for Steve to decide on swan-vault `05-Reference/transcripts/` (originally proposed) or another location.
- **Categorization gate** — design from earlier in session has a review-gate model: LLM tags each transcript by project + action type, generates proposals to `00-Inbox/proposals/`, Steve thumbs-up/down before any skill/plugin/agent/scaffolding is created. Awaiting go-ahead to move to that step.

## Next steps
1. User picks transcripts destination (vault vs scc vs leave in /tmp until next session)
2. Move scripts to a permanent home (proposed: `swan-command-center/app/worker/learning/`)
3. Build the categorizer + proposal generator (Claude API; per-transcript classification → proposal markdown in vault inbox)
4. Steve reviews proposals; approved ones become real skills/plugins/agents/scc upgrades
5. Iterate
