# Vault Write System

How agents write to the Obsidian vault without Steven's laptop being open.

---

## Architecture

```
Managed Agent (Anthropic cloud)
    │
    │  HTTP request (GitHub Contents API)
    │
    ▼
GitHub repo: steven-swan/swan-vault
    │
    │  Auto-sync (Obsidian Git plugin, when laptop open)
    │
    ▼
Obsidian desktop (local vault)
```

No VPS. No webhook server. No middleware. Agents write directly to GitHub using the Contents API with a fine-grained PAT stored as an environment secret in Managed Agents.

---

## Setup (one-time)

### 1. Create the GitHub repo

```bash
gh repo create swan-vault --private --clone
cd swan-vault
# Copy this vault structure into it
git add -A && git commit -m "init: vault structure" && git push
```

### 2. Create a fine-grained Personal Access Token

Go to: https://github.com/settings/personal-access-tokens/new

- **Name:** `swan-vault-agent-writes`
- **Expiration:** 90 days (set a calendar reminder to rotate)
- **Repository access:** Only select repositories → `swan-vault`
- **Permissions:**
  - Contents: Read and write
  - Metadata: Read-only
- Copy the token. You will not see it again.

### 3. Store the PAT in your Managed Agents environment

When creating your Managed Agents environment, add the secret:

```bash
curl -sS https://api.anthropic.com/v1/environments \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "anthropic-beta: managed-agents-2026-04-01" \
  -H "content-type: application/json" \
  -d '{
    "name": "swan-production",
    "packages": ["python3", "git", "curl", "jq"],
    "network_access": {
      "allowed_domains": ["api.github.com"]
    },
    "secrets": {
      "GITHUB_PAT": "ghp_your_token_here",
      "VAULT_REPO": "steven-swan/swan-vault"
    }
  }'
```

### 4. Configure Obsidian Git plugin (local)

In Obsidian → Settings → Community Plugins → Obsidian Git:

- **Auto pull interval:** 10 minutes
- **Pull on startup:** enabled
- **Auto commit on close:** enabled (for your local edits)
- **Commit message format:** `vault: {{date}} local edit`

---

## How Agents Write to the Vault

Every agent has a bash function available in its environment. This is the vault write tool:

```bash
vault_write() {
  # Usage: vault_write "path/to/file.md" "commit message" "file content"
  local FILE_PATH="$1"
  local COMMIT_MSG="$2"
  local CONTENT="$3"
  local REPO="$VAULT_REPO"
  local BRANCH="main"

  # Base64 encode the content
  local ENCODED=$(echo -n "$CONTENT" | base64 -w 0)

  # Check if file exists (to get SHA for updates)
  local EXISTING=$(curl -sS \
    -H "Authorization: Bearer $GITHUB_PAT" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$REPO/contents/$FILE_PATH?ref=$BRANCH" \
    2>/dev/null)

  local SHA=$(echo "$EXISTING" | jq -r '.sha // empty')

  # Build the request body
  local BODY
  if [ -n "$SHA" ]; then
    BODY=$(jq -n \
      --arg msg "$COMMIT_MSG" \
      --arg content "$ENCODED" \
      --arg sha "$SHA" \
      --arg branch "$BRANCH" \
      '{message: $msg, content: $content, sha: $sha, branch: $branch}')
  else
    BODY=$(jq -n \
      --arg msg "$COMMIT_MSG" \
      --arg content "$ENCODED" \
      --arg branch "$BRANCH" \
      '{message: $msg, content: $content, branch: $branch}')
  fi

  # Write to GitHub
  local RESPONSE=$(curl -sS -w "\n%{http_code}" \
    -X PUT \
    -H "Authorization: Bearer $GITHUB_PAT" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$REPO/contents/$FILE_PATH" \
    -d "$BODY")

  local HTTP_CODE=$(echo "$RESPONSE" | tail -1)
  local RESPONSE_BODY=$(echo "$RESPONSE" | sed '$d')

  if [[ "$HTTP_CODE" == "200" || "$HTTP_CODE" == "201" ]]; then
    echo "✓ Vault write successful: $FILE_PATH"
    return 0
  else
    echo "✗ Vault write FAILED (HTTP $HTTP_CODE): $FILE_PATH"
    echo "$RESPONSE_BODY" | jq -r '.message // .'
    return 1
  fi
}
```

### Agent usage example

At the end of a session, the agent runs:

```bash
SUMMARY="# Session Summary

**Date:** 2026-04-12
**Agent:** providence-cto
**Company:** Providence Fire & Rescue Inc.
**Model:** claude-sonnet-4
**Duration:** 42 minutes
**Token cost:** \$6.14
**Status:** completed

---

## Task
Configure ArduPilot coaxial octocopter frame for Phase 1 prototype.

## Outcome
Frame configuration complete. Motor mapping validated for 8-motor coaxial layout with X8 geometry. PX4 parameters exported.

## Artifacts Produced
- /drone/phase1/frame-config.param
- /drone/phase1/motor-map.md

## Blocked / Needs Input
None.

## Next Steps
CTO to assign avionics integration to eng-alpha agent."

vault_write \
  "03-Sessions/Managed-Agents/2026-04-12-providence-cto-ardupilot-frame.md" \
  "session: providence-cto ardupilot frame config" \
  "$SUMMARY"
```

---

## Verification

To confirm writes are landing, an agent can verify:

```bash
vault_verify() {
  local FILE_PATH="$1"
  local RESPONSE=$(curl -sS \
    -H "Authorization: Bearer $GITHUB_PAT" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/$VAULT_REPO/contents/$FILE_PATH?ref=main")

  local NAME=$(echo "$RESPONSE" | jq -r '.name // empty')
  if [ -n "$NAME" ]; then
    echo "✓ Verified: $FILE_PATH exists in vault"
    return 0
  else
    echo "✗ Verification FAILED: $FILE_PATH not found"
    return 1
  fi
}
```

---

## Daily Rollup (scheduled)

A scheduled Managed Agent session runs at 06:00 MST daily:

1. Reads all files in `/03-Sessions/Managed-Agents/` with today's date prefix
2. Generates a consolidated daily note
3. Writes it to `/04-Daily/YYYY-MM-DD.md`
4. The daily note contains: summary of all agent activity, total cost, decisions made, items awaiting Steven's review

This is the first thing Steven sees when he opens Obsidian in the morning.

---

## Security Notes

- The PAT has minimal scope: read/write to one repo only
- PAT is stored in Managed Agents encrypted secret store — agents can use it but cannot read the raw value
- Rotate every 90 days (GitHub supports fine-grained expiration)
- The vault repo is private — no public access
- Git history provides a full audit trail of every agent write
