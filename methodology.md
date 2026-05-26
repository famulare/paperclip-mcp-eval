# Methodology

**Origin:** Claude Opus 4.7 (1M context).
**Date:** 2026-05-21.

This document describes how the Paperclip MCP literature evaluation was conducted end-to-end. It is the canonical "how" document for the repo. The "what was found" lives in [`final_recommendation.md`](final_recommendation.md); the "how rigorous was it" lives in [`adversarial_review_response.md`](adversarial_review_response.md). See [README.md](README.md) for the TL;DR.

## What was evaluated and why

The Fermi knowledge base requires literature-ingest tools with provenance-grade audit characteristics: every claim must trace to an artifact, every artifact to a source-of-record. Paperclip is a literature MCP from gxl.ai that exposes papers as a virtual filesystem. The question this evaluation answers: **is Paperclip safe and useful as a literature retrieval / inspection / synthesis tool for the Fermi KB, and under what conditions?**

The methodology described here is the canonical version (pass 3, Claude Opus 4.7) that produced the artifacts in this repository — arm-isolated synthesis, two-call scoring, index-scope probes, negative-control regrade. The contract structure and rubric anchors below are "binding" rules — predeclared before scoring.

## Six Paperclip roles under evaluation

Each role is scored separately because Paperclip's strengths in one (e.g., PMID lookup on PMC papers) do not transfer to others (e.g., version resolution):

1. **Source resolver** — can it resolve exact identifiers (DOI, PMID, PMCID, arXiv, NCT) to a correct document?
2. **Document reader** — does it expose the paper's content faithfully and with correct organization (body, supplements, figures, tables)?
3. **Version resolver** — can it distinguish preprint, journal final, postprint, corrected?
4. **Supplement resolver** — can it inventory and serve supplements as separate, labeled artifacts?
5. **Trial/paper bridge** — can it connect ClinicalTrials.gov records to corresponding publications?
6. **Cross-source query engine** — can it handle conceptual queries safely (refuse impossible blends; flag uncertainty)?

A high score in one role does NOT propagate to other roles. The final recommendation reports each role separately.

## Corpus design

14 cases total: 9 known-target cases plus 5 held-out concept-discovery cases.

**Known targets** (frozen by the evaluator at start; identifiers in [`corpus_registry.csv`](corpus_registry.csv)):

- `famulare-2018-plosbio` — Famulare 2018 PLOS Biology + bioRxiv preprint lineage (supplement-heavy, versioned)
- `sfs-nejm-2020` — Seattle Flu Study NEJM correspondence (canonical wrong-content-organization probe)
- `kew-2005-opv-review` — Kew 2005 Annual Reviews of Microbiology (canonical Annual-Reviews-not-indexed probe)
- `khoury-2021-natmed` — Khoury 2021 Nature Medicine final + medRxiv preprint (canonical preprint-vs-final stress)
- `hornick-typhoid` — Hornick 1970 NEJM (pre-1980 + OCR stress)
- `thakkar-famulare-arxiv` — Two arXiv theory papers (notation-aware reading)
- `nigeria-2015-versioning` — Nigeria 2015 arXiv→PLOS ONE (canonical version-lineage)
- `cheslock-1960-ocr` — Cheslock & McCully 1960 vitamin B6 (1960 scan + OCR)
- `nct04232943-pmid36746739` — IPV dmLT bOPV trial + paper pair (trial-paper bridge stress)

**Held-out cases** (selected by deterministic PubMed esearch over MeSH terms targeted as outside-wheelhouse; see [`heldout_selection.json`](heldout_selection.json)):

- `heldout-tbe-vaccine` — Tick-borne encephalitis vaccines (PMID 23997980)
- `heldout-hepc-ns5a` — HCV direct-acting antivirals (PMID 26904396)
- `heldout-tafamidis-attr` — Tafamidis ATTR-ACT NEJM 2018 cardiology trial (PMID 30145929)
- `heldout-snakebite` — Snakebite antivenom rat efficacy (PMID 29363648)
- `heldout-podoconiosis` — Podoconiosis HLA genetic association (PMID 33558538)

**Held-out wheelhouse disclosure:** the contract required "MeSH terms with no overlap" to polio/COVID/surveillance/vaccine-immunology. The adversarial self-review caught that 4/5 held-out cases are adjacent (TBE = vaccine literature; snakebite + podoconiosis = NTD-adjacent; HCV = virology-adjacent). Only tafamidis is unambiguously outside. The evaluation acknowledges this limitation explicitly.

## Evidence chain

For each case × source arm, the path from raw retrieval to scored synthesis runs:

1. **Ground truth first.** [`ground_truth/<case_id>.md`](ground_truth/) is built from authoritative sources (PubMed esummary/efetch, ClinicalTrials.gov v2 API, arXiv abstracts, publisher pages) BEFORE any Paperclip retrieval. The ground truth is the answer key, never modified by downstream steps.
2. **Paperclip retrieval.** All Paperclip MCP commands and their verbatim outputs are saved to [`retrieval_packets/`](retrieval_packets/) with command + timestamp headers. Includes `lookup` (DOI/PMID/arXiv/NCT), `search`, `ls`, `wc`, `grep`, and `map` probes per case.
3. **Local PDF extraction** (when the evaluator's local PDF archive has the paper) via [`tools/Extract-LocalPdfSlices.ps1`](tools/Extract-LocalPdfSlices.ps1). Head + tail text slices land in [`validation_logs/local_pdf_slices/`](validation_logs/local_pdf_slices/); never full-text dumps.
4. **Web/API live retrieval** documented in `ground_truth/` (no separate web-retrieval packets — the ground-truth file IS the web evidence).
5. **Arm-isolated evidence bundles.** [`tools/Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1) assembles per-case-per-arm bundles in [`evidence_bundles/`](evidence_bundles/). Each bundle contains ONLY that arm's evidence (no cross-arm leakage; the hybrid bundle is the explicit combination per the predeclared workflow).
6. **Arm-isolated synthesis.** Each evidence bundle is handed to a separate Claude Opus 4.7 synthesizer subagent that answers 8 fixed evaluation prompts using ONLY that bundle. Output in [`synthesis_outputs/<case>__<arm>.md`](synthesis_outputs/). 46 syntheses total (14 cases × ~3.3 arms; some cases have no local PDF or no web abstract).
7. **Scoring.** Two independent Claude Opus 4.7 subagent passes score all 46 synthesis outputs against the rubric. Outputs in [`scorer_packets/output/scorerA_all.md`](scorer_packets/output/scorerA_all.md) and [`scorerB_all.md`](scorer_packets/output/scorerB_all.md). Main-agent adjudication of disagreements (≥2 on any dimension) recorded in [`synthesis_scores.csv`](synthesis_scores.csv) with conservative-lower-score rule.

## Arm isolation (mandatory)

This is the load-bearing methodology choice. Each arm's synthesis answer is produced from that arm's evidence ONLY. The synthesizer subagent sees the bundle, the 8 prompts, and explicit "no outside knowledge" instructions. If a prompt cannot be answered from the bundle, the synthesizer writes "Cannot answer from this arm's evidence" and explains what is missing. This prevents the pass-2 failure mode where synthesis files were narrator-style with shared priors leaking across arms.

Arm-isolation is enforced at bundle-construction time by [`tools/Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1). The script reads only arm-specific retrieval packets when building each bundle. Cross-arm contamination is mechanically excluded.

## Scoring rubric and hard caps

Eight dimensions per case × arm: Evidence Fidelity (EF), Missing-Detail Control (MD), Unsupported-Claim Detection (UC), Version-Provenance Fidelity (VP), Supplement-Protocol-Table-Figure Use (SP), Traceability (TR), Domain Usefulness (DU), Time-Friction (TF). Scale 1–5 or NA. Overall score is the rounded mean of non-NA dimensions, after hard caps.

Hard caps trigger on evidence in the synthesis itself, not on arm name:

- Wrong document / wrong version / unsafe synthesis → overall = 1.
- Invalid identity → overall ≤ 2.
- Supplement-heavy without validated inventory → MD and overall ≤ 3.
- Versioned case without validated version label → VP and overall ≤ 3.
- Trial-map failure → Paperclip trial-engine ≤ 2 for map-dependent claims.
- Wrong content organization (e.g., SFS supplement merged into content.lines) → document-reader ≤ 2.
- No-refusal on impossible-blend queries → cross-source-query-engine and trial-query-engine roles ≤ 2 system-wide.

Full rubric in [`scoring_rubric.md`](scoring_rubric.md).

## Hybrid workflow and value classification

Hybrid is its own arm with its own Opus synthesizer over a deliberately-combined bundle (web/API identity + Paperclip retrieval + local PDF when available). Hybrid is NEVER scored as the maximum of single-arm scores. Per-run value classification (A=Paperclip uniquely contributed; B=web/local could have done alone faster; C=Paperclip-rescue; D=diagnostic only; E=no added value; F=backup-when-web-degraded) is recorded in [`hybrid_value_classification.csv`](hybrid_value_classification.csv). The F bucket was added post-adversarial-review per [`adversarial_review_response.md`](adversarial_review_response.md) C4. See [`hybrid_workflow.md`](hybrid_workflow.md) for the predeclared decision procedure.

## Negative controls

5 controls in [`negative_controls.csv`](negative_controls.csv): 2 near-miss + 3 impossible-blend. Strict regrade rule: returning ≥1 plausible candidate to an impossible-blend query without refusal = fail (not partial). Returning a false positive in a near-miss query result set = fail (not partial).

## Index-scope probes

4 miss classes identified during retrieval, 3 probes each (12 probes total) in [`index_scope_probes.csv`](index_scope_probes.csv) with synthesis in [`index_scope_findings.md`](index_scope_findings.md). The probes convert "Paperclip didn't find paper X" from anecdote into systematic finding: 0/3 Annual Reviews hit, 0/3 pre-1980 NEJM hit, 0/3 paywalled-non-PMC Lancet 2019 RCTs hit, 2/3 Nature Medicine 2022 PMC-versioned papers hit by PMID (none by DOI). Paperclip's corpus is PMC-anchored.

## Methodology limitations (declared)

1. **Scoring was not fully blind.** The contract called for stripping arm labels from synthesis files before scoring. The anonymization step was skipped during execution; synthesis files retain `arm:` in frontmatter and scorers referenced the arm name in rationales. The two scorers were both Claude Opus 4.7 — sampling-noise independence, not structural independence. The rubric's hard caps (which trigger on synthesis content, not arm name) are not affected by this defect. Discovered and declared by the adversarial self-review.
2. **Held-out set is partially in-wheelhouse.** 4/5 held-out cases are adjacent to the evaluator's research topics (infectious-disease modeling; see [`README.md`](README.md) §"Who built this and for what"). Only tafamidis is unambiguously outside.
3. **Negative-control N=3 impossible-blend is small** for a system-wide cap. Cap remains rubric-defined but the empirical base is thin.
4. **Arm isolation enforced at bundle-construction time; not adversarially audited** with a random-spot-check pass.

These four limitations are restated in the recommendation's [Methodology Limitations](final_recommendation.md) section.

## Adversarial self-review

One independent Claude Opus 4.7 subagent attacked the draft recommendation with full access to artifacts and prior-pass review prompts as templates. The subagent found 9 critical, 6 substantive, and 10 minor findings — most notably an arithmetic error in the hybrid tally (was 2+3+7+2+1=15; corrected to A=0/B=4/C=6/D=2/E=1/F=1=14 under strict A criterion), a fabricated SFS citation (line L47 was from a different grep packet), and the unblinded-scoring contract violation. The main agent responded per-finding, revised the recommendation, and the full dialogue is preserved in [`adversarial_review_response.md`](adversarial_review_response.md).

## Evidence that would change the recommendation

Re-run this evaluation (in part or whole) if any of the following change:

1. Paperclip documents its index scope explicitly and the Annual Reviews / pre-1980 / paywalled-non-PMC gaps narrow.
2. `map -n N` is fixed to honor N.
3. Trial `map` is fixed to accept `tri_*` UUIDs.
4. A `version` field is added to paper records distinguishing preprint/final/postprint/corrected.
5. A refusal/uncertainty signal is added to impossible-blend queries.
6. The SFS-style merged-supplement defect is fixed.
7. Blind re-scoring on anonymized synthesis files produces materially different role-level scores.

## Pre-publication clarity pass (2026-05-26)

Before this repository was made public, a clarity pass replaced person-specific framings ("Mike's KB", "Mike's archive", "Mike's IDM-era work", etc.) with role-language ("the KB owner's", "the evaluator's local PDF archive", "the evaluator's IDM-era work") across framing docs and inside synthesis outputs, scorer packets, and the adversarial review response. The pass is recorded as the commit immediately before `gh repo edit --visibility public`.

The clarity pass is non-semantic: no claim, citation, score, identifier, or numerical finding was altered. Reviewers can confirm by diffing the clarity-pass commit; only surface phrasing changed. The pass-3 load-bearing rule that "no phase mutates prior phase's evidence" applies to evidence content; this disclosure is for transparency about the surface-language reframe.

Famulare-as-corpus-author references (in [`ground_truth/`](ground_truth/), [`evidence_bundles/`](evidence_bundles/), synthesis outputs for `famulare-2018-plosbio` and `thakkar-famulare-arxiv`) are unchanged — those are statements of fact about the papers being evaluated, not about the evaluator's role. The author's email was scrubbed from the [`tools/Build-GroundTruth.ps1`](tools/Build-GroundTruth.ps1) User-Agent string and replaced with the repo URL.

## Reproducing this evaluation

Environment requirements:

- PowerShell 7+ (pwsh).
- `curl` (Git Bash).
- `pdftotext` and `pdfinfo` (MiKTeX or equivalent).
- Paperclip API key at `.paperclip.key` (gitignored).
- Optional: NCBI API key as `$env:NCBI_API_KEY` to raise the 3 req/sec anonymous limit.

Per-phase tooling:

- Ground truth: [`tools/Build-GroundTruth.ps1`](tools/Build-GroundTruth.ps1)
- Held-out selection: [`tools/Select-HeldOut.ps1`](tools/Select-HeldOut.ps1)
- Paperclip retrieval: [`tools/Run-PaperclipRetrieval.ps1`](tools/Run-PaperclipRetrieval.ps1) (calls [`Invoke-PaperclipMcp.ps1`](tools/Invoke-PaperclipMcp.ps1))
- Index-scope probes: [`tools/Probe-IndexScope.ps1`](tools/Probe-IndexScope.ps1)
- Local PDF slices: [`tools/Extract-LocalPdfSlices.ps1`](tools/Extract-LocalPdfSlices.ps1) (uses [`Measure-ArticlePdf.ps1`](tools/Measure-ArticlePdf.ps1))
- Evidence bundles: [`tools/Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1)
- Synthesizer subagents: launched per-bundle from the orchestrator agent (Opus 4.7).
- Scoring subagents: two independent Opus 4.7 calls, compiled by [`tools/Compile-Scores.ps1`](tools/Compile-Scores.ps1).
- Verification: [`tools/Test-Artifacts.ps1`](tools/Test-Artifacts.ps1).

Run order matches the evidence-chain numbering above (1→7). Each phase's outputs are inputs to the next; no phase mutates a prior phase's evidence.
