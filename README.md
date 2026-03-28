# Tempus Sales Copilot

Single-file prototype for the Tempus sales copilot case study, built as an account-prep workspace for oncology field reps.

## What This Includes

- `index.html`: interactive prototype that ingests the mock input files below at startup, with embedded fallback data if the files are unavailable
- `data/market_intelligence.csv`: mock market intelligence input for 10 physicians and decision-makers
- `data/product_knowledge_base.md`: public Tempus product facts and citations used to ground the prototype
- `data/crm_notes.txt`: mock CRM interaction notes for 10 physicians and stakeholders
- `docs/`: problem framing, data contract, and scoring rubric for the case-study workflow
- `prompts/`: internal prompt pack for the main generation flows
- `evals/`: output checklist used as part of the generation guardrails
- `ai/`: supplemental runtime prompt assets for secondary generation flows
- `scripts/validate_ai_assets.ps1`: lightweight validator for the AI prompt pack files
- `scripts/validate_local_inputs.ps1`: validator for the local market, CRM, and product inputs

Private presentation materials such as the slide-deck outline and demo script are intentionally kept out of the submitted repo.

## How To Open The Prototype

Recommended and preferred for the evaluator:

```powershell
python -m http.server 8080
```

Then open `http://localhost:8080`.

Opening `index.html` directly may fall back to the embedded copy of the data. Use a local server if you want the prototype to visibly ingest the CSV, markdown, and CRM text files at runtime.

## Prompt And Eval Pack

The generative flows are no longer defined only inline in `index.html`.

The strongest reviewable artifacts now live in:

- `docs/problem-framing.md`
- `docs/data-contract.md`
- `docs/scoring-rubric.md`
- `prompts/system.md`
- `prompts/objection-handler.md`
- `prompts/meeting-script.md`
- `evals/output-checklist.md`

The runtime prompt loader now directly uses:

- `prompts/system.md`
- `prompts/objection-handler.md`
- `prompts/meeting-script.md`
- `evals/output-checklist.md`

Additional runtime prompt templates still live in `ai/` for:

- priority rationale
- intro script
- week plan

That gives the case study a visible, inspectable prompt architecture with clearer separation between product thinking and prompt design:

- deterministic ranking stays in application logic
- product and workflow assumptions live in `docs/`
- generation behavior lives in `prompts/`
- evaluation thinking lives in `evals/`
- secondary task templates remain inspectable in `ai/`

If those files are unavailable, the app falls back to embedded prompt strings so the evaluator can still use the prototype.

To validate the prompt pack locally:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate_ai_assets.ps1
```

To validate the local market, CRM, and product inputs:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate_local_inputs.ps1
```

## Demo Modes

- Free local demo mode is the default.
- No API key is required for the ranked list, objection handler, meeting script, or week-plan outputs.
- Connecting Claude is optional and only adds streaming rewrites inside the same UI.
- In deployed mode, `Connect Claude` uses a same-origin server proxy and stays in `Demo Mode` if that proxy is unavailable.
- Local development still supports manual Anthropic-key entry when the proxy route is unavailable.

## Interface Notes

- The left rail is a single tabbed control surface with `Plan` and `Providers`.
- `Plan` is the morning-triage view: ranked signal, top-priority accounts, and `Plan this week`.
- `Providers` combines search, relationship filters, sort controls, the provider count, and the provider queue in one working surface.
- The right workspace starts with the `Prep Brief`, `Objections`, and `Talk Track` tabs at the top.
- `Export Prep` lives at the far right of the tab bar instead of inside the provider hero.
- The `Prep Brief` hero keeps the provider identity block aligned with `Next Best Action`, while the score breakdown and essentials sit directly below it.

## Data Provenance

- Product facts and reference links come from public Tempus web pages, PDFs, news posts, and the public media kit.
- Provider names, volumes, relationship stages, competitor mix, and CRM notes are synthetic and intended only to simulate a realistic Chicago territory.
- Branding is intentionally restrained and labeled as a concept prototype rather than an official Tempus internal product.
- The repo now includes explicit source artifacts in `data/` to mirror the case-study input requirements directly.

## Case Study Mapping

Inputs:

- Market Intelligence: `data/market_intelligence.csv`
- Product Knowledge Base: `data/product_knowledge_base.md`
- CRM Notes: `data/crm_notes.txt`

Outputs:

- Ranked provider list ordered by deterministic impact score
- Objection handler grounded in the product reference pack
- 30-second meeting script tailored to the selected provider and stakeholder type

## Product Decisions

- Ranking is deterministic and explainable; GenAI is not used for prioritization.
- The ranked list is optimized for morning territory triage.
- Provider detail is optimized for pre-meeting prep in one continuous workspace.
- Institutional stakeholders and treating oncologists use different talking points and next steps.
- `Account Fit` is a structured scoring input derived from specialty, payer mix, and incumbent matchup, not model judgment.

## Deploying The Claude Proxy

- Add `ANTHROPIC_API_KEY` as a Vercel environment variable.
- Deploy the repo as a static site with the included same-origin serverless route at `api/claude.js`.
- In Vercel, the prototype will still open in `Demo Mode` by default.
- When a reviewer clicks `Connect Claude`, the app checks `/api/claude` and switches to `Claude Connected` without exposing the Anthropic key in the browser.

## Assumptions

- Territory is Chicago metro.
- Data is mock but modeled after realistic oncology workflows.
- The rep needs a "what should I do this week?" tool, not just a prettier profile viewer.
- Free-tooling compliance matters, so the core prototype works without a paid model connection.

## Notes For Evaluators

- The app auto-selects the top-ranked provider on load.
- The left and right work areas are resizable so the evaluator can bias the prototype toward queue management or deep prep.
- Every provider includes a visible Why Now signal and score breakdown.
- Generated outputs include source-backed reference packs in the UI.
- The repo includes an internal prompt/eval pack in `docs/`, `prompts/`, and `evals/` so product framing, prompt behavior, and evaluation criteria can be reviewed directly.
