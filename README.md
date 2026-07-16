# Evaluating literature-retrieval tools for provenance-grade ingestion: Paperclip (gxl.ai) & Asta (Ai2)

This repository is an empirical evaluation of two literature-retrieval services as candidate components in a provenance-grade research knowledge base: **[Paperclip](https://paperclip.gxl.ai/)** (gxl.ai's literature MCP) and **[Asta](https://allenai.org/asta)** (Ai2's Scientific Corpus MCP over Semantic Scholar). Both are measured against the same 14-case corpus, the same 8-prompt / 8-dimension rubric, and the same baseline: a hybrid **web/API + local-PDF** workflow that stands in for *general web search + parsing*. The full evidence chain is preserved so every conclusion re-derives from the artifacts.

## Headline: neither is close to replacing general web search + parsing

For provenance-grade literature ingestion — *every claim traces to an artifact, every artifact to a source-of-record* — **neither Paperclip nor Asta is a substitute for searching PubMed / ClinicalTrials.gov / arXiv / publishers and parsing the actual PDFs.** Each is, at best, a niche accelerator *inside* a hybrid workflow that the plain web/API+PDF baseline already leads (mean overall ≈ **4.1/5**). The single most load-bearing sentence in the repo: *"For quotable body text from paywalled papers, neither Asta nor Paperclip helps; that still needs publisher access / local PDFs"* ([`asta/asta_fast_findings.md`](asta/asta_fast_findings.md)).

| What provenance-grade ingestion needs | Paperclip (gxl.ai) | Asta (Ai2) | Web search + parsing (the baseline) |
|---|---|---|---|
| **Corpus reach** | PMC-only; silent misses outside it (Annual Reviews / pre-1980 NEJM / paywalled-non-PMC **0/3 each**) | Broad catalog incl. closed-access **metadata** | PubMed + ClinicalTrials.gov + arXiv + publishers + open web |
| **Full text you can quote** | Full body for in-corpus PMC papers; nothing outside | Body snippets **only for open-access/preprint** (**0/6 paywalled**); abstract-only elsewhere | The actual full text via PDF/HTML (incl. paywalled, with access) |
| **Version + supplement fidelity** | version lineage collapsed; supplement-ingestion bugs | version handling mixed; **no supplement surface** | preprint vs final + supplements as separate artifacts |
| **Refusal on impossible queries** | none — 3/3 blends return candidates | none — 5/5 blends return candidates | a careful analyst says "no such paper" |
| **Freshness** | frozen ≈ March 2026 | fresher | live |
| **Scored verdict** | Domain-Usefulness **1.9/5**; unique contribution **0/14** | **3.29 vs Paperclip 3.00** — reach, not depth | hybrid **≈4.1/5**, the strongest arm |

**The four failure modes they share** — each a reason the tool falls short of just searching and reading:

1. **No universal full text.** Paywalled bodies are unreachable by both — exactly the content a KB most needs to quote ([`asta/asta_fast_findings.md`](asta/asta_fast_findings.md), [`paperclip/index_scope_findings.md`](paperclip/index_scope_findings.md)).
2. **Invisible corpus boundaries.** Both fail *silently* off-corpus — Paperclip outside PMC, Asta outside its snippet index — indistinguishable from "the paper doesn't exist."
3. **No refusal / uncertainty.** Impossible-blend queries return plausible candidates with no flag (Paperclip 3/3, Asta 5/5); a downstream agent must be the entity-discrimination layer.
4. **Version + supplement gaps.** Neither cleanly distinguishes preprint/final or serves supplements the way a source-of-record + PDF workflow does.

**What each is genuinely good for** (ingredients, not replacements): **Paperclip** — a PMID-confirmed skim of PMC full text. **Asta** — broad discovery + abstracts + open-access body snippets, with low friction (Time/Friction **3.07 vs 1.71**).

**One honest asymmetry.** The web/PDF baseline beats Paperclip by *score* (hybrid ≈4.1 vs Paperclip DU 1.9). The web-vs-Asta gap is *inferred, not a scored hybrid-with-Asta run* — Asta's non-body value largely duplicates the web arm's abstracts, so it adds no full-text capability the web workflow lacks ([`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md)).

**Read next:** Paperclip role-by-role → [`paperclip/final_recommendation.md`](paperclip/final_recommendation.md); Asta scored head-to-head → [`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md); Asta gate + coverage → [`asta/asta_fast_findings.md`](asta/asta_fast_findings.md); methodology → [`common/methodology.md`](common/methodology.md).

## Who built this and for what

The evaluator is Mike Famulare, Principal Research Scientist at the Institute for Disease Modeling (IDM) in the Global Health Division at the Gates Foundation. The "Fermi KB" referenced throughout is the evaluator's internal knowledge base that needs literature with provenance-grade audit characteristics (every claim traces to an artifact, every artifact to a source-of-record). "IDM" / "Institute for Disease Modeling" appears in some corpus papers' author affiliations and in some synthesis outputs; it is the evaluator's current employer.

**Authorship.** Mike Famulare is the project planner, reviewer, and accountable party — corpus definition, rubric, contract, scorer adjudication, and the final recommendation are his. The text in this repository (methodology, synthesis outputs, scorer outputs, the recommendation, per-arm evidence bundles) and the PowerShell tooling were written by Claude Opus 4.7 (Anthropic) for the pass-3 Paperclip evaluation, and by Claude Opus 4.8 for the pass-4 Paperclip v0.6.0 re-probe and the entire pass-5 Asta evaluation — operating as orchestrating agents and as arm-isolated synthesizer / scorer subagents. Treat the work as AI-implemented under human direction and review.

**Disclosure:** two corpus cases (`famulare-2018-plosbio` and `thakkar-famulare-arxiv`) are co-authored by the evaluator. This is intentional — testing a literature tool against papers the evaluator knows in detail is a stronger probe of fidelity than testing only stranger material. Synthesis outputs for these cases were produced by an arm-isolated Claude Opus 4.7 subagent under explicit "no outside knowledge" instructions, same as all other cases. See [`common/methodology.md`](common/methodology.md) §"Arm isolation (mandatory)".

## The question this evaluation asked

The use case is provenance-grade literature ingestion into a research knowledge base. Every claim that enters must trace to an artifact, and every artifact to a source-of-record (PubMed, ClinicalTrials.gov v2, arXiv, publisher of record). That bar is higher than "retrieve relevant papers" — it's "give me content I can quote, with versions distinguished, supplements identified, and corner cases (impossible queries, paywalled non-PMC papers, older literature, preprint vs final) handled either correctly or with an explicit 'I don't know' signal."

Paperclip is a natural candidate for this. It exposes papers as a virtual filesystem (`ls /papers/PMC.../supplements/`, `wc` and `grep` over `content.lines`), it has MCP integration so it composes cleanly with agentic workflows, and gxl.ai is working on a real problem — research literature is hard to retrieve cleanly. The question for this evaluation is whether Paperclip's current implementation clears that provenance bar, and where it does and doesn't.

## How we tested it

**Corpus.** 9 known-target cases that exercise specific stresses — supplement-heavy papers, preprint/final version pairs, pre-1980 OCR-poor scans, trial-paper bridges, content-organization probes — plus 5 deterministically-selected held-out cases from PubMed (audit trail in [`common/heldout_selection.json`](common/heldout_selection.json)). Full list in [`common/corpus_registry.csv`](common/corpus_registry.csv).

**Four arms** (Paperclip eval). Paperclip; web/API (PubMed esummary, ClinicalTrials.gov v2, arXiv, publisher pages); local PDF (when available in the evaluator's archive); and Hybrid (the three combined under a predeclared decision procedure in [`common/hybrid_workflow.md`](common/hybrid_workflow.md)). The **web/API + local-PDF hybrid is this repo's stand-in for "general web search + parsing"** — it is scored as its own arm (not a max-of-arms) and is the baseline both tools are judged against.

**A fifth arm — Asta — was added later** (2026-07, Claude Opus 4.8, with the previously-skipped **blinded scoring**) as a standalone arm scored against the same corpus and rubric; see [`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md).

**Arm isolation.** Each arm's evidence bundle was assembled by tooling that reads only arm-specific sources. Synthesis was performed by a separate Claude Opus 4.7 subagent per bundle answering 8 fixed prompts under "no outside knowledge" instructions, so cross-arm leakage couldn't artificially help the weaker arms.

**Scoring.** Two independent Opus 4.7 scorer subagent calls per synthesis output, against the rubric in [`common/scoring_rubric.md`](common/scoring_rubric.md). Hard caps trigger on synthesis content, not arm name — wrong document → overall ≤ 1; invalid identity → ≤ 2; wrong content organization → document-reader role ≤ 2. Main-agent adjudication of disagreements with a conservative-lower-score rule.

**Adversarial self-review.** A separate Opus subagent attacked the draft recommendation; findings and per-finding responses are preserved in [`common/adversarial_review_response.md`](common/adversarial_review_response.md). The adversarial reviewer caught a fabricated citation, an arithmetic error in the hybrid tally, and an unblinded-scoring contract violation, all corrected.

**Methodology limitations are declared up front** in [`common/methodology.md`](common/methodology.md) §"Methodology limitations (declared)" — most importantly that scoring was not fully blind (the anonymization step was skipped during execution; both scorers are the same model so they offer sampling-noise independence rather than structural independence) and that 4 of 5 held-out cases are partially in-wheelhouse rather than unambiguously outside.

## What we found — Paperclip (gxl.ai)

### Where Paperclip works cleanly

- **PMID lookup on PMC-versioned papers.** 9 of 14 cases resolved cleanly by PMID when the target was in PMC (Famulare 2018 PLOS Biology, SFS NEJM correspondence, the IPV/dmLT trial paper, the held-out HCV / snakebite / podoconiosis cases, etc.). The `wc /papers/<PMCID>/content.lines` + `grep` workflow is genuinely useful for content inspection once the right paper is in hand. Repro: [`paperclip/evidence/retrieval_packets/famulare-2018-plosbio__lookup_pmid.txt`](paperclip/evidence/retrieval_packets/famulare-2018-plosbio__lookup_pmid.txt).
- **Filesystem-style supplement inventory when present.** For papers like Famulare 2018, `ls /papers/PMC5942853/supplements/` returns the two supplementary files cleanly with stable paths. The filesystem abstraction is a real ergonomic win for agentic workflows. Repro: [`paperclip/evidence/retrieval_packets/famulare-2018-plosbio__ls_supplements.txt`](paperclip/evidence/retrieval_packets/famulare-2018-plosbio__ls_supplements.txt).
- **arXiv-side redundancy when external APIs are degraded.** For the Thakkar/Famulare arXiv pair, Paperclip resolved the paper identity cleanly when the external arXiv API was rate-limiting our web-arm retrieval. Not a unique contribution to evidence, but a real redundancy backstop. Repro: [`paperclip/evidence/retrieval_packets/thakkar-famulare-arxiv__lookup_arxiv_2205_02150.txt`](paperclip/evidence/retrieval_packets/thakkar-famulare-arxiv__lookup_arxiv_2205_02150.txt).

### Where we hit mechanical bugs

Each is reproducible from the linked packet with the exact command that triggers the behavior. These look like the kind of issues that vendors typically fix in maintenance cycles when surfaced:

1. **`map -n N` does not honor `N`.** Three test cases ran `map --from <handle> -n 1` and got back 5/5, 4/4, and 5/5 tasks respectively (one per paper in the search set, not one total). Synthesis output is silently contaminated across multiple papers unless the caller knows to extract the target's section. Repro: [`paperclip/evidence/retrieval_packets/famulare-2018-plosbio__map_n_probe.txt`](paperclip/evidence/retrieval_packets/famulare-2018-plosbio__map_n_probe.txt) (and the `*__map_n_probe.txt` packets for `nigeria-2015` and `nct04232943`).
2. **Trial `map` errors with a UUID type mismatch.** `map` on a `tri_*` document ID returns `ERR: map: invalid input syntax for type uuid: "tri_7fa7a997858a"`. Looks like a schema mismatch between trial-document IDs and the SQL backend's UUID column. Repro: [`paperclip/evidence/retrieval_packets/nct04232943-pmid36746739__trial_map.txt`](paperclip/evidence/retrieval_packets/nct04232943-pmid36746739__trial_map.txt).
3. **DOI lookup misses, including on papers that resolve by PMID.** 15 of 15 DOI lookups missed across the controlled corpus + 12 index-scope probes — including DOIs for papers that Paperclip *does* index (resolvable by PMID). Looks like a DOI-normalization or DOI-index-coverage issue rather than a fundamental architecture problem. Repro: [`paperclip/evidence/retrieval_packets/famulare-2018-plosbio__lookup_doi.txt`](paperclip/evidence/retrieval_packets/famulare-2018-plosbio__lookup_doi.txt).
4. **Supplementary appendix merged into `content.lines` while `supplements/` is empty.** For the SFS NEJM correspondence, `ls /papers/PMC7206929/supplements/` returns empty, but `grep -n -i "supplement|appendix" /papers/PMC7206929/content.lines` shows the entire supplementary appendix is in the main content blob — section headers (`# Supplementary Appendix`), preamble, and table references (`Supplemental Table 1`). Looks like an ingestion-pipeline edge case for NEJM Correspondence format. Repro: [`paperclip/evidence/retrieval_packets/sfs-nejm-2020__ls_supplements.txt`](paperclip/evidence/retrieval_packets/sfs-nejm-2020__ls_supplements.txt) + [`__grep_supplement.txt`](paperclip/evidence/retrieval_packets/sfs-nejm-2020__grep_supplement.txt).
5. **Title-search recency-bias surfaces preprint over the requested final.** For Khoury 2021 ("Neutralizing antibody levels are highly predictive of immune protection..."), title search returned the medRxiv preprint at rank 2; the Nature Medicine final wasn't in the result set (it's also a DOI-lookup miss per #3). The numerical values in the preprint differ from the final, so this is a wrong-version risk in any workflow that trusts title-search ranking. Repro: [`paperclip/evidence/retrieval_packets/khoury-2021-natmed__search_title.txt`](paperclip/evidence/retrieval_packets/khoury-2021-natmed__search_title.txt).

### Where we hit architectural limitations

These look more durable — they reflect product-design or corpus-coverage choices that may be harder to change without significant work:

- **The corpus is PMC-anchored.** Annual Reviews 0/3 probed hit; pre-1980 NEJM 0/3 probed hit; paywalled non-PMC papers (Lancet 2019 RCTs, the NEJM 2018 ATTR-ACT cardiology trial) 0/3 + 1 held-out miss. For literature outside PMC, Paperclip is silent in a way that's indistinguishable from "the paper doesn't exist." Per-class probes in [`paperclip/data/index_scope_probes.csv`](paperclip/data/index_scope_probes.csv).
- **Version lineage is collapsed.** Paperclip's record schema doesn't distinguish preprint / accepted manuscript / final / postprint / corrected. For Nigeria 2015 (arXiv v1, v2, and PLOS ONE final, same paper), `lookup arxiv 1504.02751` returns a single record dated 2015-04-10 carrying the PLOS ONE DOI. Three distinct versions visible to other tools collapsed into one inside Paperclip. Repro: [`paperclip/evidence/retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt`](paperclip/evidence/retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt).
- **No refusal / uncertainty signal on impossible queries.** Three impossible-blend queries (e.g., "Famulare Covasim Hornick typhoid challenge" — three real authors, no actual joint paper) returned 4–6 plausible-looking candidates with no flag that the query was unanswerable. For workflows that use Paperclip as a candidate generator, a downstream agent has to be the entity-discrimination layer. Repros: 3 files under [`paperclip/evidence/retrieval_packets/neg-*__probe.txt`](paperclip/evidence/retrieval_packets/).

## What we found — Asta (Ai2)

Asta was added as a 5th arm after a colleague asked whether its `snippet_search` returns body text from paywalled papers. Full detail in [`asta/asta_fast_findings.md`](asta/asta_fast_findings.md) (Stage-1 coverage + gate) and [`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md) (scored head-to-head).

- **Metadata reach beats Paperclip.** Asta resolves essentially every class Paperclip misses — Annual Reviews, pre-1980 NEJM, paywalled Lancet RCTs, Nature Medicine finals — including closed-access papers, returning identity + abstract (where the publisher hasn't elided it).
- **But no body text for paywalled papers.** The predeclared gate — a body snippet for ≥3 of 4 durable Paperclip-miss classes — **failed 0/4**. Closed-access papers return **0 snippets** (robust across two distinct queries each); genuine body snippets appear only for open-access/preprint full text (CS/arXiv 7/7). Asta's snippet index is an *open-access* full-text index; the "12M full-text papers" it advertises largely exclude the paywalled clinical/review literature this KB ingests.
- **Scored, blinded, same model: a modest, reach-driven edge.** Standalone Asta vs Paperclip (Opus 4.8, **blinded** — which also discharges the pass-3 unblinded-scoring limitation) scored **3.29 vs 3.00** overall, but the arms **tie on 12 of 14 cases**; Asta's entire margin is 2 cases where Paperclip *misses the paper* and Asta supplies an abstract PubMed already had. **Reach, not depth.** Asta wins friction (Time/Friction 3.07 vs 1.71); Paperclip keeps its supplement + trial-registry surface.
- **Same no-refusal failure** as Paperclip (5/5 impossible blends returned candidates, none flagged), plus imperfect version handling (one final PMID resolves to a preprint-labeled record; one arXiv+PMID pair collapses to a single record).

## What this means for use

We do not recommend Paperclip as a load-bearing component of a provenance-grade KB ingestion workflow today. The recommendation is a hybrid workflow — web/API (PubMed, ClinicalTrials.gov, arXiv) → Paperclip → local PDF, in trust order — where Paperclip's role is a thin PMID-confirmed PMC-skim layer for content inspection. Inside that safe-use box it works cleanly. Outside it — Annual Reviews, pre-1980 literature, paywalled non-PMC, version-lineage cases, conceptual / cross-source queries — the workflow has to fall back to other arms.

The empirical anchor: across 14 cases the hybrid arm scores mean overall ≈ **4.1/5**; the Paperclip-arm Domain Usefulness mean (the rubric dimension that asks "would this output help KB ingestion") is **1.9/5**. Under the strict A criterion ("Paperclip uniquely contributed evidence other arms could not have given"), Paperclip's unique contribution is 0/14 cases; under a more generous "Paperclip was the fastest path" reading, it gets credit on 2–4 cases. Role-by-role conclusions and the strict vs. generous framing are in [`paperclip/final_recommendation.md`](paperclip/final_recommendation.md).

The parallel conclusion for **Asta**: a genuinely better *discovery + abstract* layer than Paperclip (broader reach, lower friction), but **not** a paywalled-full-text source — its scored edge over Paperclip is small and reach-driven, and largely duplicates what the web/API arm already supplies. Full reasoning in [`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md). Net for the KB: keep the hybrid **web/API → (Paperclip PMC-skim | Asta discovery/abstract) → local PDF**; neither MCP replaces searching and parsing the sources.

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

**Layout.** Top level holds only whole-project material (this README, [`CLAUDE.md`](CLAUDE.md), shared [`tools/`](tools/)). Everything else lives under three folders: **[`common/`](common/)** — shared design + the ground-truth answer key both evals use; **[`paperclip/`](paperclip/)** — the Paperclip eval (passes 3 & 4); **[`asta/`](asta/)** — the Asta eval (pass 5). Each eval folder holds its verdict docs at the root, `data/` (CSVs), and `evidence/` (packets, bundles, syntheses, scorer outputs).

### Top-level documents

| File | Purpose |
|---|---|
| [`README.md`](README.md) | **This file — the combined source of truth** for both evals. Start here. |
| [`paperclip/final_recommendation.md`](paperclip/final_recommendation.md) | Paperclip role-by-role recommendation with full artifact citations. |
| [`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md) | **Asta scored head-to-head vs Paperclip** (Opus 4.8, blinded): 3.29 vs 3.00, reach not depth. |
| [`asta/asta_fast_findings.md`](asta/asta_fast_findings.md) | Asta Stage-1: coverage + snippet gate (**FAIL 0/4**). |
| [`asta/asta_comparison_notes.md`](asta/asta_comparison_notes.md) | Asta scoping + decision trail (exploratory). |
| [`asta/asta_mcp_native_rerun_plan.md`](asta/asta_mcp_native_rerun_plan.md) | Native-MCP snippet equivalence check (executed; verdict unchanged). |
| [`common/methodology.md`](common/methodology.md) | How the evaluation was conducted end-to-end. Limitations declared up front. |
| [`common/synthesis_prompts.md`](common/synthesis_prompts.md) | Canonical 8 synthesis prompts + 6 roles (shared by both evals). |
| [`common/adversarial_review_response.md`](common/adversarial_review_response.md) | Independent Opus subagent review of the draft recommendation + main-agent responses. |
| [`common/scoring_rubric.md`](common/scoring_rubric.md) | 1–5 rubric with hard caps. |
| [`common/hybrid_workflow.md`](common/hybrid_workflow.md) | Predeclared hybrid decision procedure + A/B/C/D/E/F classification scheme. |
| [`paperclip/error_taxonomy.md`](paperclip/error_taxonomy.md) | Catalog of observed errors with severity and artifact links. |
| [`paperclip/index_scope_findings.md`](paperclip/index_scope_findings.md) | What Paperclip indexes / what it doesn't. |
| [`paperclip/pass4_fast_findings.md`](paperclip/pass4_fast_findings.md) | Paperclip v0.6.0 re-probe: product bugs fixed, structural limits stand. |

### Data tables (CSV)

| File | Rows | Purpose |
|---|---|---|
| [`common/corpus_registry.csv`](common/corpus_registry.csv) | 14 | Cases evaluated (9 known + 5 held-out). |
| [`paperclip/data/retrieval_observations.csv`](paperclip/data/retrieval_observations.csv) | 91 | Every Paperclip command, output, and resolved ID. |
| [`paperclip/data/identity_validation.csv`](paperclip/data/identity_validation.csv) | 46 | Per case × arm: title/author/year/identifier match status. |
| [`paperclip/data/supplement_inventory.csv`](paperclip/data/supplement_inventory.csv) | 13 | Per supplement-bearing case × arm: supplement files visible. |
| [`paperclip/data/version_lineage.csv`](paperclip/data/version_lineage.csv) | 8 | Per versioned case × arm: preprint/final/postprint validation. |
| [`paperclip/data/trial_reconciliation.csv`](paperclip/data/trial_reconciliation.csv) | 2 | NCT04232943 Paperclip vs. web arm reconciliation. |
| [`paperclip/data/negative_controls.csv`](paperclip/data/negative_controls.csv) | 5 | Near-miss + impossible-blend results under strict refusal rule. |
| [`paperclip/data/hybrid_runs.csv`](paperclip/data/hybrid_runs.csv) | 14 | Hybrid workflow runs per case with A/B/C/D/E/F classification. |
| [`paperclip/data/hybrid_value_classification.csv`](paperclip/data/hybrid_value_classification.csv) | 14 | Per-run added-value classification (strict A criterion). |
| [`paperclip/data/index_scope_probes.csv`](paperclip/data/index_scope_probes.csv) | 12 | Probes across 4 Paperclip-miss classes. |
| [`paperclip/data/synthesis_scores.csv`](paperclip/data/synthesis_scores.csv) | 46 | Pass-3 Paperclip eval: per case × arm 8-dimension scores + caps + adjudication. |
| [`asta/data/synthesis_scores_pass5.csv`](asta/data/synthesis_scores_pass5.csv) | 28 | **Pass-5 Asta eval:** blinded Asta + Paperclip scores (Opus 4.8). |
| [`asta/data/asta_coverage.csv`](asta/data/asta_coverage.csv) | 26 | Asta source-resolver + snippet coverage per case + P01–P12. |
| [`asta/data/asta_corpus_effect.csv`](asta/data/asta_corpus_effect.csv) | 7 | CS/arXiv body-snippet hit rate (the corpus effect). |
| [`asta/data/asta_negative_controls.csv`](asta/data/asta_negative_controls.csv) | 5 | Asta refusal behaviour on impossible-blend queries. |
| [`asta/data/asta_version_resolver.csv`](asta/data/asta_version_resolver.csv) | 8 | Asta preprint-vs-final record resolution. |
| [`asta/data/asta_closed_robustness.csv`](asta/data/asta_closed_robustness.csv) | 6 | Closed-access 0-snippet result, robust across a 2nd query. |
| [`common/heldout_selection.json`](common/heldout_selection.json) | 5 | Audit trail of held-out PubMed-query selection. |

### Evidence directories

| Directory | Count | What's there |
|---|---|---|
| [`common/ground_truth/`](common/ground_truth/) | 14 | Per-case authoritative metadata + abstract + diagnostic anchors, built BEFORE Paperclip retrieval. |
| [`paperclip/evidence/evidence_bundles/`](paperclip/evidence/evidence_bundles/) | 46 | Per case × arm bundle containing ONLY that arm's evidence. Input to synthesizer subagents. |
| [`paperclip/evidence/synthesis_outputs/`](paperclip/evidence/synthesis_outputs/) | 46 | Per case × arm: Opus synthesizer's 8-prompt answers from arm-isolated bundle. |
| [`paperclip/evidence/scorer_packets/output/`](paperclip/evidence/scorer_packets/output/) | 2 | Two independent Opus scorer subagent outputs covering all 46 syntheses. |
| [`paperclip/evidence/retrieval_packets/`](paperclip/evidence/retrieval_packets/) | 112 | Every Paperclip MCP command + verbatim output, timestamped. |
| [`asta/evidence/asta_probes/`](asta/evidence/asta_probes/) | 83 | Every Asta MCP probe + verbatim output (Stage-1 clean rerun). |
| [`asta/evidence/evidence_bundles/`](asta/evidence/evidence_bundles/) | 14 | Per-case Asta-arm bundles (input to the pass-5 synthesizers). |
| [`asta/evidence/pass5/`](asta/evidence/pass5/) | 59 | Asta Stage-2: syntheses, blinded scoring inputs, both scorer outputs, blind map. |
| [`paperclip/evidence/pass4_probes/`](paperclip/evidence/pass4_probes/) | 40 | Paperclip v0.6.0 re-probe packets. |
| [`paperclip/evidence/validation_logs/`](paperclip/evidence/validation_logs/) | + 8 | Local PDF metrics + head/tail slices; source-of-record metadata cache. |
| [`tools/`](tools/) | 13 | PowerShell tools for re-running each phase (incl. `Invoke-AstaMcp` / `Run-AstaRetrieval` / `Probe-AstaIndexScope`). |

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
- Asta retrieval (pass 5): `Invoke-AstaMcp.ps1` + `Run-AstaRetrieval.ps1` + `Probe-AstaIndexScope.ps1` (graph endpoints are keyless; `snippet_search` needs a Semantic Scholar API key as `x-api-key`)
- Verification: `Test-Artifacts.ps1`

Synthesizer + scorer subagents are launched from an orchestrating agent — Claude Opus 4.7 for the pass-3 Paperclip eval, Claude Opus 4.8 for the pass-5 Asta eval (blinded scoring). See [`common/methodology.md`](common/methodology.md) §"Reproducing this evaluation" for the run order.

## License and contact

Author: Mike Famulare. Reach out via GitHub.
