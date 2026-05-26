# Final Recommendation

**Origin:** Claude Opus 4.7 (1M context). Drafted from evidence backward; revised after adversarial self-review by an independent Opus 4.7 subagent (see [`adversarial_review_response.md`](adversarial_review_response.md)).
**Date:** 2026-05-22.
**Status:** Active — completion criteria from [`methodology.md`](methodology.md) met with the limitations declared in §"Methodology Limitations" below.

All material claims cite artifact rows or file paths in this folder. Where citation paths span multiple packets, both are listed.

---

## Methodology Limitations (declare-up-front)

The adversarial self-review (see [`adversarial_review_response.md`](adversarial_review_response.md)) found four methodology defects that affect how confidently this recommendation should be read. They are stated up-front rather than buried:

1. **Scoring was not fully blind.** The evaluation contract called for stripping arm labels from synthesis files before scoring. The anonymization step was not run (the methodology document records this). Synthesis files keep `arm:` in frontmatter, and scorers used the arm name in their rationales. The two scorers were both Claude Opus 4.7 — same-model sampling-noise independence, not structural independence. Implication: dimension-level scores and role-level scores should be treated as semi-blind judgments; the rubric's hard caps (which trigger on synthesis content, not on arm name) are not affected by this defect.
2. **Held-out set is partially in-wheelhouse.** The evaluation contract called for "MeSH terms with no overlap" to polio, COVID, surveillance, vaccine immunology. Of the 5 held-out cases: `heldout-tbe-vaccine` is vaccine literature (the contract's named wheelhouse topic); `heldout-snakebite` and `heldout-podoconiosis` are NTD-adjacent; `heldout-hepc-ns5a` is virology-adjacent; only `heldout-tafamidis-attr` (cardiology RCT) is unambiguously outside. Read the held-out evidence as "adjacent topics" rather than "outside the evaluator's neighborhood."
3. **Negative-control N=3 is small for a system-wide cap.** The no-refusal cap on cross-source-query-engine rests on 3 impossible-blend queries, all of which Paperclip answered without refusal. The cap is rubric-defined, but the empirical base is thin. A more rigorous evaluation would test N=10+.
4. **Arm isolation enforced at bundle-construction time; not adversarially audited.** `Build-EvidenceBundles.ps1` writes each arm's bundle from arm-specific sources only. A random-spot-check audit of bundles is not part of this pass.

---

## Executive Judgment

**Operational recommendation:** Use a hybrid workflow (web/API → Paperclip → local PDF, in that order of trust) as the default for KB literature ingestion. Inside that workflow, Paperclip is permitted as a thin PMID-confirmed PMC-skim layer. Outside that workflow, Paperclip is not the right tool.

**Why hybrid, not "Paperclip-first":** Across the 14 scored cases, the hybrid arm has the highest mean overall score (~4.1) and equals or exceeds every other arm on every case in `synthesis_scores.csv`. The Paperclip arm alone has mean Domain Usefulness = 1.9/5 (the dimension that asks "would this output help KB ingestion"). Strict-A hybrid-value classification (Paperclip uniquely contributed evidence no other arm could give) = 0/14 cases. Paperclip's contribution to the hybrid is decoration, rescue, or diagnostic in 13/14 hybrid runs.

**Why permitted, not removed entirely:** Inside the safe-use box (PMID lookup on PMC-versioned papers), Paperclip is convenient. The Famulare supplement-file enumeration and Thakkar arXiv backup-identity are real wins, even if neither is strictly unique (PLOS landing page would expose Famulare's supplements; arXiv would have shown the Thakkar identity when not rate-limited).

**What this is NOT:** Not "hybrid by default" (pass-1's framing without measurement). Not "use as candidate generator" (pass-2's framing without index-scope probes). The recommendation is grounded in measured per-arm scores, measured probe results across 4 index-scope miss classes, and measured negative-control behavior.

---

## Role-Specific Conclusions

Role-level scores below are anchored against `synthesis_scores.csv` cell aggregates plus the rubric caps. The path: (1) compute the Paperclip-arm overall mean for the case set relevant to that role; (2) apply role-specific caps from `scoring_rubric.md` §"Hard Caps"; (3) consider held-out vs known-target asymmetry. Where a role-score is a judgment call rather than a numerical reduction, it is declared as such.

### Paperclip as source resolver — 2/5

**Derivation:** Paperclip's source-resolver behavior is captured by exact-ID lookup outcomes plus title-search precision. From `retrieval_observations.csv` and `index_scope_probes.csv`:

- **DOI lookup miss rate:** 12/12 index-scope probes (P01–P12) plus 3/3 known cases (Famulare, Kew, Khoury) = **15/15 DOI lookups missed**.
- **PMID lookup hit rate (PMC-versioned papers):** 9/14 known+held-out cases when target is PMC-indexed. Misses concentrate in Annual Reviews / pre-1980 / paywalled-non-PMC.
- **Title-search drift:** Khoury title search returned medRxiv preprint at rank 2 (not Nature Medicine final); Kew title search returned 5 polio neighbors but no Kew.
- **Held-out title-search inconsistency:** for HCV, podoconiosis, snakebite (the held-out PMID-hits), title search returned different papers than the PMID lookup. PMID hit ≠ title-search hit. Workflow-level reliability is lower than the PMID hit rate suggests.

**Score: 2/5.** Per `scoring_rubric.md`, "2: Major omission … weak traceability." Identity resolution misses ~half the corpus and the half-that-works requires PMID-first-then-validate discipline.

### Paperclip as document reader — 2/5 supplement-bearing; 3/5 clean PMC

**Derivation:** Document-reader score depends on content fidelity and content organization. The wrong-content-organization cap (`scoring_rubric.md:25`) drops the score to ≤2 when supplements are merged into content.lines without separators.

- **SFS wrong-content-organization:** `retrieval_packets/sfs-nejm-2020__ls_supplements.txt` shows `supplements/` is empty (read-only banner only). `retrieval_packets/sfs-nejm-2020__grep_supplement.txt` shows L31 `# Supplementary Appendix`, L32-L33 supplement preamble, L35 `## **Supplementary Appendix**`, L44 `Supplemental Table 1`. The separate `sfs-nejm-2020__grep_identity.txt` packet also shows L47 `Supplemental Table 2`. The supplementary appendix is merged into the main content blob without programmatic separator.
- **content.lines ≠ full paper text:** Famulare 2018: `wc /papers/PMC5942853/content.lines` = 252 lines / 1,081,313 chars. But the synthesizer flagged that `sections/`, `figures/`, and supplement files (s001.pdf, s002.zip) were not read.
- **Where it works:** Famulare supplement enumeration (`pbio.2002468.s001.pdf`, `pbio.2002468.s002.zip` visible via `ls /papers/PMC5942853/supplements/`); NCT trial paper PMID lookup + content access; HCV/snakebite/podoconiosis identity resolution.

**Score: 2/5 for supplement-bearing or wrong-org cases; 3/5 for clean PMC papers.** Net role assessment: 2/5 because the SFS-style defect is silent — users have no way to detect it without grep.

### Paperclip as version resolver — 1/5

**Derivation:** Two version-stress cases (Khoury preprint/final, Nigeria arXiv v1/v2/PLOS ONE). Both failed.

- **Khoury preprint returned when final was requested:** `retrieval_packets/khoury-2021-natmed__search_title.txt` returned medRxiv preprint at rank 2 (no flag distinguishing preprint vs. final). Numerical results in the preprint differ from the Nature Medicine final.
- **Nigeria version collapse:** `retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt` returns a single record dated 2015-04-10 (v1 date) carrying the PLOS ONE DOI (final's identifier). Three versions collapsed into one.
- **No version field in record format:** Paperclip's record schema does not expose preprint / postprint / corrected / retracted.

**Score: 1/5.** Per `scoring_rubric.md`, "1: Failed, wrong document, wrong version, misleading, hallucinated, or unsafe for ingestion." Khoury's returned-preprint-as-final-target is wrong-version-returned and would pollute the KB.

### Paperclip as supplement resolver — 2/5

**Derivation:** Three supplement-bearing cases (Famulare clean, SFS misorganized, NCT trial paper no supplements/ dir).

- Famulare 2018: clean (2 files visible).
- SFS NEJM correspondence: merged into content.lines (zero files in supplements/).
- NCT trial paper: no supplements/ directory listed.

**Score: 2/5.** Inconsistent. Cannot trust the absence of supplements/ as evidence of "no supplements."

### Paperclip as trial/paper bridge — 2/5

**Derivation:** Trial-map UUID failure triggers ≤2 cap for map-dependent claims.

- **Trial map fails:** `retrieval_packets/nct04232943-pmid36746739__trial_map.txt` shows `ERR: map: invalid input syntax for type uuid: "tri_7fa7a997858a"`.
- **Trial precision (N=1 observation):** The negative-control rerun returned only the two NCT04232943 trial docs, no false-positive NCT04544787 (an earlier development iteration saw NCT04544787). Single observation; insufficient to claim systemic precision improvement.
- **Trial corpus has gaps:** Pass-2 held-out NCT05327426 returned no papers.

**Score: 2/5.** Reading layer only. ClinicalTrials.gov v2 API is the registry source of record.

### Paperclip as cross-source query engine — 2/5 (system-wide cap)

**Derivation:** Cap from `scoring_rubric.md:30` (no-refusal cap). 3/3 impossible-blend queries returned candidates without refusal:

- `neg-sfs-dmlt`: 5 mixed candidates.
- `neg-khoury-polio`: 6 mixed candidates.
- `neg-famulare-covasim-hornick`: 4 mixed candidates.
- All cited in `negative_controls.csv` and `retrieval_packets/neg-*__probe.txt`.

Also: `map -n N` does not honor N (`retrieval_packets/famulare-2018-plosbio__map_n_probe.txt`, `nigeria-2015-versioning__map_n_probe.txt`, `nct04232943-pmid36746739__map_n_probe.txt` — all show 5/5 or 2/2 tasks despite `-n 1`).

**Score: 2/5.** N=3 negative controls is small for a system-wide claim (acknowledged in Methodology Limitations).

### Hybrid arm — 4/5 empirical mean

Despite the contract's "hybrid is NOT max-of-arms" rule, the hybrid arm empirically dominates: mean overall ~4.1 across 14 cases, equals or exceeds every other arm in every case. This is consistent with hybrid being its own synthesizer over a combined bundle (per [`hybrid_workflow.md`](hybrid_workflow.md)), and operationally it argues for hybrid-by-default with Paperclip as one ingredient. The evaluation contract's "hybrid never scored as max" rule prevents arithmetic cheating but does not deny the empirical observation: when you use all three arms together with arm-isolated synthesis, the result is materially better than any arm alone.

---

## Hybrid Value Tally (post-adversarial-review)

Re-tallied under strict A criterion ("Paperclip uniquely contributed evidence other arms could not have given") per `hybrid_workflow.md:45`:

| Classification | Strict count | Cases |
|---|---:|---|
| **A** — Paperclip uniquely contributed (no caveat) | **0 (0%)** | (none; both prior A's carry "web could too" caveats in CSV row text) |
| **B** — Web/local could have done alone faster | 4 (29%) | Famulare (PLOS landing exposes supplements; Paperclip path faster); heldout-hepc-ns5a; heldout-snakebite; heldout-podoconiosis |
| **C** — Paperclip-rescue (Paperclip failed; web/local recovered) | 6 (43%) | Kew; Khoury; Cheslock; Nigeria; heldout-tbe-vaccine; heldout-tafamidis-attr |
| **D** — Paperclip diagnostic only | 2 (14%) | SFS (merged-supplement diagnostic); NCT-pair (trial-map UUID failure diagnostic) |
| **E** — No added value | 1 (7%) | Hornick (all arms failed at content level) |
| **F** — Backup when web is degraded (rate-limited) | 1 (7%) | Thakkar/Famulare arXiv (Paperclip resolved when arXiv API was rate-limited; redundancy not uniqueness) |

Sum = 14 cases (verified: 0+4+6+2+1+1=14, 100%).

**Headline:** Paperclip uniquely contributed (strict A) in **0/14 cases**. In 6/14 (43%) cases the workflow had to recover from Paperclip's failure. In 4/14 (29%) cases Paperclip is decoration on web that's faster alone. In 2/14 (14%) cases Paperclip's diagnostic value (finding a defect to know about) is the only contribution. In 1/14 (7%) it's a redundancy backstop when web is degraded. In 1/14 (7%) no arm contributed.

---

## Strongest Pro-Paperclip Evidence

| Claim | Artifact citation |
|---|---|
| When the target is PMC-versioned, PMID lookup resolves cleanly. | `retrieval_observations.csv` rows for Famulare, SFS, NCT-paper, HCV-heldout, snakebite-heldout, podoconiosis-heldout (and probes P05, P06) |
| For Famulare-class papers, Paperclip exposes supplements as a filesystem path. | `retrieval_packets/famulare-2018-plosbio__ls_supplements.txt` shows `pbio.2002468.s001.pdf` and `pbio.2002468.s002.zip` |
| Single-observation: Paperclip trial-search returned no false positives in the re-run. | `negative_controls.csv` row `neg-nct-nearmiss` (N=1) |
| arXiv lookup hits when external arXiv API is rate-limited. | `retrieval_packets/thakkar-famulare-arxiv__lookup_arxiv_2205_02150.txt`, `lookup_arxiv_2311_16317.txt` |
| `grep` on `content.lines` is a useful diagnostic on content-organization defects. | `retrieval_packets/sfs-nejm-2020__grep_supplement.txt` (paradoxically also anti-Paperclip evidence; see below) |

## Strongest Anti-Paperclip Evidence

| Claim | Artifact citation |
|---|---|
| Annual Reviews are not indexed (0/3 probed hit). | `index_scope_probes.csv` P01–P03 |
| Pre-1980 NEJM not indexed (0/3 probed hit). | `index_scope_probes.csv` P07–P09 |
| Paywalled non-PMC papers (Lancet 2019 randomized trials, NEJM 2018 ATTR-ACT) not indexed (0/3 Lancet + 1 NEJM held-out miss). | `index_scope_probes.csv` P10–P12; `retrieval_observations.csv` heldout-tafamidis-attr row |
| DOI lookups miss even on PMC-indexed papers (12/12 across probed papers; 3/3 across known cases = 15/15). | `retrieval_packets/famulare-2018-plosbio__lookup_doi.txt`, `kew-2005-opv-review__lookup_doi.txt`, `khoury-2021-natmed__lookup_doi.txt`; `index_scope_probes.csv` DOI columns P01–P12 |
| Version lineage is collapsed (preprint and final indistinguishable). | `retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt`; `retrieval_packets/khoury-2021-natmed__search_title.txt`; `version_lineage.csv` |
| Wrong-version returned: medRxiv preprint instead of Nature Medicine final on Khoury title search. | `retrieval_packets/khoury-2021-natmed__search_title.txt` rank 2 |
| Wrong-content-organization: SFS supplementary appendix merged into `content.lines` while `supplements/` is empty. | `retrieval_packets/sfs-nejm-2020__ls_supplements.txt`; `retrieval_packets/sfs-nejm-2020__grep_supplement.txt` (lines L31, L32, L33, L35, L44); `retrieval_packets/sfs-nejm-2020__grep_identity.txt` (line L47) |
| Trial `map` fails with UUID error on `tri_*` IDs. | `retrieval_packets/nct04232943-pmid36746739__trial_map.txt` |
| `map -n N` does not honor the result limit; map outputs are multi-paper contaminated by default. | `retrieval_packets/famulare-2018-plosbio__map_n_probe.txt`, `nigeria-2015-versioning__map_n_probe.txt`, `nct04232943-pmid36746739__map_n_probe.txt` — all show 5/5 (or 2/2 for Nigeria) tasks despite `-n 1` |
| No refusal behavior on impossible-blend queries (3/3 returned candidates; small N). | `negative_controls.csv` rows neg-sfs-dmlt, neg-khoury-polio, neg-famulare-covasim-hornick |
| Hybrid runs show Paperclip uniquely added value (strict A) in 0/14 cases. | `hybrid_value_classification.csv` aggregate (post-adversarial reclassification) |
| Paperclip arm mean Domain Usefulness across 14 cases = 1.9/5. | `synthesis_scores.csv` DU column for Paperclip rows; scorer rationales in `scorer_packets/output/scorerA_all.md` and `scorerB_all.md` |

## Failure-Mode Taxonomy

| Failure mode | Type | Fix likelihood (author opinion, not artifact-derived) |
|---|---|---|
| DOI lookup miss on PMC-indexed papers | Product bug (DOI normalization or DOI-index coverage) | Plausibly fixable in vendor maintenance |
| `map -n N` does not honor `N` | Product bug | Plausibly fixable |
| Trial `map` UUID error on `tri_*` IDs | Product bug (schema mismatch) | Plausibly fixable |
| Wrong-content-organization (SFS supplement merged into content.lines) | Ingestion-pipeline defect | Plausibly fixable; takes time to backfill |
| Recency bias in title-search ranking (Khoury → 2022 medRxiv at rank 1 over the 2021 target's preprint at rank 2) | Search-ranking design | Plausibly fixable with version-aware ranking |
| Annual Reviews not indexed | Index-scope limitation | Depends on publisher licensing / re-ingestion |
| Pre-1980 NEJM not indexed | Index-scope limitation | Depends on older-corpus expansion |
| Paywalled non-PMC papers not indexed | Index-scope limitation, likely architectural | Likely durable |
| No refusal behavior on impossible queries | Fundamental product-design choice | Likely durable without LLM-layer additions |
| Version lineage collapse | Fundamental data-model issue | Likely durable without schema changes |
| Wrong-version returned on title search | Search-ranking + version-awareness gap | Plausibly fixable with version-aware indexing |

**Note:** "Fix likelihood" is author judgment from public Paperclip behavior, NOT artifact-derived. It is offered as a heuristic for prioritizing follow-up checks, not as a Paperclip-roadmap prediction.

## Safe-Use Conditions

Paperclip is safe to use when ALL of the following hold:

1. The target paper has a known PMID AND is PMC-versioned.
2. Identity is independently verified against PubMed (PMID, title, authors, year all match what Paperclip returns).
3. The use case is content inspection (`ls`, `wc`, `grep`), not full-paper synthesis.
4. The user knows that `map` output across multiple papers is contaminated by default and either extracts only the target paper's section or refuses to use it.
5. Supplements are independently inventoried from publisher/PMC (do NOT trust Paperclip's `supplements/` dir as the truth).
6. Versions are independently labeled from arXiv/journal metadata (do NOT trust Paperclip to distinguish preprint/final/postprint).
7. For trial-paper bridge work, ClinicalTrials.gov v2 API is the source of record. Paperclip is reading convenience only.

## Unsafe-Use Conditions

Paperclip is unsafe to use when ANY of the following hold:

1. Target paper is in Annual Reviews, pre-1980 medical literature, or paywalled non-PMC journals.
2. The use case requires distinguishing preprint, accepted manuscript, final, postprint, or corrected versions.
3. The use case requires supplement-content fidelity (separated by file, with clear labels).
4. The query is conceptual / cross-source / multi-entity. Paperclip will return candidates without refusing impossible blends.
5. The workflow expects `map -n N` to actually return N results.
6. The workflow expects `map` over trial-document IDs to work.
7. The output will be ingested into a KB without source-of-record verification.

## Likely Fixability — Author Opinion, NOT Artifact-Derived

This section is the main agent's prior beliefs about software-engineering fix difficulty. Per the adversarial review's S5, it is not artifact-derived. The product-bug class (DOI lookup, `map -n`, trial UUID, content organization) is the kind of issue that vendors fix in maintenance cycles when surfaced. The index-scope and design-choice class (Annual Reviews, pre-1980, paywalled non-PMC, no-refusal behavior, version-collapse) reflect Paperclip's PMC-anchored architecture and may be durable. A Fermi KB workflow that needs literature outside PMC should not wait for Paperclip to expand corpus.

## Evidence That Would Change The Recommendation

Re-run pass 3 (in part or whole) if any of the following change:

1. Paperclip documents its index scope explicitly (per-source-class coverage) and the Annual Reviews / pre-1980 / paywalled-non-PMC gaps narrow.
2. `map -n N` is fixed to honor N.
3. Trial `map` is fixed to accept `tri_*` UUIDs.
4. A `version` field is added to paper records distinguishing preprint, final, postprint, corrected.
5. A refusal/uncertainty signal is added to impossible-blend queries.
6. The SFS-style merged-supplement defect is fixed: supplements are exposed as separate files with metadata.
7. **Blind re-scoring on anonymized synthesis files** produces materially different role-level scores than this pass.

Re-evaluation would re-run Phase 3 (Paperclip retrieval) and Phase 4 (index-scope probes) at minimum; Phases 7–10 if synthesis or scoring is implicated.

---

## Bottom Line

**Don't adopt Paperclip as anything load-bearing.** For the Fermi KB:

- **Use a hybrid workflow** (web/API → Paperclip → local PDF, in trust order). The hybrid arm is empirically the strongest arm (mean overall ~4.1 across 14 cases).
- **Paperclip's role inside the hybrid is a thin PMID-confirmed PMC-skim layer.** Useful when the target paper is in PMC; silent or misleading when not.
- **Outside the safe-use box, Paperclip is not the right tool.** Annual Reviews, pre-1980 literature, paywalled non-PMC papers, version-lineage cases, and impossible queries all require non-Paperclip workflows.
- **Paperclip's unique contribution under strict criterion is 0/14 cases.** It is decoration in some, rescue target in many, diagnostic in a few. The PubMed / arXiv / ClinicalTrials.gov / publisher-page side of the workflow is doing the load-bearing work.

The strongest path to broader Paperclip adoption is index-scope expansion (Annual Reviews, paywalled major-journal coverage, pre-1980) plus refusal-signal addition. Without those, Paperclip's value is sub-decoration: not zero, but well below "default tool" status.
