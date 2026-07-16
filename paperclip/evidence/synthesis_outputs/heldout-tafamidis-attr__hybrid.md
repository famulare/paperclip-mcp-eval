---
case_id: heldout-tafamidis-attr
arm: hybrid
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: heldout-tafamidis-attr | Arm: Hybrid

## Retrieval validity status

**Target paper:** PMID 30145929 / DOI 10.1056/NEJMoa1805689 — Maurer MS, Schwartz JH, Gundapaneni B, Elliott PM, Merlini G, Waddington-Cruz M, et al.; ATTR-ACT Study Investigators. "Tafamidis Treatment for Patients with Transthyretin Amyloid Cardiomyopathy." *N Engl J Med.* 2018 Sep 13;379(11):1007-1016.

**Arm conflict — major (Paperclip miss on high-profile NEJM pivotal trial):**
- Web/API identity successfully resolved the target paper from PubMed (full record + abstract authors line + ATTR-ACT investigator group).
- Paperclip `lookup pmid 30145929` returned **"No documents found"** — the target paper is **not in the Paperclip corpus**.
- Paperclip `search -t --all "Tafamidis Treatment for Patients with Transthyretin Amyloid Cardiomyopathy" -n 5` returned 5 **different** ATTR/tafamidis papers, none of which is the Maurer et al. 2018 ATTR-ACT NEJM paper:
  1. Lau, DiDomenico, Kim 2023 (med_cf8e3df76ca2, medRxiv) — cost-effectiveness of HFpEF screening for ATTR-CM.
  2. Sultan, Gundapaneni, Schumacher, Schwartz 2017 (PMC5606341) — tafamidis in early-stage **transthyretin cardiomyopathy** (an earlier/different study, likely a re-analysis of Fx-005 or the open-label extension; the lead authors overlap with the ATTR-ACT author list but the paper is not Maurer 2018).
  3. Phillips 2021 (arx_2112.12879) — title-only arXiv stub on TTR amino-acid evolution; no body text.
  4. Elliott, Drachman, Gottlieb et al. 2021 (PMC8763250) — long-term survival with tafamidis (the ATTR-ACT long-term extension / follow-on analysis, *Circ Heart Fail*, not the pivotal NEJM paper).
  5. Nakamura et al. 2020 (PMC7819654) — initial real-world Japanese experience, n=9.
- The `map -n 1` probe of the s_a3cfc5ea result set confirmed these are the five surfaced papers and characterized their distinct claims; none is the ATTR-ACT pivotal trial.
- No local PDF slices were provided in this bundle (case note: held-out outside-wheelhouse).

**Net retrieval state:** Identity is anchored by web/API. Content for the *target* paper is unavailable in the bundle — Paperclip does not have the pivotal NEJM trial, and no local PDF was provided. The only content evidence for the target is (a) the PubMed authors line + journal/date and (b) the scorer-side "diagnostic claim anchors" (phase 3 RCT, multicenter double-blind, all-cause mortality and CV hospitalization endpoints, NEJM 2018). The truncated abstract snippet in the bundle is essentially the author/collaborator list and does not include the methods/results paragraphs. Paperclip outputs cover *neighbor / downstream* papers in the same line of work (notably the long-term extension), which corroborate the target's existence and impact but are independent works.

**Wheelhouse flag:** This is an outside-wheelhouse cardiology RCT and Paperclip missed despite the target being a high-profile NEJM pivotal trial that anchored the entire ATTR-CM treatment field. This is a notable corpus coverage gap.

## Available context

### From web/API (target paper, identity + partial abstract)
- **Authors (top 6):** Maurer MS; Schwartz JH; Gundapaneni B; Elliott PM; Merlini G; Waddington-Cruz M; et al. (ATTR-ACT Study Investigators).
- **Year:** 2018 (Sep 13). **Venue:** *N Engl J Med* 379(11):1007–1016.
- **Paper type:** Phase 3 randomized controlled trial primary report.
- **Diagnostic anchors (from ground-truth section):**
  - Phase 3 randomized trial of tafamidis vs placebo for transthyretin amyloid cardiomyopathy (ATTR-CM).
  - Multicenter, double-blind.
  - Reports all-cause mortality and cardiovascular hospitalization endpoints.
  - Published in NEJM 2018.
- **Abstract body text:** The retrieved abstract snippet in the bundle contains essentially the author and ATTR-ACT collaborator list and is truncated before the trial design/results paragraphs. The full quantitative abstract is **not in this bundle**.

### From Paperclip (neighbor / downstream papers in same field; NOT the target)
- **Sultan et al. 2017 (PMC5606341):** "Treatment With Tafamidis Slows Disease Progression in Early-Stage Transthyretin Cardiomyopathy." Map summary: tafamidis significantly extended time to death in treated patients with early-stage TTR cardiomyopathy. This predates ATTR-ACT and likely reports on the Fx1A-201 / -003 open-label or early-stage cohort; not the ATTR-ACT pivotal trial.
- **Elliott et al. 2021 (PMC8763250):** "Long-Term Survival With Tafamidis in Patients With Transthyretin Amyloid Cardiomyopathy" — Map summary: earlier treatment (continuous tafamidis vs placebo-then-tafamidis crossover) significantly reduced all-cause mortality. This is the long-term extension / follow-on of ATTR-ACT, citing back to it but not being it.
- **Nakamura et al. 2020 (PMC7819654):** Real-world Japanese cohort, n=9, no significant 6-month biomarker improvement — illustrates post-licensure clinical experience.
- **Lau et al. 2023 (med_cf8e3df76ca2):** Cost-effectiveness modeling of universal PYP screening for ATTR-CM in HFpEF — downstream policy/health-economics work that takes tafamidis efficacy as input.
- **Phillips 2021 (arx_2112.12879):** TTR molecular evolution; title-only stub.

These works corroborate that ATTR-ACT exists, was influential, and was followed by an open-label extension showing sustained / amplified mortality benefit with earlier treatment — but they cannot substitute for the target paper's primary content.

## Cross-arm conflicts

- **Identity vs Paperclip content:** Web/API gives unambiguous identity (PMID 30145929, DOI 10.1056/NEJMoa1805689, NEJM 2018, Maurer first author, ATTR-ACT). Paperclip cannot retrieve this paper by PMID and does not surface it by title search. Identity is trusted; Paperclip content for the target is null.
- **Author-overlap risk on neighbor paper:** Sultan, Gundapaneni, and Schwartz appear as authors on both the 2017 early-stage paper and the 2018 ATTR-ACT paper. A careless synthesizer could conflate the two. They are different studies — different populations (early-stage TTR cardiomyopathy vs the broader ATTR-CM phase 3 cohort), different endpoints, different venues.
- **Long-term extension conflation risk:** Elliott et al. 2021 (PMC8763250) is the ATTR-ACT long-term extension. It is **not** the primary 2018 NEJM trial. Its mortality findings (earlier treatment > later treatment) are downstream of, not equivalent to, the original tafamidis-vs-placebo result.
- **No local PDF in this arm bundle:** Hybrid arm permits local PDF slices but none were supplied — consistent with the outside-wheelhouse held-out case framing.
- **Corpus coverage gap:** Paperclip is missing what is arguably the single most-cited cardiology trial of the late-2010s amyloidosis literature. This is the documentation-of-record finding for this case.

## Eight prompts

### 1. What is the paper's central claim / contribution?
ATTR-ACT was the pivotal phase 3, multicenter, double-blind, randomized, placebo-controlled trial of tafamidis (a transthyretin tetramer stabilizer) in patients with transthyretin amyloid cardiomyopathy (ATTR-CM, both wild-type and hereditary). Per the diagnostic claim anchors in the bundle, the paper reports the trial's effect on **all-cause mortality and cardiovascular-related hospitalization** as endpoints. The contribution is establishing the first disease-modifying pharmacotherapy for ATTR-CM in a regulatory-grade RCT. (Source: web/API identity + diagnostic anchors; body text not in bundle, so the specific magnitude of effect and the hierarchical primary endpoint formulation cannot be reported from this bundle alone.)

### 2. What is the key evidence or method?
Multicenter, double-blind, placebo-controlled randomized trial in patients with ATTR-CM, with endpoints including all-cause mortality and cardiovascular hospitalization (per the diagnostic anchors). The retrieved bundle does **not** contain the methods paragraph of the abstract, so randomization ratio, treatment doses (tafamidis 20 mg vs 80 mg), endpoint hierarchy (Finkelstein-Schoenfeld method), or duration (30 months) **cannot be sourced from this bundle**. Author/site coverage is global (collaborator list spans US, Europe, Japan, Brazil, Argentina, etc.), consistent with a large multinational phase 3 study. (Evidence basis: identity + diagnostic anchors only.)

### 3. What population / system / scope?
- **Disease:** Transthyretin amyloid cardiomyopathy (ATTR-CM) — covering both wild-type (ATTRwt) and hereditary (ATTRv/ATTRm) forms, by standard ATTR-ACT design, though the bundle's abstract is too truncated to verify the genotype split.
- **Drug:** Tafamidis (transthyretin tetramer stabilizer; oral).
- **Comparator:** Placebo.
- **Geography:** Multinational; the collaborator list visible in the bundle spans North America, Western Europe (UK, Spain, France, Germany, Netherlands, Sweden, Italy), Eastern Europe (Czech Republic, Romania), Japan, Brazil, Argentina.
- **Endpoints (per anchors):** All-cause mortality and cardiovascular hospitalization.
- The specific NYHA-class inclusion criteria, sample size (n=441 in the published trial, but **not in the bundle**), and follow-up duration cannot be verified from the available text.

### 4. What are the main results / numbers?
**Not available in this bundle.** The retrieved abstract snippet is cut off before any results paragraph. Quantitative results (hazard ratios for mortality, hospitalization rate ratios, 6MWT and KCCQ secondary-endpoint deltas, Finkelstein-Schoenfeld p-values, subgroup hazard ratios by ATTRwt vs ATTRv and NYHA class) are **not** sourced by this bundle and must not be invented. Paperclip neighbor papers reference downstream mortality findings (Elliott 2021 long-term extension) but cannot be used to back-fill the primary trial numbers.

### 5. What are the stated limitations or caveats?
**Not available.** The abstract body and discussion are not retrieved. Limitations commonly discussed for ATTR-ACT in the literature (NYHA III subgroup signal weaker than NYHA I/II, follow-up duration vs natural-history slowness of ATTR-CM, dose-pooling of 20 mg and 80 mg in primary analysis) are **not** in this bundle and cannot be reported as the authors' stated caveats.

### 6. How does this fit the broader literature?
ATTR-ACT sits at the apex of the ATTR-CM pharmacotherapy literature as the regulatory-anchoring phase 3 RCT. The Paperclip-surfaced neighbors illustrate its position in the citation network:
- **Upstream:** Sultan et al. 2017 represents the earlier-phase / early-stage tafamidis evidence base that motivated ATTR-ACT.
- **Downstream extension:** Elliott et al. 2021 (PMC8763250) reports the long-term open-label extension showing that patients randomized to tafamidis from the start had lower all-cause mortality than those who crossed over from placebo — interpreted as evidence for early treatment benefit.
- **Real-world post-licensure:** Nakamura et al. 2020 (small Japanese cohort) and the broader long-term-survival real-world literature post-date the trial.
- **Health-economics downstream:** Lau et al. 2023 takes tafamidis efficacy as established and models screening cost-effectiveness in HFpEF — only sensible because ATTR-ACT established efficacy.
The structure (one pivotal NEJM trial → extension study → real-world cohorts → screening/cost-effectiveness modeling) is the standard trajectory for a successful first-in-class therapy.

### 7. What's novel or surprising in this paper?
Cannot be assessed from this bundle beyond what the diagnostic anchors imply. By the standards of the field, the novelty would be: first phase 3 RCT to demonstrate a disease-modifying therapy for ATTR-CM with a mortality + hospitalization endpoint reaching significance — but the magnitude, the hierarchical test result, and the subgroup pattern are **not in this bundle** and cannot be detailed here.

### 8. What questions does this paper raise or leave open?
From the available evidence (identity + anchors + neighbor-paper context), the canonical open questions this paper opened — already partially addressed by downstream work surfaced in the bundle — include:
- Durability of benefit beyond the trial duration (addressed by Elliott 2021 extension, PMC8763250).
- Earlier-vs-later treatment effect (addressed by the extension's continuous-vs-crossover comparison).
- Real-world generalizability outside trial populations (addressed in part by Nakamura 2020 and other real-world cohorts).
- Screening / case-finding rationale and cost (addressed by Lau 2023 and the HFpEF-screening literature).
- The body of the original paper may also raise dose-selection (20 mg vs 80 mg), NYHA-class subgroup, and genotype-subgroup questions — but those are inferred from the field's reception, not from the bundle's retrieved text.

## Uncertainty

- **Identity:** High confidence — anchored by PubMed metadata (PMID 30145929, DOI 10.1056/NEJMoa1805689, NEJM 2018) and reinforced by the ATTR-ACT investigator collaborator list visible in the abstract snippet.
- **Trial design at the broad-strokes level (phase 3, RCT, multicenter, double-blind, ATTR-CM, tafamidis vs placebo, mortality + CV hospitalization endpoints):** High confidence — sourced from the bundle's diagnostic claim anchors.
- **Quantitative content of target paper (hazard ratios, p-values, sample size, dose arms, subgroup numbers, secondary endpoints):** **Not in bundle.** Zero confidence in any specific number derived from this bundle alone.
- **Paperclip neighbor papers:** Medium confidence on one-line summaries (single search snippets + map summaries); they are corroborative context only.
- **Local PDF:** Confirmed absent.
- **Paperclip corpus coverage on this target:** Confirmed gap — Paperclip does not have PMID 30145929 in its corpus.

## Prohibited inferences

The following should **not** be asserted from this bundle:
1. Specific quantitative results from the target paper — hazard ratios, p-values, sample size (n=441), dose split (20 mg / 80 mg), Finkelstein-Schoenfeld primary-endpoint result, 6-minute-walk-test or KCCQ deltas, NYHA-subgroup hazard ratios. **None are in the retrieved bundle.**
2. The dose-pooling analysis structure, follow-up duration (30 months), or hierarchical endpoint testing — body of abstract not retrieved.
3. The ATTRwt vs ATTRv genotype split or hereditary-vs-wild-type subgroup findings — not in bundle.
4. Specific stated limitations or discussion claims — abstract is truncated before discussion content; body text not retrieved.
5. Findings or numbers from Sultan 2017, Elliott 2021, Nakamura 2020, Lau 2023, or Phillips 2021 should not be reattributed to Maurer et al. 2018. They are neighbor / downstream works surfaced by Paperclip, not the target's content.
6. The trial's effect estimates cannot be back-filled from Elliott 2021's long-term extension; the extension reports a different (early-vs-late) contrast under a different (open-label) design.
7. Any claim that Paperclip's surfacing of five tafamidis/ATTR papers means the target is in the corpus — `lookup pmid 30145929` explicitly returned "No documents found," and no map result corresponds to PMID 30145929.
8. Funding source, sponsorship (Pfizer / FoldRx), prior FDA orphan-drug status, or regulatory-approval downstream consequences — these are not in the retrieved bundle text (only in external knowledge that the synthesizer must not import for this arm-isolated task).
