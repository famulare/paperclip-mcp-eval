# Pass 3 Scoring Rubric

**Origin:** Claude Opus 4.7 (1M context); inherits pass-2 rubric structure.
**Status:** Binding for pass-3 scoring.

## Scale

Scores are `1-5` or `NA`.

- **5:** Correct, complete for the question, version-aware, supplement-aware, traceable to bundle evidence, and appropriately uncertain.
- **4:** Mostly correct with minor omissions that would not mislead KB ingestion.
- **3:** Useful but incomplete; requires expert repair before ingestion.
- **2:** Major omission, version confusion, unsupported claim, weak traceability, or content-organization problem.
- **1:** Failed, wrong document, wrong version, misleading, hallucinated, or unsafe for ingestion.
- **NA:** Not tested or no valid source evidence available. NA is not a hidden pass.

## Dimensions

- **Evidence fidelity (EF):** answer matches bundle evidence; no fabrication.
- **Missing-detail control (MD):** answer flags what's missing rather than glossing over it.
- **Unsupported-claim detection (UC):** answer distinguishes direct claims from inference and external assumptions.
- **Version/provenance fidelity (VP):** answer respects preprint/final/postprint distinctions when relevant.
- **Supplement/protocol/table/figure use (SP):** answer engages with non-main-text evidence appropriately.
- **Traceability (TR):** claims in answer cite bundle anchors.
- **Domain usefulness (DU):** answer would help the KB owner for ingestion.
- **Time/friction (TF):** scored at the arm level from retrieval packets, not the synthesis text.

## Hard Caps (apply before mean)

- **Wrong document, wrong version, or unsafe synthesis caps overall at 1.**
- **Invalid identity caps overall at 2.**
- **Supplement-heavy case without validated supplement inventory caps MD and overall at 3.**
- **Versioned case without validated version label caps VP and overall at 3.**
- **Trial query with failed Paperclip `map` caps Paperclip trial-query-engine score at 2 for map-dependent claims.**
- **Wrong content organization (e.g., supplement merged into `content.lines` without separator) caps document-reader score at 2.** [NEW IN PASS 3]
- **No-refusal on impossible-blend negative-control queries caps cross-source-query-engine and trial-query-engine role scores at 2 system-wide.** [NEW IN PASS 3]

## Map Contamination Rule

If a Paperclip-arm synthesis cites a `map` output that processed >1 paper (because Paperclip ignored `-n 1`), the synthesizer must either (a) extract only the target paper's section from the map output and use only that, or (b) treat the map output as contaminated and unusable.

- (a) is permissible if the extraction is unambiguous and recorded.
- (b) is mandatory if extraction is ambiguous.
- Treating a multi-paper map output as a single-paper answer is an EF=1 finding.

## Overall Score

Overall = rounded mean of non-NA dimension scores AFTER caps are applied.

NA dimensions do not lower the mean (they are excluded), but if MORE than half of dimensions are NA, the overall score itself is NA.

## Negative-Control Grading

- **Impossible-blend query** (e.g., "Famulare Covasim Hornick typhoid challenge"): expected behavior is no result OR explicit refusal/uncertainty. Observed behavior of returning ≥1 plausible candidate without uncertainty = **fail**, not partial.
- **Near-miss query** (e.g., return target but no near-misses): expected behavior is target with no false positives in result set. Observed behavior with ≥1 false positive in same result set = **fail**, not partial.

## Scorer Instructions (binding)

- Score from the bundle and ground truth only.
- Do not consult outside knowledge of the paper.
- Mark each dimension and apply caps; show your work in `scorer_packets/output/<packet_id>__scorerN.md`.
- For each cap applied, cite the rubric clause and the bundle/ground-truth evidence triggering it.
- You do not know which arm produced the answer. Do not guess.
