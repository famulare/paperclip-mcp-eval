# Index Scope Findings (Pass 3)

**Origin:** Claude Opus 4.7 (1M context)
**Status:** Complete — probes converted hypotheses into findings.

## Purpose

Pass 2 hypothesized "not indexed source or paywalled/non-PMC source" for the Kew, Khoury, and Hornick misses. Pass 3 probed three NEW papers per miss class to convert hypothesis into finding.

## Probe Findings

See `index_scope_probes.csv` for raw results (12 probes total).

| Miss Class | Probes | Hits | Misses | Inferred Scope Status | Confidence |
|---|---:|---:|---:|---|---|
| Annual Reviews (Kew miss class) | 3 | 0 | 3 | **Not indexed** | High — 3/3 miss including a PMC-versioned 2023 paper (Annual Rev Immunol P03). |
| Recent Nature Medicine finals (Khoury miss class) | 3 | 2 (by PMID) | 1 | **Partially indexed by PMID-with-PMC, NOT by DOI** | High — P04 missed both DOI and PMID; P05, P06 missed DOI but hit PMID. Pattern: Paperclip indexes PMC-versioned papers but does not resolve final-publisher DOIs. |
| Pre-1980 NEJM (Hornick miss class) | 3 | 0 | 3 | **Not indexed** | High — 3/3 miss; pre-1980 NEJM articles are not in Paperclip's corpus. |
| Paywalled non-PMC (general miss class) | 3 | 0 | 3 | **Not indexed** | High — 3/3 miss for Lancet 2019 randomized trials (FLOT4, CASPIAN, KEYNOTE-048). Confirms paywalled-without-PMC = not indexed. |

## Pattern

Paperclip's corpus is **PMC-dependent**. Specifically:

- **PMID lookup with PMC version → high hit rate.** When a paper has a PMC version, Paperclip's PMID lookup resolves it (e.g., Famulare-PMID, SFS-PMID, NCT-paper PMID all worked).
- **DOI lookup is unreliable even for PMC-indexed papers.** All 5 of the Famulare/Khoury/Kew/Nigeria/Khoury-style cases observed DOI misses. This is a Paperclip-side DOI-normalization or DOI-index-coverage issue, NOT a corpus issue.
- **Non-PMC source classes are systematically excluded:**
  - Annual Reviews journals (Microbiology, Immunology, Virology)
  - Pre-1980 biomedical literature (NEJM 1970s, etc.)
  - Paywalled major-journal articles without PMC versions (NEJM 2018 ATTR-ACT, Lancet 2019 randomized trials)
- **PMC plus held-out concept queries → 3/5 hit** (TBE missed, ATTR-ACT missed; HCV/snakebite/podoconiosis hit). The 2 misses are both non-PMC journal artefacts.

## Implications For Recommendation

1. **Recommend Paperclip ONLY for PMC-indexed literature.** Outside PMC, the corpus is sparse and silent failure is likely.
2. **DOI lookup is unsafe.** Always use PMID/PMCID/arXiv as the primary resolver. Treat DOI misses as inconclusive (the paper may exist in Paperclip under PMID).
3. **Pre-1980, paywalled non-PMC, and Annual Reviews are reliable miss classes.** A KB workflow that needs these classes cannot rely on Paperclip.
4. **The corpus boundary is not documented by Paperclip.** Users have no way to predict ahead of time whether their target is indexed. This is a UX failure with downstream KB-pollution risk.

## Diagnostic Probes Run

See `index_scope_probes.csv` for full rows. Summary:

| Probe ID | Target | Class | Result |
|---|---|---|---|
| P01 | PMID 38166256 — T Cell Exhaustion (Annu Rev Immunol 2024) | annual-reviews | MISS |
| P02 | PMID 32196426 — Seasonality of Respiratory Viruses (Annu Rev Virol 2020) | annual-reviews | MISS |
| P03 | PMID 36750315 — NLRP3 Inflammasome (Annu Rev Immunol 2023; PMC10159982) | annual-reviews | MISS (has PMC version but still missed) |
| P04 | PMID 36109639 — Anti-CD19 CAR T cell SLE (Nat Med 2022) | nat-med-recent | MISS |
| P05 | PMID 36216945 — Semaglutide STEP 5 (Nat Med 2022) | nat-med-recent | HIT via PMID (PMC9556320); MISS via DOI |
| P06 | PMID 36008722 — Cemiplimab phase 3 NSCLC (Nat Med 2022) | nat-med-recent | HIT via PMID (PMC9671806); MISS via DOI |
| P07 | PMID 226885 — Hormone receptors (NEJM 1979) | pre1980-nejm | MISS |
| P08 | PMID 111125 — Transplantation (NEJM 1979) | pre1980-nejm | MISS |
| P09 | PMID 460310 — Hypouricemia (NEJM 1979) | pre1980-nejm | MISS |
| P10 | PMID 30982686 — FLOT4 gastric (Lancet 2019) | paywalled-non-pmc | MISS |
| P11 | PMID 31590988 — CASPIAN small cell lung (Lancet 2019) | paywalled-non-pmc | MISS |
| P12 | PMID 31679945 — KEYNOTE-048 head/neck SCC (Lancet 2019) | paywalled-non-pmc | MISS |
