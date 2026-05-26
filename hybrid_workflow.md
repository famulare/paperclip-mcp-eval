# Hybrid Workflow (Pass 3)

**Origin:** Claude Opus 4.7 (1M context); inherits pass-2 hybrid workflow.
**Status:** Predeclared before hybrid runs.

## Decision Procedure (inherited from pass 2)

1. Start with source-of-record lookup for identity when DOI/PMID/PMCID/arXiv/NCT is known.
2. Run Paperclip search/lookup for candidate retrieval and virtual filesystem inventory.
3. Run local PDF search only for known targets likely in the evaluator's local PDF archive or old/scanned targets.
4. Validate identity before synthesis: title, key authors, year, source, identifiers, version label, short source-of-record anchor.
5. Validate supplements, figures/tables, protocols/SAPs before scoring missing-detail control.
6. Validate version lineage before scoring version/provenance.
7. For trial cases, use ClinicalTrials.gov API as registry truth and Paperclip only as reader/candidate source.
8. If arms conflict, source-of-record identity and registry fields win; Paperclip or local PDF may still contribute content evidence if identity is validated.
9. Stop when the source arm can answer the prompt with validated identity and required context, or save an explicit `NA` synthesis output.

## Pass-3 Modifier: Arm-Isolated Synthesizer

Hybrid is still a real arm with a real synthesizer subagent. Its evidence bundle explicitly combines arms in the order above. The hybrid synthesizer subagent:

- Receives a bundle assembled by following the decision procedure.
- Is told which arm each piece of evidence came from.
- Is told that the bundle is the only input.
- Answers the eight prompts as the hybrid arm.

This means the hybrid arm answer is NOT a maximum of single-arm answers. It is a single synthesizer's answer from a deliberately combined evidence bundle.

## Hybrid Run Logging

For each hybrid run, log to `hybrid_runs.csv`:

- `case_id`, `run_id`, `starting_input`.
- `steps`: ordered list of arms consulted.
- `identity_validated`, `supplements_checked`, `versions_checked`, `trial_registry_checked` (yes/partial/no/NA).
- `conflicts`: short list of arm disagreements.
- `final_answer_file`: link to `synthesis_outputs/<case>__hybrid.md`.
- `added_value_classification` (added in pass 3): A/B/C/D/E per `hybrid_value_classification.csv`.
- `elapsed_minutes`, `steps_count`.

## Added-Value Classification

Each hybrid run is classified into exactly one bucket in `hybrid_value_classification.csv`:

- **A:** Paperclip uniquely contributed evidence other arms did not (true hybrid win).
- **B:** Web/local could have done it alone faster; Paperclip was decoration.
- **C:** Paperclip-rescue (Paperclip failed; web/local recovered alone). NOT a hybrid win.
- **D:** Paperclip diagnostic only (uncovered a problem the user must know about, but did not contribute synthesis content).
- **E:** No added value.

Hybrid arm-level recommendation reports the count of A/B/C/D/E across runs, NOT a single composite score.
