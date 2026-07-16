---
case_id: khoury-2021-natmed
arm: hybrid
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: khoury-2021-natmed | Arm: Hybrid

## Retrieval validity status

**PARTIAL / ARM CONFLICT — wrong version returned.**

- Web/API identity (ground truth): **final Nature Medicine version**, DOI 10.1038/s41591-021-01377-8, PMID 34002089, Khoury DS et al., *Nature Medicine* 27(7):1205–1211, published 2021 Jul (Epub 2021 May 17), titled "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection."
- Paperclip `lookup doi 10.1038/s41591-021-01377-8` → **No documents found**.
- Paperclip `lookup pmid 34002089` → **No documents found**.
- Paperclip `search -t` and `map --from s_bff83ef1` instead returned the **medRxiv preprint**: med_3287fa4e6d00, "What level of neutralising antibody protects from COVID-19?", Khoury DS et al., medRxiv 2021-03-09, DOI 10.1101/2021.03.09.21252641.
- The preprint has a different title and (per ground truth's diagnostic anchor) different curves/parameters than the final paper.
- No `content.lines` or section excerpts from the preprint record were retrieved in this bundle; only a one-sentence map-probe gist and a search-result blurb.
- No local PDF slice is attached for this hybrid bundle.

Net: identity is anchored to the **final paper** via web/API; content evidence available is a thin gist of the **preprint**, which is a related-but-distinct version.

## Available context

1. **Web/API identity (authoritative for identity only):** PubMed/Nature Medicine final-paper metadata + fair-use abstract snippet of the final paper (Section 1 of the bundle).
2. **Paperclip content (preprint version, thin):**
   - Search blurb (preprint): "modeled the relationship between in vitro neutralisation levels and observed protection from COVID-19. Neutralisation level is highly predictive of protection, with 50% protection from infection estimated at 20% of convalescent levels."
   - Map-probe gist of preprint: "neutralisation level is highly predictive of immune protection against SARS-CoV-2 (L14)" (truncated).
   - Filesystem markers: a different paper's directory listing (`med_19bd1cbe73d5`, 178-line content) was shown, but that is the Khaitan/children paper, not Khoury. No `ls` or `wc` on the preprint record's content.lines was performed.
3. **Local PDF:** none in this arm.

## Cross-arm conflicts

- **Identity vs. retrieval mismatch (primary conflict):** Web/API ground truth is the final Nature Medicine paper; Paperclip returned only the medRxiv preprint when the final-paper DOI/PMID were looked up. The lookup returning "No documents found" while the title search returns the preprint is itself a signal that the final version is not indexed in this Paperclip corpus.
- **Title divergence:** Final-paper title is "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection." Preprint title is "What level of neutralising antibody protects from COVID-19?" An arm-isolated answer based only on Paperclip would mis-title the work.
- **Parameter risk:** Ground-truth diagnostic anchor explicitly warns "Final paper has different curves/parameters than the medRxiv preprint; version distinction matters." The 20% / 50%-protection figure from the preprint blurb may not match the final paper's reported 20.2% (95% CI 14.4–28.4%) precisely, and the preprint may lack the final paper's severe-disease threshold (3%; 95% CI 0.7–13%), 250-day decay modeling, and variant-of-concern extension.
- **Sibling-paper noise:** Paperclip's `map -n 1` (n flag not honored) returned five unrelated/peripheral papers including a children's antibody study (Khaitan), a paper-based serology test, and Khoury 2023 EID — none of which are this paper.

## Eight prompts

### 1. Central mechanistic / empirical claim of THIS paper

From web/API identity (final paper, authoritative): The paper models the quantitative relationship between in vitro SARS-CoV-2 neutralizing antibody levels (normalized to mean convalescent level) and observed vaccine efficacy across seven vaccines plus convalescent cohorts, finding that neutralization level is highly predictive of protection from symptomatic infection. Key numerical claims: 50% protection from detectable infection at **20.2% of mean convalescent level (95% CI 14.4–28.4%)**; 50% protection from severe disease at **3% (95% CI 0.7–13%, P=0.0004)**. The model extends to predict efficacy decay over ~250 days post-immunization and efficacy against variants of concern from their reduced neutralization titers.

The Paperclip-returned preprint expresses the same qualitative central claim ("neutralisation level is highly predictive of immune protection") with the 20%-of-convalescent estimate, but the gist does not surface the severe-disease threshold, decay timeline, or variants-of-concern extension that are in the final-paper abstract.

### 2. Evidence cited (in this bundle)

- Final-paper abstract (web/API): "data from seven current vaccines and from convalescent cohorts"; in vitro neutralization assays normalized to mean convalescent titer; logistic relationship between titer and observed protection; decay modeling over the first 250 days post-immunization.
- Paperclip preprint blurb: "modeled the relationship between in vitro neutralisation levels and observed protection from COVID-19" with the 50%-protection-at-20%-convalescent figure.
- No tables, figures, methods text, supplementary material, or section excerpts were retrieved from the Paperclip record. The retrieved content.lines (178 lines) belonged to a different paper (med_19bd1cbe73d5, Khaitan children paper), not the Khoury preprint.

### 3. Hidden / surprising detail

None recoverable from this bundle. No methods, figures, equations, or supplements from either the final paper or the preprint were retrieved beyond abstract/blurb-level summaries. Anything claimed here as "hidden" would be invention.

### 4. Domain-expert notice

A correlates-of-protection or vaccine-modeling specialist would, from the available evidence, flag:

- **Version sensitivity is operationally important.** Final-paper numbers (20.2% for infection, 3% for severe disease, with stated CIs) became reference values cited in correlates-of-protection literature; preprint values may differ slightly. Citing the preprint as if it were the published Nature Medicine paper is a real-world error pattern.
- **The 50% protection thresholds are the headline regulatory-relevant numbers** — i.e., the curve location, not just its existence.
- **Severe disease vs. detectable infection thresholds differ ~6–7×** (3% vs. 20.2%), and that gap is a substantive policy lever; the preprint blurb in this bundle does not surface that gap.
- **Cross-trial normalization to mean convalescent titer** is the methodological move that lets vaccines on different neutralization assays be plotted on one curve — its validity rests on assay calibration that the bundle does not show.

### 5. Most dangerous over-claim risk

The most dangerous over-claim available in this bundle is **conflating the preprint with the final paper** and reporting preprint numbers / framing as the published Nature Medicine result. Specifically: stating "Khoury et al., Nature Medicine 2021, found 50% protection at ~20% convalescent titer" while citing only the preprint blurb risks attaching the final paper's citation weight (and its more precise 20.2% with 14.4–28.4% CI, plus the 3% severe-disease threshold) to evidence that came from the earlier version.

A secondary danger: treating the logistic-curve relationship as causal/mechanistic protection by neutralizing antibodies. The paper's claim is **correlative and predictive** ("highly predictive"), not a demonstration that neutralizing antibodies are the mechanism of protection; T-cell and other immune components are not ruled out.

### 6. Claims this output would make that are NOT supported by the bundle

If a synthesizer claimed any of the following, they would exceed the bundle:

- Specific final-paper effect sizes beyond what is in the web/API abstract (e.g., precise hazard ratios, specific vaccine-by-vaccine fit residuals, exact decay half-lives in days).
- Methods specifics (which neutralization assays, how titers were harmonized across labs, exact statistical model form).
- Any figure, table, or supplement contents.
- Which variants of concern were modeled and their estimated efficacy losses.
- Author-level claims about subsequent revisions between preprint and final paper.

The bundle supports only abstract-level identity facts for the final paper and a one-sentence gist for the preprint.

### 7. External-literature dependence

Answering the eight prompts from this bundle alone requires:

- **External (web/API) identity metadata** to know which paper is the target (Paperclip alone returned the preprint and would have mis-identified the work as the medRxiv version).
- **External knowledge of preprint-vs-final-paper conventions** to recognize that the medRxiv record is a prior version, not a different paper.
- Without external context, a synthesizer working from Paperclip alone could not confirm the final-paper title, journal, page numbers, or the severe-disease 3% threshold.

### 8. KB themes this paper connects to (from the bundle)

Evidence in the bundle is too thin to support cross-KB theme claims without invention. The closest legitimate connections derivable from the abstract are:

- **Correlates of protection / immunobridging** (the abstract explicitly motivates the work as identifying correlates for future vaccine deployment; a 2023 Khoury follow-up on immunobridging was returned as a sibling result, indicating this is a recurring research thread).
- **Quantitative immunology / dose-response modeling** (logistic relationship between titer and efficacy).
- **Waning immunity and variant escape** (decay over 250 days; reduced neutralization vs. variants of concern).

No KB-internal theme matching was performed; these are themes inside the paper's own abstract.

## Uncertainty

- **High certainty** on the final paper's identity (PMID, DOI, journal, title, author list, abstract content) — anchored to web/API ground truth.
- **High certainty** that Paperclip returned the preprint (med_3287fa4e6d00) and not the final paper (lookup-by-DOI and lookup-by-PMID both returned "No documents found").
- **Medium certainty** that the preprint's quantitative claims align qualitatively with the final paper but differ in specific numbers — ground truth flags this explicitly; the bundle does not contain the preprint's full numbers to compare.
- **Low certainty / unknown** on any content-level detail beyond the final-paper abstract: methods, figures, supplements, specific vaccines included, exact decay half-life, variant-specific estimates.
- **Operational note:** `lookup` failures coupled with `search -t` success suggest the final-paper record is not in the Paperclip corpus at all (not merely mis-indexed); the corpus appears to contain the medRxiv preprint as the sole Khoury 2021 record.

## Prohibited inferences

This synthesis must NOT:

- Quote or paraphrase final-paper body text, methods, figures, tables, or supplements — none were retrieved.
- Quote preprint body text beyond the one-sentence blurb and truncated map gist provided.
- Assert specific numerical differences between preprint and final paper (only that ground truth flags differences exist).
- Identify which seven vaccines were analyzed.
- State which variants of concern were modeled or their predicted efficacies.
- Infer authorship dynamics, peer-review changes, or revision history between versions.
- Treat the Khaitan children paper (med_19bd1cbe73d5), Eryilmaz paper-based serology paper, Khoury 2023 EID immunobridging paper, or Cui symptomatic/asymptomatic paper as evidence about THIS paper — they were retrieval noise from the unhonored `-n 1` flag.
- Cite the final paper as the source for any quantitative claim drawn from the preprint blurb without explicit version flagging.
