---
type: template
updated: 2026-04-21
---

# Project folder template (role-first, 7 folders)

Every project at `~/project-folders/<project>/` uses this layout. One organizing axis: **the owning role**.

```
<project>/
├── README.md           # 1-para summary + link to vault CONTEXT.md
├── app/                # production code
├── engineering/        # specs, research, architecture, RFCs, QA plans, testing, operations
├── marketing/          # decks, brand, campaigns, competitive analysis, white papers
├── finance/            # models, investor docs, revenue, loan docs, tax
├── legal/              # contracts, IP, compliance, entity docs, regulatory
├── assets/             # shared media used across roles
└── archive/            # deprecated / abandoned / superseded
```

## Rules

1. **If you can name the owning role, that's the folder.** `assets/` is only for media genuinely shared across roles (e.g., company logo used by marketing *and* engineering *and* legal).
2. **Only create folders that have content.** Don't pre-create empty role folders. Add them when you're about to write the first file.
3. **`app/` holds canonical code.** Local folder name may differ from GitHub repo name — keeps remotes stable for Lovable, CI, deploys.
4. **Lowercase-hyphen file naming.** No dates in filenames unless intrinsically dated (session summaries are the exception).
5. **Sub-projects don't nest under parents.** If a software sub-project grows under an entity project (e.g., `incline-glide-transport` under Incline Tahoe), promote it to top-level and link via vault MOC.

## Typical content per role

| Role | Examples |
|---|---|
| `engineering/` | technical specs, architecture diagrams (when engineering-owned), research, RFCs, QA plans, testing artifacts, operations manuals, build handoffs |
| `marketing/` | decks (pitch, investor, sales), brand assets, campaigns, competitive analysis, white papers, stakeholder updates, press, GTM |
| `finance/` | financial models, investor docs, K-1s, subscription agreements, wire confirmations, loan documents, tax records, budgets |
| `legal/` | contracts, IP filings (patents, trademarks), compliance docs, entity formation, regulatory submissions (NTA, state filings), HR docs, lawsuits, depositions |
| `assets/` | cross-role media — company logo, property photos used by both marketing and legal appraisals, architectural renders used by multiple teams |
| `archive/` | deprecated code, old versions, abandoned experiments, zipped artifacts, superseded docs |

## Mapping guidance for edge cases

- **White paper** → `marketing/` (audience is stakeholders/customers, not the engineering team)
- **Technical whitepaper** → `engineering/` (audience is peer engineers)
- **Pitch deck** → `marketing/decks/`
- **Architecture diagram** → `assets/` if shared; `engineering/` if engineering-internal
- **K-1 / tax doc** → `finance/`
- **Subscription agreement / LLC formation** → `legal/`
- **Operations manual** → `engineering/`
- **Renders** (real estate, product) → `assets/` if used across roles; otherwise in the owning role
- **Status summary** → `engineering/` (internal PM artifact)
- **Stakeholder update** → `marketing/` (external-facing)

## Applying to a new project

```bash
cd ~/project-folders/<project>/
# Create only the folders you need right now
mkdir -p app engineering marketing finance legal assets archive
# Create README.md pointing to vault
cat > README.md <<EOF
# <Project Name>

<one paragraph>

Full context and status in vault: \`01-Projects/<Project>/CONTEXT.md\`
EOF
```

## History

- **2026-04-21**: Introduced role-first 7-folder template. Replaced earlier 6-bucket (`app/ research/ docs/ decks/ assets/ archive/`) which mixed output-type and role axes, creating ambiguity (pitch deck → `decks/` vs. `marketing/`?). One axis won.
