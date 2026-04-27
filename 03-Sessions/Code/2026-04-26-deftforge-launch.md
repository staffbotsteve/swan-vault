# DeftForge Launch — Initial Session

- **Date:** 2026-04-26
- **Source:** Claude Code
- **Project:** DeftForge
- **Duration estimate:** ~3 hours
- **Status:** Shipped (live at https://deftforge.ai)

## Task
Stand up DeftForge as a new B2B AI automation consultancy with Ryan Zacha — name, domains, email, brand, design system, and live marketing site.

## Outcome
DeftForge is operational. The brand is established (name, tagline, design system), both domains are registered with Google Workspace email running, and the marketing site is live at deftforge.ai with proper SSL and a `.com → .ai` 301 redirect. The site articulates the risk-reversal pricing model — clients pay only if they keep using what we build for them — which is the core wedge that distinguishes DeftForge from generic AI consultancies.

## Decisions made
- **Brand name:** DeftForge — chosen from a 100+ candidate availability sweep across `.com`, `.io`, `.ai`, `.co` (one of nine names with all four TLDs available)
- **Pricing model:** Risk-reversal — free initial build, client pays only after retaining the system following refinements
- **Primary domain:** deftforge.ai (with deftforge.com as alias for email + 301 redirect for web)
- **Email:** Google Workspace Business Starter, $7/user/mo × 2 founders; primary mailboxes steven@deftforge.ai, ryan@deftforge.ai
- **Hosting:** Vercel (free tier, GitHub-connected)
- **Tagline:** "AI automation, deftly built." (footer/about); hero leads with the offer instead
- **Design direction:** Brutally minimal, editorial-leaning. Geist font family. Single warm copper accent (#C26B3F) on warm paper white background. Light mode primary, dark toggle available.
- **Hero copy:** "We build custom AI for *your* operations. You don't pay until you decide to keep it." — leads with the offer, not the brand
- **No 3-column feature grid.** Manifesto, not brochure.

## Files changed
- `index.html` — production homepage (single file, no build step)
- `preview.html` — design system preview with system reference visible
- `DESIGN.md` — canonical design system spec
- `CLAUDE.md` — project notes for future AI sessions
- `vercel.json` — security headers + clean URLs
- `README.md` — repo overview
- `.gitignore`
- GitHub repo: github.com/staffbotsteve/deftforge (private)
- Porkbun DNS: full reconfiguration on both domains (Google MX × 5, SPF, DMARC, Vercel A records on .ai, URL forwarding on .com)
- Vercel project: `sactoswan-projects/deftforge` linked to GitHub, custom domains + SSL provisioned
- `~/.claude/projects/-Users-stevenswan-project-folders-ai-consulting-company/memory/project_deftforge_business_model.md` — saved business model to persistent memory

## Blocked / Needs input
- **Vercel auto-deploy from GitHub is failing.** Every deploy after the initial successful one returns "Unexpected error" with no actionable logs. Routes inspect shows the redirects compile correctly; the issue appears to be at the Vercel platform layer. The currently-serving deploy is the original `h3kgtg8s9` build. Future content updates need either a manual `vercel deploy` retry once the platform settles, or a deeper diagnostic.

## Next steps
- Replace founder avatar monograms with real photos
- Wire the "Book a slot" CTA to Cal.com or SavvyCal
- Once we have a first client, replace the manifesto with a real case study
- Diagnose and fix Vercel auto-deploy failure (priority: only matters when content changes ship)
- Begin client outreach using the new email + site