# Dev Session — Providence Heli-Watch Notification Fix
Date: 2026-04-30

## Repo
`/Users/stevenswan/project-folders/providence-heli-watch/app`
No remote pushed yet (no git remote configured in project folder).

## Finding
The poller (`server/poller.ts:194-201`) already calls `sendEmailAlerts` and `sendSlackAlerts` after every poll cycle. Both functions are fully implemented. Notifications were not firing purely because of missing env vars AND one missing npm dependency.

## Root cause
`server/email.ts` imports `nodemailer` at line 1, but `nodemailer` is not in `package.json` or `pnpm-lock.yaml`. This causes a module-not-found crash in production, silently swallowed by the `.catch()` in poller.ts.

## Changes made
1. `package.json` — added `nodemailer: ^3.1.0` to dependencies, `@types/nodemailer: ^6.4.17` to devDependencies
2. `server/email.ts` — rewrote to add HTML email body with clickable listing links; hardcoded fallback recipient `sactoswan@gmail.com` if `EMAIL_TO` env is empty
3. `server/slack.ts` — added footer line to Slack blocks pointing to war-room channel context; no logic change

## Env vars required (Steven must set these)
### Email
- `GMAIL_USER` — sending Gmail address (recommend a dedicated `heliwatch@gmail.com`)
- `GMAIL_APP_PASSWORD` — Gmail App Password (not account password; requires 2FA, generate at myaccount.google.com/apppasswords)
- `EMAIL_TO` — set to `sactoswan@gmail.com` (already hardcoded as fallback)

### Slack
- `SLACK_WEBHOOK_URL` — Incoming Webhook URL for #war-room or #heli-watch channel
  - Create at: api.slack.com/apps > Your App > Incoming Webhooks

## After setting env vars
Run `pnpm install` to pull nodemailer, then restart the dev server. Next poll cycle (15 min) will fire both channels.

## Pinned invariant
`nodemailer` must stay in package.json dependencies — it is a runtime server dep, not a dev dep.
