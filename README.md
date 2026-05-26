# Paperclip MCP literature evaluation

**TL;DR:** Paperclip (gxl.ai's literature MCP) is a thin PMC-skim layer dressed up as a literature retrieval / synthesis tool. It is not safe to use as a load-bearing component of a knowledge base. Use a hybrid workflow with PubMed / arXiv / ClinicalTrials.gov / publisher pages as the default; Paperclip is permitted as a PMID-confirmed PMC content-skim layer inside that workflow, and nowhere else.

See [`final_recommendation.md`](final_recommendation.md) for the full recommendation with role-by-role scoring and the methodology that produced it.

## Who built this and for what

The evaluator is Mike Famulare, Principal Research Scientist at the Institute for Disease Modeling (IDM) in the Global Health Division at the Gates Foundation. The "Fermi KB" referenced throughout is the evaluator's internal knowledge base for infectious-disease modeling — a Fermi-estimate-style collection that needs literature with provenance-grade audit characteristics (every claim traces to an artifact, every artifact to a source-of-record). "IDM" / "Institute for Disease Modeling" appears in some corpus papers' author affiliations and in some synthesis outputs; it is the evaluator's current employer.

**Authorship.** Mike Famulare is the project planner, reviewer, and accountable party — corpus definition, rubric, contract, scorer adjudication, and the final recommendation are his. The text in this repository (methodology, synthesis outputs, scorer outputs, the recommendation, per-arm evidence bundles) and the PowerShell tooling were written by Claude Opus 4.7 (Anthropic), operating as the pass-3 orchestrating agent and as arm-isolated synthesizer / scorer subagents. Treat the work as AI-implemented under human direction and review.

**Disclosure:** two corpus cases (`famulare-2018-plosbio` and `thakkar-famulare-arxiv`) are co-authored by the evaluator. This is intentional — testing a literature tool against papers the evaluator knows in detail is a stronger probe of fidelity than testing only stranger material. Synthesis outputs for these cases were produced by an arm-isolated Claude Opus 4.7 subagent under explicit "no outside knowledge" instructions, same as all other cases. See [`methodology.md`](methodology.md) §"Arm isolation (mandatory)".

## Bottom line in 5 findings

1. **Paperclip's corpus is PMC-anchored.** Annual Reviews (0/3 probed hit), pre-1980 NEJM (0/3), and paywalled non-PMC papers like Lancet 2019 RCTs and the NEJM 2018 ATTR-ACT cardiology trial (0/3 + 1 held-out miss) are not indexed. See [`index_scope_findings.md`](index_scope_findings.md).
2. **DOI lookup is unreliable.** 15/15 DOI lookups missed across the controlled corpus + 12 index-scope probes — even on papers that ARE in PMC. PMID lookup is the only reliable resolver, and only for PMC-versioned targets.
3. **`map -n N` does not honor `N`.** Map output across multiple papers is contaminated by default. The advertised "process top N results" silently processes all returned results. See `retrieval_packets/*__map_n_probe.txt`.
4. **No refusal behavior on impossible queries.** 3/3 impossible-blend negative controls returned 4–6 candidates without uncertainty signal. Unsafe for any KB workflow that values entity-discrimination. See [`negative_controls.csv`](negative_controls.csv).
5. **Strict-A unique value contribution = 0/14.** Under the contract's strict criterion ("Paperclip uniquely contributed evidence other arms could not have given"), Paperclip contributed zero unique value across 14 cases. Distribution: A=0, B=4 (web-alone-faster), C=6 (Paperclip-rescue), D=2 (diagnostic only), E=1 (no value), F=1 (backup-when-web-degraded). See [`hybrid_value_classification.csv`](hybrid_value_classification.csv).

Paperclip arm Domain Usefulness mean across 14 cases = **1.9/5**. Hybrid arm overall mean = **~4.1/5**.

## Repo guide

### Top-level documents

| File | Purpose |
|---|---|
| [`README.md`](README.md) | This file. Summary + how to read the repo. |
| [`final_recommendation.md`](final_recommendation.md) | The headline: role-by-role recommendation with all artifact citations. |
| [`methodology.md`](methodology.md) | How the evaluation was conducted end-to-end. Methodology limitations declared up front. |
| [`adversarial_review_response.md`](adversarial_review_response.md) | Independent Opus subagent review of the draft recommendation + main-agent responses. |
| [`scoring_rubric.md`](scoring_rubric.md) | 1–5 rubric with hard caps. |
| [`hybrid_workflow.md`](hybrid_workflow.md) | Predeclared hybrid decision procedure + A/B/C/D/E/F classification scheme. |
| [`error_taxonomy.md`](error_taxonomy.md) | Catalog of observed errors with severity and artifact links. |
| [`index_scope_findings.md`](index_scope_findings.md) | What Paperclip indexes / what it doesn't (Annual Reviews, pre-1980, paywalled-non-PMC). |

### Data tables (CSV)

| File | Rows | Purpose |
|---|---|---|
| [`corpus_registry.csv`](corpus_registry.csv) | 14 | Cases evaluated (9 known + 5 held-out). |
| [`retrieval_observations.csv`](retrieval_observations.csv) | 91 | Every Paperclip command, output, and resolved ID. |
| [`identity_validation.csv`](identity_validation.csv) | 46 | Per case × arm: title/author/year/identifier match status. |
| [`supplement_inventory.csv`](supplement_inventory.csv) | 13 | Per supplement-bearing case × arm: supplement files visible per arm. |
| [`version_lineage.csv`](version_lineage.csv) | 8 | Per versioned case × arm: preprint/final/postprint validation. |
| [`trial_reconciliation.csv`](trial_reconciliation.csv) | 2 | NCT04232943 paperclip vs web arm reconciliation. |
| [`negative_controls.csv`](negative_controls.csv) | 5 | Near-miss + impossible-blend results under strict refusal rule. |
| [`hybrid_runs.csv`](hybrid_runs.csv) | 14 | Hybrid workflow runs per case with A/B/C/D/E/F classification. |
| [`hybrid_value_classification.csv`](hybrid_value_classification.csv) | 14 | Per-run added-value classification (strict A criterion). |
| [`index_scope_probes.csv`](index_scope_probes.csv) | 12 | Probes across 4 Paperclip-miss classes (Annual Reviews, Nat Med PMID-only, pre-1980, paywalled). |
| [`synthesis_scores.csv`](synthesis_scores.csv) | 46 | Per case × arm: 8-dimension scores + caps + adjudication. |
| [`heldout_selection.json`](heldout_selection.json) | 5 | Audit trail of held-out PubMed-query selection. |

### Evidence directories

| Directory | Count | What's there |
|---|---|---|
| [`ground_truth/`](ground_truth/) | 14 | Per-case authoritative metadata + abstract + diagnostic anchors built BEFORE Paperclip retrieval. |
| [`evidence_bundles/`](evidence_bundles/) | 46 | Per case × arm bundle containing ONLY that arm's evidence. Input to synthesizer subagents. |
| [`synthesis_outputs/`](synthesis_outputs/) | 46 | Per case × arm: Opus synthesizer's 8-prompt answers from arm-isolated bundle. |
| [`scorer_packets/output/`](scorer_packets/output/) | 2 | Two independent Opus scorer subagent outputs covering all 46 syntheses. |
| [`retrieval_packets/`](retrieval_packets/) | 112 | Every Paperclip MCP command + verbatim output, timestamped. |
| [`validation_logs/`](validation_logs/) | + 8 | Local PDF metrics + head/tail slices; source-of-record metadata cache. |
| [`tools/`](tools/) | 10 | PowerShell tools for re-running each phase. |

## Methodology summary

Two-layer arm-isolated synthesis evaluation:

1. **Ground truth built from authoritative sources** (PubMed / arXiv / ClinicalTrials.gov) BEFORE any Paperclip retrieval, so the answer key cannot be polluted by the evaluation target.
2. **Per-arm retrieval** with strict isolation — Paperclip arm, Web/API arm, Local PDF arm, and Hybrid arm.
3. **Arm-isolated synthesis** — separate Opus subagent per arm, sees only that arm's evidence bundle, no outside knowledge.
4. **Two-call scoring** by independent Opus subagent invocations using the rubric, with main-agent adjudication of disagreements.
5. **Hard caps** on the rubric trigger on synthesis content (wrong document, wrong version, missing supplement validation, trial-map failure, wrong content organization, no refusal behavior).
6. **Adversarial self-review** by a separate Opus subagent before the recommendation closes.

Full methodology with limitations declared in [`methodology.md`](methodology.md).

## Findings

- The recommendation — what to do about Paperclip: [`final_recommendation.md`](final_recommendation.md)
- The indexing scope — what Paperclip can and can't find: [`index_scope_findings.md`](index_scope_findings.md)
- The error taxonomy — what specifically goes wrong: [`error_taxonomy.md`](error_taxonomy.md)
- The adversarial review — where the recommendation could be wrong: [`adversarial_review_response.md`](adversarial_review_response.md)

## Reproducing this evaluation

Environment: PowerShell 7+, `curl`, `pdftotext` / `pdfinfo`, Paperclip API key at `.paperclip.key` (gitignored), optional NCBI API key.

Phase tools in [`tools/`](tools/):

- Ground truth: `Build-GroundTruth.ps1`
- Held-out selection: `Select-HeldOut.ps1`
- Paperclip retrieval: `Run-PaperclipRetrieval.ps1` (driver) + `Invoke-PaperclipMcp.ps1` (HTTP wrapper)
- Index-scope probes: `Probe-IndexScope.ps1`
- Local PDF slices: `Extract-LocalPdfSlices.ps1` + `Measure-ArticlePdf.ps1`
- Evidence bundles: `Build-EvidenceBundles.ps1`
- Score compilation: `Compile-Scores.ps1`
- Verification: `Test-Artifacts.ps1`

Synthesizer + scorer subagents are launched from the orchestrating agent (Claude Opus 4.7). See `methodology.md` §"Reproducing this evaluation" for the run order.

## License and contact

Author: Mike Famulare. Reach out via GitHub.
