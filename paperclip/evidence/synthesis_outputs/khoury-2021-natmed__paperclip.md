---
case_id: khoury-2021-natmed
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: khoury-2021-natmed | Arm: Paperclip MCP

## Retrieval validity status

**Target requested:** Khoury et al., *Nature Medicine* 2021 — DOI `10.1038/s41591-021-01377-8`, PMID `34002089`, medRxiv `10.1101/2021.03.09.21252641`.

**Status: RETRIEVAL FAILED in multiple senses.**

1. **Direct lookups returned nothing.** Both lookup paths failed:

   > `# command: lookup doi 10.1038/s41591-021-01377-8`
   > `No documents found.`

   > `# command: lookup pmid 34002089`
   > `No documents found.`

   The final *Nature Medicine* paper (the requested artifact) is not in Paperclip's corpus under either canonical identifier.

2. **Title search surfaced the medRxiv PREPRINT, not the final paper.** The title query returned the Khoury paper as hit #2:

   > `2. What level of neutralising antibody protects from COVID-19?`
   > `David S Khoury, Deborah Cromer, Arnold Reynaldi, Timothy E Schlub, Adam K Wheatley, Jennifer A Juno,...`
   > `med_3287fa4e6d00 · medRxiv · 2021-03-09`
   > `https://doi.org/10.1101/2021.03.09.21252641`

   The `med_` prefix, the `medRxiv` source label, the 2021-03-09 date, and the `10.1101/...` DOI all confirm this is the **preprint**, not the *Nature Medicine* article requested. **Wrong-version-returned: FLAGGED.**

3. **Top-1 hit is a different paper entirely.** The #1 title-search hit (`med_19bd1cbe73d5`) is "Level and duration of IgG and neutralizing antibodies to SARS-CoV-2 in children with symptomatic or asymptomatic SARS-CoV-2 infection" by Khaitan et al., medRxiv 2022-04-12 — a pediatric serology paper unrelated to Khoury 2021. The title-search "best match" is wrong; identity must be checked, not assumed.

4. **All deep-probe commands target the WRONG paper.** The `ls` and `wc` commands operate on `/papers/med_19bd1cbe73d5/` (the Khaitan children's paper), not on `med_3287fa4e6d00` (the Khoury preprint). The 178-line content.lines body summarized in `wc.txt` is from the Khaitan paper.

5. **Map is contaminated.** `map --from s_bff83ef1 -n 1` was issued, but the output contains results from **all 5 papers** in the underlying search session — not 1. This is the documented Paperclip bug that `-n 1` does not honor the limit. Map output therefore mixes claims from at least 5 different papers (Khaitan children's serology, Khoury preprint, an arXiv paper-based test paper, a Khoury 2023 correlates-of-protection review, and a Chinese symptomatic/asymptomatic follow-up study).

**Net:** Paperclip cannot answer questions about Khoury 2021 *Nature Medicine*. The closest surrogate present is the preprint (`med_3287fa4e6d00`), but no deep content from that record was actually retrieved — only the 2-sentence search-result blurb and a contaminated map line.

## Available context

What Paperclip actually produced about the Khoury preprint surrogate:

- **Search blurb** (`search_title.txt`):

  > "This study modeled the relationship between in vitro neutralisation levels and observed protection from COVID-19. Neutralisation level is highly predictive of protection, with 50% protection from infection estimated at 20% of convalescent levels."

- **One contaminated map line** (`map_n_probe.txt`):

  > `[success] What level of neutralising antibody protects from COVID-19?  (med_3287fa4e6d00)`
  > `The central claim of this paper is that neutralisation level is highly predictive of immune protection against SARS-CoV-2 (L14). Specifically, the aut[...]`

  The line is truncated mid-word ("the aut"). The only line citation given is `L14`.

- **No section access, no figures, no methods text, no full-content lines** were retrieved for `med_3287fa4e6d00`. The deep probes (`ls`, `wc`) went to the wrong paper.

That is the entirety of the usable, in-bundle, paper-identity-confirmed context.

## 1. Central mechanistic claim

From the map line for `med_3287fa4e6d00` (preprint surrogate):

> "The central claim of this paper is that neutralisation level is highly predictive of immune protection against SARS-CoV-2 (L14)."

From the search blurb:

> "Neutralisation level is highly predictive of protection, with 50% protection from infection estimated at 20% of convalescent levels."

So the central claim, per Paperclip's outputs, is: **in vitro neutralising antibody titer is a strong quantitative predictor of clinical protection from symptomatic SARS-CoV-2 infection, with 50% protection occurring near 20% of the mean convalescent neutralisation level.**

No mechanism for *why* this dose-response holds is recovered — only the empirical/modeled relationship.

## 2. Evidence

Paperclip surfaced essentially no evidence in this bundle. What is present:

- The search blurb describes the design at the highest level: "This study modeled the relationship between in vitro neutralisation levels and observed protection from COVID-19."
- A single line reference `L14` in the map output.

No data, no effect sizes beyond the "50% protection at ~20% of convalescent" point estimate, no confidence intervals, no list of vaccines/studies included, no fitting procedure, no severe-disease threshold, and no waning-projection numbers. The full-content lines of the preprint were never opened, because `ls` and `wc` were misdirected to the Khaitan pediatric paper.

## 3. Hidden detail

**None recoverable from the bundle.** "Hidden details" (caveats, exclusions, sensitivity analyses, supplementary findings) typically live in methods/discussion/supplements. None of those were accessed for the Khoury preprint. Paperclip's `supplements/` was listed only for the wrong paper (`med_19bd1cbe73d5`), and even there the bundle warns:

> "Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines."

So no claim about hidden details can be sourced.

## 4. Domain expert notice

What a vaccine-immunology / correlates-of-protection expert would immediately want to see — and what Paperclip did **not** surface:

- Which efficacy trials (which vaccines, which convalescent cohorts) were pooled into the model.
- How neutralisation titers from different assays were normalised onto a common scale (the central technical move of the paper).
- The estimated threshold for protection against **severe** disease versus any symptomatic infection (the latter is the only number quoted).
- The decay/waning model and projected duration of protection.
- The implication for variants / boosting (downstream from the model).

The expert would also notice that Paperclip returned the **preprint** (medRxiv, 2021-03-09) rather than the peer-reviewed *Nature Medicine* version, which differs in figures, exact numerical estimates, and added analyses. That distinction matters substantively for citing the paper and is invisible from the map output alone.

## 5. Dangerous overclaim

No dangerous overclaim was generated by Paperclip in this bundle. The risk in this case is **the opposite**: the map results list five "successes," and a careless reader could conflate the five papers' claims (children's serology, Khoury 2021 preprint, paper-based assay, Khoury 2023 correlates review, Chinese follow-up cohort) into a single "what Paperclip says about Khoury 2021." That conflation would itself be a dangerous attribution error — not an empirical overclaim within the paper, but a sourcing overclaim *about* the paper. The bundle's "contaminated map" warning is exactly this hazard.

## 6. Unsupported claims

Paperclip's surfaced one-line claim is consistent with what is publicly known about Khoury 2021 — but **within this bundle alone, every quantitative element is unsupported**: there is no methods text, no figure, no data table, no confidence interval, and no in-paper line citation beyond a single `L14` token. The "50% at ~20% convalescent" figure appears only in a generated search blurb and cannot be traced inside the bundle to a specific passage of the paper. Treat all numerics as unverified-against-source.

## 7. External-literature dependence

To say anything beyond the one-line summary, the synthesizer would have to import outside knowledge of:

- The Khoury 2021 modeling framework (logistic dose-response on log-neutralisation).
- Which seven (or eight, depending on version) vaccine efficacy studies were used.
- The convalescent-normalisation procedure.
- Subsequent literature (Cromer 2022 on variants; Khoury 2023 correlates review — which *is* in the search results as `PMC9881762` but was not opened).

The instructions forbid this. So everything beyond Section 1's one-sentence claim is **out of reach using only this bundle**.

## 8. KB themes

Reading only the bundle, the themes that can be legitimately surfaced are narrow:

- **Correlates of protection as a quantitative bridge** — the core idea that an in vitro biomarker (neutralisation titer) can be calibrated against clinical outcomes across heterogeneous trials. (Surfaced in the map line and the title of the Khoury 2023 paper that also appears in the search session.)
- **Cross-study normalisation** — implicitly required to compare neutralisation titers across assays; this is what the PMC9881762 review explicitly later does, but the preprint surrogate's text is not opened.
- **Asymptomatic vs symptomatic immunity** — appears in two contaminating papers in the map output (Khaitan; Cui et al.). This theme is **not** legitimately attributable to Khoury 2021 from this bundle.

KB-level connections to immunobridging, variant escape, waning, and boosting cannot be drawn from the bundle content.

## Uncertainty

- It is **certain** that Paperclip did not return the final *Nature Medicine* paper: both ID lookups returned "No documents found," and the only Khoury-authored 2021 record in the search was the medRxiv preprint.
- It is **certain** that the `ls`/`wc` probes were aimed at the wrong paper (`med_19bd1cbe73d5` = Khaitan pediatric serology), so any inference drawn from those probes about Khoury 2021 would be sourcing-error.
- It is **certain** that the `-n 1` map call returned 5-paper output (documented Paperclip bug).
- It is **uncertain** whether the preprint and final paper differ materially in the headline "50% at ~20% convalescent" number; the bundle gives no way to check.
- It is **uncertain** whether deeper content of `med_3287fa4e6d00` exists in Paperclip's corpus and would have been accessible had the operator pointed `ls`/`wc` at the correct paper-ID.

## Prohibited inferences

The following must **not** be made from this bundle:

1. Do not attribute claims from the four contaminating map hits (Khaitan, Eryilmaz, Khoury 2023, Cui) to Khoury 2021.
2. Do not treat the `wc`/`ls` output for `med_19bd1cbe73d5` as describing Khoury 2021's structure — it describes a different paper.
3. Do not claim Paperclip "retrieved" the *Nature Medicine* paper. It did not; it surfaced the preprint as a search hit and did not open it.
4. Do not invent methods, vaccine list, severe-disease threshold, waning model, or any numeric estimate beyond the single "~20% of convalescent → 50% protection" point that appears in the search blurb — none of these are sourced in the bundle.
5. Do not assume the empty `supplements/` directory (listed for the wrong paper) implies absence of supplementary material for Khoury 2021.
6. Do not assume that because the title-search top-1 had the highest rank it was the correct paper — it was not.
