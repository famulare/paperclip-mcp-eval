---
case_id: nigeria-2015-versioning
arm: hybrid
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: nigeria-2015-versioning | Arm: Hybrid

## Retrieval validity status

**Status:** Partial / ambiguous on version, identity-resolved on paper.

Paperclip resolves all three identifiers (arXiv 1504.02751, DOI 10.1371/journal.pone.0135765, PMID 26317401) to the same paper — Famulare, "Has wild poliovirus been eliminated from Nigeria?" Cross-identifier convergence is clean: the lookup and search outputs all point to a single Famulare paper.

**Version resolution — the diagnostic question:**

Paperclip's representation collapses the version lineage into a single record. Specifically:
- The arxiv lookup (`lookup arxiv 1504.02751`) returns the record stamped `1504.02751 · arXiv · 2015-04-10` AND carries the PLOS ONE DOI `https://doi.org/10.1371/journal.pone.0135765`. The date `2015-04-10` is the **v1 submission date** per web/API identity (Section 1, line 70).
- The DOI lookup returns the same record — same arXiv ID, same 2015-04-10 date, same DOI.
- The PMID lookup returns a separate record key `PMC4552877 · PLoS ONE · 2015` pointing to the PMC URL.
- The title search returns `arx_1504.02751 · arXiv · 2015-04-10` as the canonical hit, with a snippet that already mentions cVDPV2 transmission continuing (which per ground-truth is content emphasized in v2 / PLOS ONE final).

**Verdict on version label:** Paperclip does **not** resolve to v1, v2, or PLOS ONE final as distinct versioned objects. It surfaces a **conflated record**: the arXiv identifier and v1 submission date (2015-04-10) are bound to the PLOS ONE DOI, with content snippets that appear consistent with the post-v2 / PLOS ONE state. There is no v2 date (2015-07-10) and no PLOS ONE publication date (2015-08-28) anywhere in the Paperclip outputs. The closest Paperclip comes to a version label is "2015-04-10" (v1 date) attached to a record whose content reflects the final published state.

**Failure mode flagged:** version-lineage collapse. Paperclip exposes one object where ground truth has three (v1, v2, PLOS ONE final). The arXiv-versus-journal distinction is preserved at the file-system level (`arx_1504.02751` vs `PMC4552877`) but the arXiv-v1-vs-v2 distinction is invisible.

**Other anomalies:**
- The `map -n 1 --from s_0ee69dd3` probe returned 4 papers (the `-n 1` flag was not honored, as the bundle header warns) and the result for `arx_1504.02751` is the degenerate string "The provided text does not contain a research paper or any content addressing the elimination of wild poliovirus in Nigeria." That is a content-retrieval failure on the arXiv-keyed record despite the title and abstract being indexed. The PMC4552877 record was not in the map set, so we cannot directly confirm whether the PMC content is readable via map.
- `ls /papers/PMC4552877/` shows 116-line content.lines, sections, supplements, figures present — content does exist under the PMC key. The map failure was specific to the arXiv-keyed record.

## Available context

**From web/API identity (Section 1, treated as identity truth):**
- Paper: Famulare M, "Has Wild Poliovirus Been Eliminated from Nigeria?", PLOS ONE 2015-08-28, DOI 10.1371/journal.pone.0135765, PMID 26317401, PMCID PMC4552877.
- arXiv preprint 1504.02751 with two versions: v1 submitted 2015-04-10; v2 revised 2015-07-10. v2 added cVDPV2 forecast updates relative to v1.
- Abstract content (verbatim snippet provided): WPV3 last case Nov 2012; WPV1 last case July 2014 in Nigeria, Aug 2014 in Somalia; cVDPV2 last detection Nov 2014; data cutoff March 31, 2015; estimated WPV1 elimination probability 84%, WPV3 >99%; cVDPV2 elimination probability rises to 83% if no new cases by April 2016.

**From Paperclip retrieval (Section 2, content evidence to be checked):**
- Identifier resolution: all three identifiers resolve to a single Famulare paper, but with version-collapsed representation as described above.
- Title-search snippet for `arx_1504.02751`: "This study modeled poliovirus transmission in Nigeria to estimate elimination probabilities. Wild poliovirus type 1 and 3 are likely eliminated, but circulating vaccine-derived type 2 poliovirus transmission continues." This snippet is consistent with the abstract from Section 1 and consistent with v2 / PLOS ONE final content (cVDPV2 emphasis).
- PMC4552877 has retrievable content (116 lines, sections/supplements/figures directories present per `ls`).
- arXiv-keyed record `arx_1504.02751` failed content retrieval under map probe (returned "no content" string), suggesting Paperclip may have indexed the metadata but not the full text under the arXiv key, or that the map task ran on an empty content slice.
- Title search also surfaces three other Nigeria-polio-adjacent papers (Nightingale et al. 2025 medRxiv, Ekwebelem et al. 2021, Okemoto-Nakamura et al. 2020 Vero cell line). These are real adjacent literature but are NOT the target.

**Not available:**
- The full text of either arXiv version or the PLOS ONE final via the slices in this bundle.
- Any explicit v1-vs-v2 differential content (e.g., the specific cVDPV2 forecast updates v2 added).
- Any local PDF slices in this bundle (none provided).

## Cross-arm conflicts

Hybrid arm only — no cross-arm artifacts to reconcile within this bundle. The intra-arm tension is between (a) web/API identity, which cleanly distinguishes v1 (2015-04-10), v2 (2015-07-10), and PLOS ONE final (2015-08-28), and (b) Paperclip, which collapses all three into a single record stamped with the v1 date and the journal DOI. This is a representational conflict to be flagged for scorers, not a factual disagreement about which paper this is.

A further intra-arm note: the title-search snippet (clean, accurate) and the map probe result (degenerate "no content" string) for the same `arx_1504.02751` record disagree about whether content is reachable. This is a Paperclip internal inconsistency rather than a content conflict.

## 8 prompts

**1. What is the central mechanistic or empirical claim of this paper?**

The paper develops a transmission-dynamics model, calibrated against historical Nigerian polio incidence and tuned to represent the uncertainties intrinsic to AFP surveillance (paralysis-based detection of a small fraction of infections), and uses it to compute probabilities of poliovirus elimination in Nigeria as of a stated data cutoff. The mechanistic core is treating "time since last case" under a model of transmission dynamics plus surveillance sensitivity to estimate the probability that ongoing transmission has been interrupted (Section 1 abstract; Section 2 title-search snippet).

**2. What are the headline quantitative findings?**

As of 2015-03-31 data cutoff (per the PLOS ONE abstract in Section 1):
- WPV1 elimination probability in Nigeria: 84%; conditional on non-elimination, 99% probability a new case is detected by end of 2015.
- WPV3 elimination probability (and thus global eradication of WPV3): >99%.
- cVDPV2 elimination probability: not yet at the threshold; rises to 83% if no new cases are detected by April 2016.
(Source: Section 1 verbatim abstract.) Paperclip's title-search snippet states the qualitative direction (WPV1 and WPV3 likely eliminated, cVDPV2 ongoing) but does not surface the specific 84% / >99% / 83% numbers.

**3. What is the version/lineage status of this paper?**

Per web/API identity (Section 1, treated as truth): arXiv 1504.02751 has two versions — v1 submitted 2015-04-10, v2 revised 2015-07-10 with cVDPV2 forecast updates added — and the journal-of-record version is PLOS ONE 10.1371/journal.pone.0135765, published 2015-08-28. So the lineage is v1 -> v2 -> PLOS ONE final.

Per Paperclip (Section 2): the lineage is collapsed. The arXiv identifier and the v1 date (2015-04-10) are bound directly to the PLOS ONE DOI in a single record; there is no v2 representation and no PLOS ONE publication date. A separate record keyed on PMC4552877 also exists and resolves from the PMID lookup, but it is dated only "2015" without a month, and is not linked back to the arXiv record in any visible cross-reference.

**The diagnostic answer the scorer is checking for: Paperclip resolves arXiv 1504.02751 to a version-conflated record. It is best described as "v1 metadata fused with PLOS ONE DOI and (apparently) post-v2 content snippets" — not cleanly to v1, not cleanly to v2, not cleanly to the PLOS ONE final.**

**4. What evidence base / data sources does the paper draw on?**

Per the abstract: historical polio incidence rates in Nigeria, AFP surveillance data through 2015-03-31, and (implied) the case-detection record for WPV1, WPV3, and cVDPV2. The model is calibrated on those data to estimate transmission dynamics and detection probabilities. No deeper data-source detail is available in this bundle.

**5. What are the stated assumptions or limitations?**

The abstract identifies the fundamental epistemic problem the paper addresses: paralysis-based surveillance detects only a small fraction of infections, so silent transmission can persist undetected, which is "fundamental to interpreting long time periods without cases." The model is explicitly described as "designed to represent the uncertainties in transmission dynamics and poliovirus detection." Further specific assumptions (e.g., functional form of force-of-infection, reporting rate priors, spatial structure) are not visible in this bundle.

**6. What are the key implications or applications stated?**

The paper answers three policy-actionable questions: has WPV1 been eliminated from Africa, has WPV3 been eradicated globally, and has Nigeria interrupted cVDPV2 transmission. Outputs are probabilistic statements (e.g., 84%, >99%, 83% conditional) and an implied surveillance schedule (e.g., the 99%-by-end-of-2015 forward-looking statement gives an operational decision point). Implications include readiness-to-declare for WPV3 global eradication and a continued vigilance horizon for cVDPV2.

**7. What adjacent or related work shows up alongside this paper in retrieval?**

Paperclip's title search returns three adjacent Nigeria-polio-elimination papers:
- Nightingale et al., medRxiv 2025-01-30, "Sub-national estimation of surveillance sensitivity to inform declaration of disease elimination: A retrospective validation against the elimination of wild poliovirus in Nigeria" — explicitly a retrospective validation against the Famulare 2015 case, methodologically downstream.
- Ekwebelem et al., 2021, "Eradication of wild poliovirus in Nigeria: Lessons learnt" — narrative/operational review.
- Okemoto-Nakamura et al., bioRxiv 2020-08-19, "Poliovirus-nonsusceptible Vero cell line for the WHO global action plan" — laboratory-containment work, only thematically adjacent.
These are real adjacent literature, not retrieval contamination, though the Vero-cell paper is only loosely related.

**8. What is the scorable diagnostic summary for this case?**

This case tests whether Paperclip can correctly distinguish arXiv 1504.02751 v1 (2015-04-10), v2 (2015-07-10), and the PLOS ONE final (2015-08-28, DOI 10.1371/journal.pone.0135765) as separate versioned objects. Paperclip does not. It exposes a single record that fuses (a) the arXiv ID, (b) the v1 submission date, and (c) the PLOS ONE DOI, with content snippets that appear to reflect the post-v2 / final state. A separate PMC-keyed record exists but is not cross-linked to the arXiv record at the version level. **The version label is collapsed; the v1/v2 distinction is invisible; the publication date 2015-08-28 is absent.** The paper itself is correctly identified (single Famulare author, correct title, correct DOI, correct PMID/PMCID mapping). Identity resolution: pass. Version-lineage resolution: fail.

## Uncertainty

- Whether Paperclip's apparent "fusion" record is actually a metadata join (arXiv preprint record auto-linked to its journal DOI) or a genuine confusion. Likely the former — arXiv records routinely back-link to the publisher DOI when one exists — but in either case the v1/v2 distinction is not surfaced.
- Whether the post-v2-flavored snippet in the title-search result is generated from the PLOS ONE / v2 full text or from a stored summary that pre-dated v1. The PMC4552877 content.lines (116 lines, 7126 words) was not directly probed in this bundle, so we cannot say from the bundle alone which underlying text the snippet was synthesized from.
- Whether the map probe's "no content" failure on `arx_1504.02751` reflects an actual missing content slice for the arXiv key, or a map-tool artifact (the bundle header warns that map -n 1 does not honor -n, hinting at known map quirks). The `ls /papers/PMC4552877/` output confirms content does exist under the PMC key, so retrieval is at least possible there.
- Whether v2's cVDPV2 forecast updates are reflected in Paperclip's stored content. The bundle does not contain a direct v1-vs-v2 differential, so this is unverifiable from this bundle.

## Prohibited inferences

- Do not claim Paperclip "returned v1" or "returned v2" or "returned the PLOS ONE final" as a clean answer. The accurate finding is that Paperclip returns a version-collapsed record that fuses metadata across the lineage.
- Do not claim Paperclip retrieved or surfaced the full text of either arXiv version. The bundle shows metadata, abstract-equivalent snippets, and (for PMC) directory listing only.
- Do not infer specific quantitative findings (84% / >99% / 83%) as Paperclip outputs. Those numbers come from the Section 1 web/API identity abstract, not from Paperclip retrieval.
- Do not infer the specific v1-to-v2 changes (beyond the ground-truth note that v2 added cVDPV2 forecast updates) from the bundle. The bundle does not contain a differential.
- Do not infer that the three adjacent papers (Nightingale, Ekwebelem, Okemoto-Nakamura) are cited by or cite the target paper. The bundle only shows they co-surface in title search.
- Do not infer authorship details beyond "Michael Famulare, Institute for Disease Modeling, Bellevue, WA" (from Section 1). No co-authors exist; the paper is single-authored.
- Do not treat the map probe's degenerate "no content" string as evidence that the paper has no content; it is more plausibly a tool artifact given the PMC content exists per `ls`.
