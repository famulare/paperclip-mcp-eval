# Synthesis prompts + evaluation roles (canonical source-of-truth)

**Origin:** reconstructed 2026-07-16 (Claude Opus 4.8) from the pass-3 synthesis-output headers (e.g. [`../paperclip/evidence/synthesis_outputs/famulare-2018-plosbio__paperclip.md`](../paperclip/evidence/synthesis_outputs/famulare-2018-plosbio__paperclip.md)) and [`methodology.md`](methodology.md). Referenced throughout the repo as "the 8 fixed evaluation prompts" and "the six Paperclip roles" but never previously stored verbatim; persisted here so every arm (Paperclip, web, local, hybrid, **Asta**) is evaluated against an identical contract. Binding for pass-5 (the Asta standalone-arm scored run).

## The 8 fixed synthesis prompts

Each arm's synthesizer answers these using **ONLY that arm's evidence bundle** — no outside knowledge. If a prompt cannot be answered from the bundle, write **"Cannot answer from this arm's evidence"** and state what is missing (do not fabricate).

1. **Central mechanistic claim** — What is the central mechanistic or empirical claim of THIS paper?
2. **Evidence supporting it** — What evidence in the paper supports that claim (data, methods, parameters, analyses)?
3. **Hidden detail** — What important detail lives in a supplement, table, figure, appendix, protocol, statistical analysis plan, or registry field?
4. **Expert eye** — What would a domain expert notice that a generic summary might miss?
5. **Overclaim risk** — What would be dangerous to overclaim from this paper?
6. **Under-supported claims** — Which author claims are not well-supported by the data presented?
7. **External dependencies** — Which claims depend on external literature, assumptions, registry context, or expert judgment?
8. **KB-theme connection** — How does the paper connect to the KB's standing themes: *mechanistic-over-narrative*, *surveillance-as-measurement*, *multi-scale modeling*, *continuous immunity*? (Answer per theme; "Cannot answer from this arm's evidence" where the bundle is silent.)

## The 6 roles scored separately (methodology.md §"Six roles")

A high score in one role does NOT propagate to others; the recommendation reports each separately.

1. **Source resolver** — resolve exact identifiers (DOI/PMID/PMCID/arXiv/NCT) to the correct document.
2. **Document reader** — expose the paper's content faithfully, with correct organization (body, supplements, figures, tables).
3. **Version resolver** — distinguish preprint / accepted manuscript / journal final / postprint / corrected.
4. **Supplement resolver** — inventory and serve supplements as separate, labeled artifacts.
5. **Trial/paper bridge** — connect ClinicalTrials.gov records to the corresponding publication.
6. **Cross-source query engine** — handle conceptual queries safely (refuse impossible blends; flag uncertainty).

## The 8 scoring dimensions (scoring_rubric.md)

Scale 1–5 or NA; overall = rounded mean of non-NA dimensions **after** hard caps.

- **EF** Evidence fidelity · **MD** Missing-detail control · **UC** Unsupported-claim detection · **VP** Version/provenance fidelity · **SP** Supplement/protocol/table/figure use · **TR** Traceability · **DU** Domain usefulness · **TF** Time/friction (scored at arm level from retrieval packets, not synthesis text).

Hard caps (trigger on synthesis content, not arm name): wrong document/version/unsafe → overall 1; invalid identity → ≤2; supplement-heavy without validated inventory → MD & overall ≤3; versioned without validated version label → VP & overall ≤3; wrong content organization → document-reader ≤2; no-refusal on impossible-blend negative controls → cross-source & trial-engine roles ≤2 system-wide. (The pass-3 "Map Contamination Rule" is retired for v0.6.0+ and does not apply to the Asta arm.)

## Asta-arm note (pass-5)

Asta's evidence is metadata + abstract (via `get_paper`) plus ~500-word `snippet_search` excerpts (title/abstract/body) **excluding figure captions and bibliography**, with **no supplement, table, figure, or trial-registry surface**. Expect NA / "cannot answer" on SP-heavy and trial-bridge prompts for papers whose body is not in the snippet index (all closed-access papers), and richer answers for open-access/preprint papers whose body IS indexed. This is a modality property, recorded as a finding — the rubric and caps are applied identically to all arms.
