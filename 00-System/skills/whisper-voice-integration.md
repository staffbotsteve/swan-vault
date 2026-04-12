# Whisper Voice Integration

How voice input connects to the agent framework.

---

## Architecture

```
Steven (voice memo on iPhone)
    │
    │  iOS Shortcut: record → upload to S3/R2
    │
    ▼
Cloudflare Worker (serverless)
    │
    │  1. Fetch audio from storage
    │  2. Send to OpenAI Whisper API
    │  3. Receive transcription
    │  4. Create Managed Agent session with transcribed text
    │  5. Write raw transcript to vault: /00-Inbox/voice/
    │
    ▼
Managed Agent (processes the task)
    │
    │  On completion: vault write
    │
    ▼
Vault (Git)
```

## Components

### 1. iOS Shortcut (on Steven's phone)

- Trigger: tap shortcut or "Hey Siri, Swan Command"
- Records audio
- Uploads to Cloudflare R2 bucket (or S3)
- Sends webhook to Cloudflare Worker with file URL and metadata

### 2. Cloudflare Worker (serverless glue)

```javascript
// Pseudocode — the serverless function that ties it together
export default {
  async fetch(request, env) {
    const { audioUrl, company, priority } = await request.json();

    // Step 1: Transcribe with Whisper
    const transcription = await fetch("https://api.openai.com/v1/audio/transcriptions", {
      method: "POST",
      headers: { "Authorization": `Bearer ${env.OPENAI_API_KEY}` },
      body: formData  // audio file + model: "whisper-1"
    });
    const { text } = await transcription.json();

    // Step 2: Write raw transcript to vault
    await vaultWrite(
      `00-Inbox/voice/${timestamp}-transcript.md`,
      `voice: ${timestamp} transcript`,
      `# Voice Memo\n\n**Date:** ${timestamp}\n**Company:** ${company}\n\n${text}`
    );

    // Step 3: Create Managed Agent session
    const agentId = COMPANY_AGENT_MAP[company]; // maps to CEO agent
    const session = await fetch("https://api.anthropic.com/v1/sessions", {
      method: "POST",
      headers: {
        "x-api-key": env.ANTHROPIC_API_KEY,
        "anthropic-version": "2023-06-01",
        "anthropic-beta": "managed-agents-2026-04-01",
        "content-type": "application/json"
      },
      body: JSON.stringify({
        agent: agentId,
        environment_id: env.SWAN_ENV_ID
      })
    });

    // Step 4: Send transcribed text as task
    await fetch(`https://api.anthropic.com/v1/sessions/${session.id}/events`, {
      method: "POST",
      headers: { /* same headers */ },
      body: JSON.stringify({
        events: [{
          type: "user.message",
          content: [{ type: "text", text: text }]
        }]
      })
    });

    return new Response(JSON.stringify({ status: "dispatched", session: session.id }));
  }
};
```

### 3. Whisper API Configuration

- **Model:** `whisper-1`
- **Language:** `en` (hardcode to avoid misdetection)
- **Response format:** `json`
- **Cost:** ~$0.006 per minute of audio
- **Max file size:** 25MB (~90 minutes of audio)

### 4. Morning Briefing (TTS — future phase)

Reverse flow: daily rollup → OpenAI TTS API → audio file → push notification

```
Daily rollup agent generates summary text
    → OpenAI TTS API (model: tts-1, voice: onyx)
    → Audio file uploaded to R2
    → Push notification to Steven's phone with playback link
```

## Cost Estimate

| Component | Cost |
|-----------|------|
| Whisper transcription | ~$0.006/min |
| Cloudflare Worker | Free tier (100k requests/day) |
| R2 storage | Free tier (10GB) |
| Managed Agent session | $0.08/hr + tokens |
| TTS (future) | ~$0.015 per 1k chars |

**Total per voice memo:** ~$0.50-2.00 depending on agent runtime
