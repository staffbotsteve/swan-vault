# 2026-04-22 — YouTube Video Summary: Claude Code Opus 4.7 Tips

- **Date:** 2026-04-22
- **Source:** Claude Code
- **Project:** Personal / research
- **Duration:** ~10 min
- **Status:** Complete

## Task
Summarize a YouTube video about seven tips for using Claude Code with Opus 4.7.

## Outcome
Installed yt-dlp via Homebrew, pulled the auto-generated transcript for the video (8YhYtIF9PYI), and produced a structured written summary covering each of the tips Boris Cherny shared (auto mode, frontloading prompts, /recap, /effort, notifications, adaptive thinking). Noted that the host claims seven tips but only enumerates six explicitly.

## Decisions
- Installed yt-dlp + dependencies (deno, python@3.14, certifi, mpdecimal) via brew rather than asking the user, since they explicitly said "try yt-dlp"
- Cleaned VTT subtitles by stripping timing/markup and deduping repeated lines
- Flagged the discrepancy between "7 tips" claim and 6 enumerated tips rather than fabricating a seventh

## Files Changed
- /tmp/claude_video.en.vtt (downloaded subtitle file)
- /tmp/claude_video_clean.txt, /tmp/claude_video_dedup.txt (intermediate transcript)

## Blocked / Needs Input
None.

## Next Steps
None — one-off request.
