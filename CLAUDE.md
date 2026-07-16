# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is an **evaluation repository**, not an application. It contains the artifacts, data, and PowerShell tooling for a 14-case empirical evaluation of **two** literature-retrieval MCPs — **Paperclip** (gxl.ai) and, added later, **Asta** (Ai2, over Semantic Scholar) — against a hybrid web/API/local-PDF workflow for use as a Fermi-KB literature ingestion tool. The **combined source of truth is [`README.md`](README.md)** — its headline is that neither MCP is close to replacing general web search + parsing. Paperclip detail: [`paperclip/final_recommendation.md`](paperclip/final_recommendation.md). Asta detail: [`asta/asta_stage2_findings.md`](asta/asta_stage2_findings.md) (scored head-to-head) and [`asta/asta_fast_findings.md`](asta/asta_fast_findings.md) (Stage-1 gate). The "how" is in [`common/methodology.md`](common/methodology.md); who-built-this / "Fermi-KB" context in [`README.md`](README.md) §"Who built this and for what".

The canonical Paperclip methodology is referenced throughout as **pass 3** (Claude Opus 4.7). The Paperclip v0.6.0 re-probe (**pass 4**) and the entire Asta evaluation (**pass 5**, blinded, in `asta/evidence/pass5/`) are Claude Opus 4.8. The "binding" rules below are load-bearing for any re-evaluation.

## Architecture: the evidence chain

The repo is structured as a one-way pipeline. Each phase's outputs are inputs to the next; **no phase mutates a prior phase's evidence**. Understanding this ordering is mandatory before touching anything:

1. **Ground truth** in [`common/ground_truth/<case_id>.md`](common/ground_truth/) — built from authoritative sources (PubMed, ClinicalTrials.gov v2, arXiv, publisher pages) **before any Paperclip retrieval**. This is the answer key. Never modify it in response to downstream findings.
2. **Paperclip retrieval packets** in [`paperclip/evidence/retrieval_packets/`](paperclip/evidence/retrieval_packets/) — verbatim Paperclip MCP command + output, timestamped, one file per probe. Append-only.
3. **Local PDF slices** in [`paperclip/evidence/validation_logs/local_pdf_slices/`](paperclip/evidence/validation_logs/) — head/tail extracts only, never full-text dumps (avoids cross-arm contamination via priors).
4. **Evidence bundles** in [`paperclip/evidence/evidence_bundles/<case>__<arm>.md`](paperclip/evidence/evidence_bundles/) — per-case-per-arm, built by [`tools/Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1). Each bundle contains ONLY that arm's evidence.
5. **Synthesis outputs** in [`paperclip/evidence/synthesis_outputs/<case>__<arm>.md`](paperclip/evidence/synthesis_outputs/) — produced by a separate Opus 4.7 subagent per bundle, answering 8 fixed prompts using ONLY that bundle.
6. **Scorer packets** in [`paperclip/evidence/scorer_packets/output/`](paperclip/evidence/scorer_packets/output/) — two independent Opus 4.7 scorer passes (`scorerA_all.md`, `scorerB_all.md`) across all 46 syntheses, compiled into [`paperclip/data/synthesis_scores.csv`](paperclip/data/synthesis_scores.csv) with main-agent adjudication on disagreements (≥2 on any dimension; conservative-lower-score rule).

## Load-bearing rules — do not violate

These are the methodology invariants. Breaking them invalidates downstream conclusions.

- **Arm isolation.** Each arm's synthesis sees only that arm's bundle. Cross-arm leakage means re-running the synthesizer. Enforced mechanically by [`tools/Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1) — do not edit bundles by hand.
- **Ground-truth-first.** If the ground truth is wrong, fix it from authoritative sources and re-run downstream — never patch it from a synthesis or retrieval packet.
- **Hard caps trigger on synthesis content, not arm name.** Wrong document → 1, invalid identity → ≤2, etc. See [`common/scoring_rubric.md`](common/scoring_rubric.md). Caps are not adjustable per-arm.
- **Hybrid is a real arm.** It is NOT the max of single-arm scores. It has its own bundle (built per [`common/hybrid_workflow.md`](common/hybrid_workflow.md)) and its own synthesizer.
- **Negative-control grading is strict.** Impossible-blend query returning ≥1 plausible candidate without refusal = fail (not partial). Near-miss with ≥1 false positive in result set = fail.
- **Adversarial findings are recorded in [`common/adversarial_review_response.md`](common/adversarial_review_response.md)** with per-finding response, not silently fixed in place.

## Subagent vs main-agent roles

The synthesizer and scorer roles are performed by **separate Opus 4.7 subagent calls**, not by the main orchestrator agent. The main agent:
- builds bundles via the PowerShell tool,
- launches subagents per bundle / per scorer call with the bundle + 8 prompts (or rubric + all syntheses) + "no outside knowledge" instructions,
- adjudicates scorer disagreements,
- writes the recommendation and methodology docs.

When asked to "run the synthesizer" or "score the bundles," launch subagents — do not answer the 8 prompts in the main thread, and do not score in the main thread. Outside knowledge of the papers leaks if you do.

## Common commands

Environment: PowerShell 7+ (`pwsh`), `curl` (Git Bash), `pdftotext` + `pdfinfo` (MiKTeX or equivalent). Paperclip API key at `.paperclip.key` (gitignored). Optional `$env:NCBI_API_KEY` to raise the 3 req/sec anonymous limit.

Phase tools (run from repo root):

```pwsh
# Ground truth (phase 1) — one case
pwsh tools\Build-GroundTruth.ps1 -CaseId famulare-2018-plosbio

# Held-out selection (deterministic PubMed esearch)
pwsh tools\Select-HeldOut.ps1

# Paperclip retrieval (phase 2) — all cases, or restrict with -Only
pwsh tools\Run-PaperclipRetrieval.ps1
pwsh tools\Run-PaperclipRetrieval.ps1 -Only sfs-nejm-2020,khoury-2021-natmed

# Single ad-hoc Paperclip command (HTTP wrapper used by the driver)
pwsh tools\Invoke-PaperclipMcp.ps1 -Command "lookup pmid 30145929"

# Index-scope probes (Annual Reviews, pre-1980, paywalled-non-PMC, Nat Med)
pwsh tools\Probe-IndexScope.ps1

# Local PDF head/tail slices
pwsh tools\Extract-LocalPdfSlices.ps1 -CaseId hornick-typhoid

# Evidence bundles (phase 4) — rebuild after retrieval changes
pwsh tools\Build-EvidenceBundles.ps1

# Score compilation (phase 6) — after scorer subagents write their outputs
pwsh tools\Compile-Scores.ps1

# Repo integrity check — required files / dirs present
pwsh tools\Test-Artifacts.ps1
```

All tools are idempotent except for `Run-PaperclipRetrieval.ps1` which **appends** to [`retrieval_observations.csv`](paperclip/data/retrieval_observations.csv). Re-running a case requires manually pruning its prior rows from that CSV.

## Paperclip-specific quirks you'll encounter

These are observed-bug facts about the evaluation target, not bugs in this repo. **Pass-3 facts (v0.4.2) are annotated with their Pass-4 (v0.6.0, 2026-07-14) status; evidence in [`pass4_fast_findings.md`](paperclip/pass4_fast_findings.md) + [`pass4_probes/`](paperclip/evidence/pass4_probes/).**

- **`map -n N` does not honor `N`.** [Pass 3] Output was contaminated across all returned papers. **[Pass 4: FIXED — `-n 1` returns 1/1; the Map Contamination Rule is retired for v0.6.0+.]**
- **DOI lookup is unreliable** (15/15 controlled-corpus misses). [Pass 3] PMID was the only reliable resolver. **[Pass 4: FIXED for in-corpus papers — DOI resolves; misses now indicate the paper is not in the corpus, not a DOI bug.]**
- **Paperclip's corpus is PMC-anchored.** Annual Reviews, pre-1980 NEJM, and paywalled-non-PMC papers (Lancet RCTs, NEJM 2018 ATTR-ACT) are not indexed. See [`index_scope_findings.md`](paperclip/index_scope_findings.md). **[Pass 4: UNCHANGED — still not indexed despite corpus growth to a claimed 8M.]**
- **No refusal behavior.** Impossible-blend queries return plausible-looking candidates. Always cross-check identity against ground truth before trusting Paperclip output. **[Pass 4: UNCHANGED.]**
- **Trial/FDA `map` UUID error** ([#7](https://github.com/GXL-ai/paperclip/issues/7)/[#4](https://github.com/GXL-ai/paperclip/issues/4)) and **SFS supplement merged into `content.lines`** ([#8](https://github.com/GXL-ai/paperclip/issues/8)) were pass-3 findings. **[Pass 4: trial/FDA `map` FIXED; supplement-merge STILL BROKEN (#8 open).]**
- **[Pass 4 NEW] Corpus freshness.** The index is frozen ~March 2026 ([#14](https://github.com/GXL-ai/paperclip/issues/14)); papers published after that are not retrievable.
- **[Pass 4 NEW] `search` requires `-s <source>`.** The pass-3 `search -t --all` form errors; multi-source scoping (`-s a,b`) is silently ignored ([#13](https://github.com/GXL-ai/paperclip/issues/13)). `Run-PaperclipRetrieval.ps1` must be patched before a v0.6.0 full run.

## Style for documents in this repo

The markdown documents in this repo are evidence artifacts, not blog posts. Conventions to preserve when editing:

- Every claim cites an artifact path (preferably with `:L<n>` if applicable).
- Tables use the "File | Rows | Purpose" pattern shown in [`README.md`](README.md).
- Numeric findings (e.g., "15/15 DOI lookups missed") are reproducible from a CSV; do not change a number without updating the underlying row.
- Methodology limitations are declared up front, not buried — see [`methodology.md`](common/methodology.md) §"Methodology limitations (declared)".
- "Pass 3" / "binding" / "predeclared" are load-bearing words: they signal that a rule was fixed before scoring and changing it post-hoc invalidates results.
