# AI Prompt Pack

This folder externalizes the AI generation assets so the prototype's GenAI behavior is inspectable instead of hidden inside `index.html`.

## What Lives Here

- `system_prompt.md`: global role, tone, and response behavior
- `grounding_rules.md`: grounding, citation, and stakeholder-adaptation guardrails
- `priority_rationale_prompt.md`: task template for the ranked-provider explanation
- `objection_response_prompt.md`: task template for objection handling and follow-up drafts
- `intro_script_prompt.md`: task template for a first-touch introduction
- `meeting_pitch_prompt.md`: task template for the 30-second pitch
- `week_plan_prompt.md`: task template for weekly route planning
- `eval_checklist.md`: lightweight self-check rubric used as part of the system prompt

## How The Prototype Uses These Files

At startup, the app tries to load the markdown files in this folder just like it loads the CSV, KB markdown, and CRM text inputs in `data/`.

If the files are available, the app uses them directly for generation.
If they are unavailable, the app falls back to embedded prompt strings so the prototype still works.

## Why This Helps The Case Study

- It makes the prompt architecture visible and reviewable.
- It shows separation between deterministic ranking logic and generative synthesis.
- It gives the slide deck concrete artifacts to reference for grounding, guardrails, and evaluation thinking.
