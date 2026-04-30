---
project: ai-consulting-company
entity: SwanBill LLC
brand: DeftForge
slack: "#deftforge"
website: https://deftforge.ai/
domain_alias: deftforge.com
created: 2026-04-29
---

# DeftForge

B2B AI automation consultancy. Two founders: **Steven Swan** and **Ryan Zacha**. Custom AI automations for client operations.

## Risk-reversal pricing model

Free initial build → client uses the system → client pays only if they retain it after refinements. **This shapes all messaging and design.**

## Domains

- **Primary:** `deftforge.ai` (Google Workspace primary, primary website)
- **Alias:** `deftforge.com` (Workspace alias for email; 301 redirects to .ai for web)
- **Registrar:** Porkbun
- **Hosting:** Vercel (static site, no build)

## Email

- `steven@deftforge.ai`, `ryan@deftforge.ai` (Workspace mailboxes)
- Both .com aliases route to the same inboxes
- DNS: Google MX × 5, SPF, DMARC (`p=none`)

## Folder layout

`/Users/stevenswan/project-folders/ai-consulting-company/` — index.html, preview.html, DESIGN.md, vercel.json. No build step.

## Design rules

**Always read `DESIGN.md` before making any visual or UI decisions.** All font choices, colors, spacing, and aesthetic direction are defined there. Do not deviate without explicit approval.

## Copy & messaging

- **Hero leads with the offer**, not the brand. "No upfront cost. Pay only if you keep using it." is the wedge.
- Tagline ("AI automation, deftly built.") lives in footer/about — never replaces the offer in hero.

## When responding in this channel

If Steven says "the site" he means deftforge.ai. The Slack channel name is `#deftforge` but the local folder and vault dir are `ai-consulting-company`.
