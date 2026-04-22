# 2026-04-22 — Voice dictation setup (Superwhisper)

- **Date:** 2026-04-22
- **Source:** Claude Code
- **Project:** 7702-n-silvercrest (environment setup)
- **Duration:** ~10 min
- **Status:** Complete (pending user first-run config in Superwhisper UI)

## Task
Enable voice dictation for Claude Code prompts and install Superwhisper.

## Outcome
Confirmed Claude Code has no native voice input; recommended Superwhisper as the best option for technical dictation. Installed Superwhisper 2.12.1 via Homebrew cask to /Applications/superwhisper.app and launched it for first-run setup. Saved a persistent memory note so future Claude sessions are forgiving of voice-transcription artifacts (homophones, terse phrasing, odd capitalization).

## Decisions
- Chose Superwhisper over Wispr Flow and native macOS dictation — better technical vocabulary handling, local model option for privacy.
- Recommended Medium Whisper model as the sweet spot (offline, fast, accurate enough for coding terms).
- Created persistent user-memory entry so future sessions auto-adjust to voice input quirks.

## Files changed
- `~/.claude/projects/-Users-stevenswan-project-folders-7702-n-silvercrest/memory/MEMORY.md` (created)
- `~/.claude/projects/-Users-stevenswan-project-folders-7702-n-silvercrest/memory/user_voice_input.md` (created)
- `/Applications/superwhisper.app` (installed via brew cask)

## Blocked / Needs input
Steven needs to complete Superwhisper's first-run config in the GUI: grant Microphone + Accessibility permissions, download a Whisper model, set hotkey, enable auto-paste.

## Next steps
- Steven completes Superwhisper onboarding.
- Optionally add custom vocabulary (gstack, swan-vault, silvercrest, Obsidian, project names) for better technical accuracy.
- Verify end-to-end: dictate a prompt into Claude Code and confirm auto-paste works.