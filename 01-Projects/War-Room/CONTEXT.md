---
project: war-room
entity: Operations
slack: "#war-room"
launch_command: ./companion/war-room/run.sh
created: 2026-04-29
---

# War Room

Hands-free voice channel into the Swan Command Center. Local Gemini Live audio loop on Steven's Mac with three live tools: hive_query, vault_read_file, slack_send_message.

## How to launch

```bash
cd /Users/stevenswan/project-folders/swan-command-center/app
./companion/war-room/run.sh
```

You'll see `connected. speak naturally; ctrl+c to stop.` Talk into the laptop mic; the assistant talks back through the speaker. Live transcripts print to the terminal as `[you]` / `[assistant]` lines.

## What it can do today (v1)

- **hive_query** — read your current task queue from Supabase
- **vault_read_file** — pull any markdown from staffbotsteve/swan-vault
- **slack_send_message** — send a Slack to any of your channels (send-on-dictation; no permission stall)

System prompt knows your channel taxonomy and Steven's voice preferences. Sends to channels by name without asking for clarification.

## Roadmap

- **v2**: WebRTC trigger so you can join from your phone instead of needing the Mac terminal open
- **v3**: Twilio phone number — call the war room like a person
- **v4**: more tools (gmail send, calendar read, NotebookLM ask)

## When responding in this channel

This Slack channel is the **discoverable home** for the war room — a place to drop notes, transcripts, or decisions made during a war-room session. The actual voice loop runs on Steven's Mac, not in Slack. If Steven asks "start the war room" or "what's the war room command", the answer is the launch command above.

## Cost

Per-second native-audio Flash rates (`gemini-2.5-flash-native-audio-latest`). Roughly \$0.50–\$2 per 10-min session. Run only when actively using.
