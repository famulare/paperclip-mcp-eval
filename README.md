# Paperclip MCP literature evaluation

This repository is an empirical evaluation of [Paperclip](https://paperclip.gxl.ai/) — gxl.ai's literature MCP server — as a candidate component in a research knowledge base. It documents 14 test cases, four retrieval arms (Paperclip, web/API, local PDF, hybrid), and per-arm Opus-graded syntheses, with the full evidence chain preserved so the conclusions can be re-derived from the artifacts.

**Headline.** Paperclip works cleanly inside a narrow safe-use box — PMID-confirmed inspection of PMC-versioned papers — and is less reliable outside it. The recommendation is a hybrid workflow with Paperclip as one ingredient, not as a default tool. We list five specific bugs whose fix would meaningfully expand Paperclip's safe-use box, plus three more durable architectural limitations.

For the full role-by-role recommendation see [`final_recommendation.md`](final_recommendation.md); for the methodology see [`methodology.md`](methodology.md).

## Who built this and for what

The evaluator is Mike Famulare, Principal Research Scientist at the Institute for Disease Modeling (IDM) in the Global Health Division at the Gates Foundation. The "Fermi KB" referenced throughout is the evaluator's internal knowledge base that needs literature with provenance-grade audit characteristics (every claim traces to an artifact, every artifact to a source-of-record). "IDM" / "Institute for Disease Modeling" appears in some corpus papers' author affiliations and in some synthesis outputs; it is the evaluator's current employer.

**Authorship.** Mike Famulare is the project planner, reviewer, and accountable party — corpus definition, rubric, contract, scorer adjudication, and the final recommendation are his. The text in this repository (methodology, synthesis outputs, scorer outputs, the recommendation, per-arm evidence bundles) and the PowerShell tooling were written by Claude Opus 4.7 (Anthropic), operating as the pass-3 orchestrating agent and as arm-isolated synthesizer / scorer subagents. Treat the work as AI-implemented under human direction and review.

**Disclosure:** two corpus cases (`famulare-2018-plosbio` and `thakkar-famulare-arxiv`) are co-authored by the evaluator. This is intentional — testing a literature tool against papers the evaluator knows in detail is a stronger probe of fidelity than testing only stranger material. Synthesis outputs for these cases were produced by an arm-isolated Claude Opus 4.7 subagent under explicit "no outside knowledge" instructions, same as all other cases. See [`methodology.md`](methodology.md) §"Arm isolation (mandatory)".

## The question this evaluation asked

The use case is provenance-grade literature ingestion into a research knowledge base. Every claim that enters must trace to an artifact, and every artifact to a source-of-record (PubMed, ClinicalTrials.gov v2, arXiv, publisher of record). That bar is higher than "retrieve relevant papers" — it's "give me content I can quote, with versions distinguished, supplements identified, and corner cases (impossible queries, paywalled non-PMC papers, older literature, preprint vs final) handled either correctly or with an explicit 'I don't know' signal."

Paperclip is a natural candidate for this. It exposes papers as a virtual filesystem (`ls /papers/PMC.../supplements/`, `wc` and `grep` over `content.lines`), it has MCP integration so it composes cleanly with agentic workflows, and gxl.ai is working on a real problem — research literature is hard to retrieve cleanly. The question for this evaluation is whether Paperclip's current implementation clears that provenance bar, and where it does and doesn't.

## How we tested it

**Corpus.** 9 known-target cases that exercise specific stresses — supplement-heavy papers, preprint/final version pairs, pre-1980 OCR-poor scans, trial-paper bridges, content-organization probes — plus 5 deterministically-selected held-out cases from PubMed (audit trail in [`heldout_selection.json`](heldout_selection.json)). Full list in [`corpus_registry.csv`](corpus_registry.csv).

**Four arms.** Paperclip; web/API (PubMed esummary, ClinicalTrials.gov v2, arXiv, publisher pages); local PDF (when available in the evaluator's archive); and Hybrid (the three combined under a predeclared decision procedure in [`hybrid_workflow.md`](hybrid_workflow.md)).

**Arm isolation.** Each arm's evidence bundle was assembled by tooling that reads only arm-specific sources. Synthesis was performed by a separate Claude Opus 4.7 subagent per bundle answering 8 fixed prompts under "no outside knowledge" instructions, so cross-arm leakage couldn't artificially help the weaker arms.

**Scoring.** Two independent Opus 4.7 scorer subagent calls per synthesis output, against the rubric in [`scoring_rubric.md`](scoring_rubric.md). Hard caps trigger on synthesis content, not arm name — wrong document → overall ≤ 1; invalid identity → ≤ 2; wrong content organization → document-reader role ≤ 2. Main-agent adjudication of disagreements with a conservative-lower-score rule.

**Adversarial self-review.** A separate Opus subagent attacked the draft recommendation; findings and per-finding responses are preserved in [`adversarial_review_response.md`](adversarial_review_response.md). The adversarial reviewer caught a fabricated citation, an arithmetic error in the hybrid tally, and an unblinded-scoring contract violation, all corrected.

**Methodology limitations are declared up front** in [`methodology.md`](methodology.md) §"Methodology limitations (declared)" — most importantly that scoring was not fully blind (the anonymization step was skipped during execution; both scorers are the same model so they offer sampling-noise independence rather than structural independence) and that 4 of 5 held-out cases are partially in-wheelhouse rather than unambiguously outside.

## What we found

### Where Paperclip works cleanly

- **PMID lookup on PMC-versioned papers.** 9 of 14 cases resolved cleanly by PMID when the target was in PMC (Famulare 2018 PLOS Biology, SFS NEJM correspondence, the IPV/dmLT trial paper, the held-out HCV / snakebite / podoconiosis cases, etc.). The `wc /papers/<PMCID>/content.lines` + `grep` workflow is genuinely useful for content inspection once the right paper is in hand. Repro: [`retrieval_packets/famulare-2018-plosbio__lookup_pmid.txt`](retrieval_packets/famulare-2018-plosbio__lookup_pmid.txt).
- **Filesystem-style supplement inventory when present.** For papers like Famulare 2018, `ls /papers/PMC5942853/supplements/` returns the two supplementary files cleanly with stable paths. The filesystem abstraction is a real ergonomic win for agentic workflows. Repro: [`retrieval_packets/famulare-2018-plosbio__ls_supplements.txt`](retrieval_packets/famulare-2018-plosbio__ls_supplements.txt).
- **arXiv-side redundancy when external APIs are degraded.** For the Thakkar/Famulare arXiv pair, Paperclip resolved the paper identity cleanly when the external arXiv API was rate-limiting our web-arm retrieval. Not a unique contribution to evidence, but a real redundancy backstop. Repro: [`retrieval_packets/thakkar-famulare-arxiv__lookup_arxiv_2205_02150.txt`](retrieval_packets/thakkar-famulare-arxiv__lookup_arxiv_2205_02150.txt).

### Where we hit mechanical bugs

Each is reproducible from the linked packet with the exact command that triggers the behavior. These look like the kind of issues that vendors typically fix in maintenance cycles when surfaced:

1. **`map -n N` does not honor `N`.** Three test cases ran `map --from <handle> -n 1` and got back 5/5, 4/4, and 5/5 tasks respectively (one per paper in the search set, not one total). Synthesis output is silently contaminated across multiple papers unless the caller knows to extract the target's section. Repro: [`retrieval_packets/famulare-2018-plosbio__map_n_probe.txt`](retrieval_packets/famulare-2018-plosbio__map_n_probe.txt) (and the `*__map_n_probe.txt` packets for `nigeria-2015` and `nct04232943`).
2. **Trial `map` errors with a UUID type mismatch.** `map` on a `tri_*` document ID returns `ERR: map: invalid input syntax for type uuid: "tri_7fa7a997858a"`. Looks like a schema mismatch between trial-document IDs and the SQL backend's UUID column. Repro: [`retrieval_packets/nct04232943-pmid36746739__trial_map.txt`](retrieval_packets/nct04232943-pmid36746739__trial_map.txt).
3. **DOI lookup misses, including on papers that resolve by PMID.** 15 of 15 DOI lookups missed across the controlled corpus + 12 index-scope probes — including DOIs for papers that Paperclip *does* index (resolvable by PMID). Looks like a DOI-normalization or DOI-index-coverage issue rather than a fundamental architecture problem. Repro: [`retrieval_packets/famulare-2018-plosbio__lookup_doi.txt`](retrieval_packets/famulare-2018-plosbio__lookup_doi.txt).
4. **Supplementary appendix merged into `content.lines` while `supplements/` is empty.** For the SFS NEJM correspondence, `ls /papers/PMC7206929/supplements/` returns empty, but `grep -n -i "supplement|appendix" /papers/PMC7206929/content.lines` shows the entire supplementary appendix is in the main content blob — section headers (`# Supplementary Appendix`), preamble, and table references (`Supplemental Table 1`). Looks like an ingestion-pipeline edge case for NEJM Correspondence format. Repro: [`retrieval_packets/sfs-nejm-2020__ls_supplements.txt`](retrieval_packets/sfs-nejm-2020__ls_supplements.txt) + [`__grep_supplement.txt`](retrieval_packets/sfs-nejm-2020__grep_supplement.txt).
5. **Title-search recency-bias surfaces preprint over the requested final.** For Khoury 2021 ("Neutralizing antibody levels are highly predictive of immune protection..."), title search returned the medRxiv preprint at rank 2; the Nature Medicine final wasn't in the result set (it's also a DOI-lookup miss per #3). The numerical values in the preprint differ from the final, so this is a wrong-version risk in any workflow that trusts title-search ranking. Repro: [`retrieval_packets/khoury-2021-natmed__search_title.txt`](retrieval_packets/khoury-2021-natmed__search_title.txt).

### Where we hit architectural limitations

These look more durable — they reflect product-design or corpus-coverage choices that may be harder to change without significant work:

- **The corpus is PMC-anchored.** Annual Reviews 0/3 probed hit; pre-1980 NEJM 0/3 probed hit; paywalled non-PMC papers (Lancet 2019 RCTs, the NEJM 2018 ATTR-ACT cardiology trial) 0/3 + 1 held-out miss. For literature outside PMC, Paperclip is silent in a way that's indistinguishable from "the paper doesn't exist." Per-class probes in [`index_scope_probes.csv`](index_scope_probes.csv).
- **Version lineage is collapsed.** Paperclip's record schema doesn't distinguish preprint / accepted manuscript / final / postprint / corrected. For Nigeria 2015 (arXiv v1, v2, and PLOS ONE final, same paper), `lookup arxiv 1504.02751` returns a single record dated 2015-04-10 carrying the PLOS ONE DOI. Three distinct versions visible to other tools collapsed into one inside Paperclip. Repro: [`retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt`](retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt).
- **No refusal / uncertainty signal on impossible queries.** Three impossible-blend queries (e.g., "Famulare Covasim Hornick typhoid challenge" — three real authors, no actual joint paper) returned 4–6 plausible-looking candidates with no flag that the query was unanswerable. For workflows that use Paperclip as a candidate generator, a downstream agent has to be the entity-discrimination layer. Repros: 3 files under [`retrieval_packets/neg-*__probe.txt`](retrieval_packets/).

## What this means for use

We do not recommend Paperclip as a load-bearing component of a provenance-grade KB ingestion workflow today. The recommendation is a hybrid workflow — web/API (PubMed, ClinicalTrials.gov, arXiv) → Paperclip → local PDF, in trust order — where Paperclip's role is a thin PMID-confirmed PMC-skim layer for content inspection. Inside that safe-use box it works cleanly. Outside it — Annual Reviews, pre-1980 literature, paywalled non-PMC, version-lineage cases, conceptual / cross-source queries — the workflow has to fall back to other arms.

The empirical anchor: across 14 cases the hybrid arm scores mean overall ≈ **4.1/5**; the Paperclip-arm Domain Usefulness mean (the rubric dimension that asks "would this output help KB ingestion") is **1.9/5**. Under the strict A criterion ("Paperclip uniquely contributed evidence other arms could not have given"), Paperclip's unique contribution is 0/14 cases; under a more generous "Paperclip was the fastest path" reading, it gets credit on 2–4 cases. Role-by-role conclusions and the strict vs. generous framing are in [`final_recommendation.md`](final_recommendation.md).

## What would change this conclusion

We would re-evaluate (in part or whole) if any of the following changes:

1. Paperclip documents its index scope explicitly (per-source-class coverage) and the Annual Reviews / pre-1980 / paywalled-non-PMC gaps narrow.
2. `map -n N` honors `N`.
3. Trial `map` accepts `tri_*` IDs without the UUID type error.
4. A `version` field is added to paper records distinguishing preprint / final / postprint / corrected.
5. A refusal / uncertainty signal is added to impossible-blend queries.
6. The merged-supplement / empty-`supplements/` defect for NEJM Correspondence (and similar formats) is fixed.
7. Blind re-scoring on anonymized synthesis files produces materially different role-level scores than this pass.

The five mechanical bugs listed under "Where we hit mechanical bugs" above have been filed as targeted issues at [`GXL-ai/paperclip`](https://github.com/GXL-ai/paperclip/issues).

## Repo guide

### Top-level documents

| File | Purpose |
|---|---|
| [`README.md`](README.md) | This file. Narrative summary + how to read the repo. |
| [`final_recommendation.md`](final_recommendation.md) | Role-by-role recommendation with full artifact citations. |
| [`methodology.md`](methodology.md) | How the evaluation was conducted end-to-end. Limitations declared up front. |
| [`adversarial_review_response.md`](adversarial_review_response.md) | Independent Opus subagent review of the draft recommendation + main-agent responses. |
| [`scoring_rubric.md`](scoring_rubric.md) | 1–5 rubric with hard caps. |
| [`hybrid_workflow.md`](hybrid_workflow.md) | Predeclared hybrid decision procedure + A/B/C/D/E/F classification scheme. |
| [`error_taxonomy.md`](error_taxonomy.md) | Catalog of observed errors with severity and artifact links. |
| [`index_scope_findings.md`](index_scope_findings.md) | What Paperclip indexes / what it doesn't. |

### Data tables (CSV)

| File | Rows | Purpose |
|---|---|---|
| [`corpus_registry.csv`](corpus_registry.csv) | 14 | Cases evaluated (9 known + 5 held-out). |
| [`retrieval_observations.csv`](retrieval_observations.csv) | 91 | Every Paperclip command, output, and resolved ID. |
| [`identity_validation.csv`](identity_validation.csv) | 46 | Per case × arm: title/author/year/identifier match status. |
| [`supplement_inventory.csv`](supplement_inventory.csv) | 13 | Per supplement-bearing case × arm: supplement files visible. |
| [`version_lineage.csv`](version_lineage.csv) | 8 | Per versioned case × arm: preprint/final/postprint validation. |
| [`trial_reconciliation.csv`](trial_reconciliation.csv) | 2 | NCT04232943 Paperclip vs. web arm reconciliation. |
| [`negative_controls.csv`](negative_controls.csv) | 5 | Near-miss + impossible-blend results under strict refusal rule. |
| [`hybrid_runs.csv`](hybrid_runs.csv) | 14 | Hybrid workflow runs per case with A/B/C/D/E/F classification. |
| [`hybrid_value_classification.csv`](hybrid_value_classification.csv) | 14 | Per-run added-value classification (strict A criterion). |
| [`index_scope_probes.csv`](index_scope_probes.csv) | 12 | Probes across 4 Paperclip-miss classes. |
| [`synthesis_scores.csv`](synthesis_scores.csv) | 46 | Per case × arm: 8-dimension scores + caps + adjudication. |
| [`heldout_selection.json`](heldout_selection.json) | 5 | Audit trail of held-out PubMed-query selection. |

### Evidence directories

| Directory | Count | What's there |
|---|---|---|
| [`ground_truth/`](ground_truth/) | 14 | Per-case authoritative metadata + abstract + diagnostic anchors, built BEFORE Paperclip retrieval. |
| [`evidence_bundles/`](evidence_bundles/) | 46 | Per case × arm bundle containing ONLY that arm's evidence. Input to synthesizer subagents. |
| [`synthesis_outputs/`](synthesis_outputs/) | 46 | Per case × arm: Opus synthesizer's 8-prompt answers from arm-isolated bundle. |
| [`scorer_packets/output/`](scorer_packets/output/) | 2 | Two independent Opus scorer subagent outputs covering all 46 syntheses. |
| [`retrieval_packets/`](retrieval_packets/) | 112 | Every Paperclip MCP command + verbatim output, timestamped. |
| [`validation_logs/`](validation_logs/) | + 8 | Local PDF metrics + head/tail slices; source-of-record metadata cache. |
| [`tools/`](tools/) | 10 | PowerShell tools for re-running each phase. |

## Reproducing this evaluation

Environment: PowerShell 7+, `curl`, `pdftotext` / `pdfinfo`, Paperclip API key at `.paperclip.key` (gitignored), optional NCBI API key. Set `$env:PAPERCLIP_EVAL_PDF_ROOT` to point at your own PDF archive for the local-PDF arm.

Phase tools in [`tools/`](tools/):

- Ground truth: `Build-GroundTruth.ps1`
- Held-out selection: `Select-HeldOut.ps1`
- Paperclip retrieval: `Run-PaperclipRetrieval.ps1` (driver) + `Invoke-PaperclipMcp.ps1` (HTTP wrapper)
- Index-scope probes: `Probe-IndexScope.ps1`
- Local PDF slices: `Extract-LocalPdfSlices.ps1` + `Measure-ArticlePdf.ps1`
- Evidence bundles: `Build-EvidenceBundles.ps1`
- Score compilation: `Compile-Scores.ps1`
- Verification: `Test-Artifacts.ps1`

Synthesizer + scorer subagents are launched from an orchestrating agent (Claude Opus 4.7). See [`methodology.md`](methodology.md) §"Reproducing this evaluation" for the run order.

## License and contact

Author: Mike Famulare. Reach out via GitHub.
