---
case_id: khoury-2021-natmed
arm: web
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: khoury-2021-natmed | Arm: Live web/API

## Retrieval validity status

Bundle returns authoritative PubMed metadata for the final Nature Medicine article (PMID 34002089, DOI 10.1038/s41591-021-01377-8, published 2021 Jul) and explicitly notes the existence of the medRxiv preprint (10.1101/2021.03.09.21252641, 2021). The bundle is flagged as the "canonical preprint-returned-when-final-requested case," but the metadata block itself resolves to the final version with abstract intact. Retrieval is therefore valid for the final article; preprint content is not provided.

## Available context

> PubMed source-of-record: PMID 34002089; DOI 10.1038/s41591-021-01377-8; Nat Med 2021 Jul;27(7):1205-1211; Epub 2021 May 17. Title: "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection." Authors: Khoury DS, Cromer D, Reynaldi A, Schlub TE, Wheatley AK, Juno JA, Subbarao K, Kent SJ, Triccas JA, Davenport MP. Affiliations span Kirby Institute (UNSW), University of Sydney, and the Doherty Institute (Melbourne).

> Abstract is included (fair-use snippet). Three published comments are noted: Nat Med 2021;27(7):1147-1148; EBioMedicine 2022;79:104034; Nature 2022;609(7926):232-233.

No full text, no figures, no supplementary tables, no preprint diff are available.

## 1. Central mechanistic claim

> "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection."

The paper proposes that in vitro neutralization titer, normalized to mean convalescent plasma, serves as a quantitative correlate of vaccine-induced protection against SARS-CoV-2. The mechanism is statistical/phenomenological: a dose-response relationship between (normalized) neutralizing antibody titer and protection from symptomatic infection, fit across multiple vaccine trials and convalescent cohorts.

## 2. Evidence

From the abstract:

> "we analyzed the relationship between in vitro neutralization levels and the observed protection from severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2) infection using data from seven current vaccines and from convalescent cohorts."

Quantitative anchors reported in the abstract:

> "the neutralization level for 50% protection against detectable SARS-CoV-2 infection [was estimated] to be 20.2% of the mean convalescent level (95% confidence interval (CI) = 14.4-28.4%)."

> "The estimated neutralization level required for 50% protection from severe infection was significantly lower (3% of the mean convalescent level; 95% CI = 0.7-13%, P = 0.0004)."

> "Modeling of the decay of the neutralization titer over the first 250 d after immunization predicts that a significant loss in protection from SARS-CoV-2 infection will occur, although protection from severe disease should be largely retained."

> "Neutralization titers against some SARS-CoV-2 variants of concern are reduced compared with the vaccine strain, and our model predicts the relationship between neutralization and efficacy against viral variants."

The functional form of the model (logistic/probit), trial-level data points, parameter tables, and decay-rate values are not in the abstract.

## 3. Hidden detail

Cannot answer from web/API metadata + abstract only. The abstract states a model exists ("our model predicts the relationship between neutralization and efficacy against viral variants") and that decay was modeled over 250 days, but does not specify the link function, decay half-life, weighting across the seven vaccines, handling of assay heterogeneity (different neutralization assays across trials normalized via convalescent reference), or the difference between preprint and final-version curves/parameters flagged as case-relevant in the bundle header. The preprint vs final-paper diff cannot be assessed from this arm.

## 4. Domain expert notice

A vaccinologist or quantitative immunologist would immediately notice:

1. The abstract reports two distinct EC50-equivalent thresholds (20.2% for any symptomatic infection, 3% for severe disease), and the ~7-fold gap is the load-bearing claim for the "protection from severe disease is largely retained as titers wane" inference.
2. Normalization to "mean convalescent level" is the cross-assay glue that makes seven heterogeneous trial datasets comparable; the validity of the entire correlate hinges on this normalization holding across assays.
3. The estimate is derived from cross-trial regression, not from individual-level immune-bridging data — efficacy points and mean titer points are paired per trial.
4. The presence of three published Comments (Nat Med 2021, EBioMedicine 2022, Nature 2022) signals contemporaneous expert engagement and likely critique or extension; the bundle does not provide their content.

## 5. Dangerous overclaim

The phrasing "highly predictive of immune protection" risks being read as a causal/mechanistic correlate of protection in the regulatory sense, when the abstract supports only a statistical predictor fit across population-level trial outcomes. Treating 20.2% of convalescent titer as an individual-level protective threshold — e.g., for go/no-go decisions on boosters or for waivers from efficacy trials of new vaccines — would extrapolate beyond what the abstract establishes. The model is fit at trial mean × trial efficacy granularity; individual-level protection at a given titer is an inference, not a direct measurement.

## 6. Unsupported claims

Cannot answer from web/API metadata + abstract only with confidence. Within the abstract, the only claim that approaches the edge of evidence is the variant projection — "our model predicts the relationship between neutralization and efficacy against viral variants" — which is a model extrapolation from the vaccine-strain fit using reduced variant neutralization as input; whether the abstract overstates this depends on full-text qualifiers not available here.

## 7. External-literature dependence

The work is entirely dependent on external literature: it is a meta-analytic re-use of efficacy data from "seven current vaccines" (unnamed in the abstract) plus convalescent neutralization cohorts (also unnamed). The seven vaccine trials and the assays used to measure neutralization in each are external inputs whose identities, methods, and assumptions are not surfaced in the metadata available here. The bundle also references comparison artifacts (preprint version on medRxiv; three published Comments) that bracket the paper's reception but are not retrievable from the bundle.

## 8. KB themes

Cannot answer from web/API metadata + abstract only. Mapping to the Fermi knowledge base (e.g., correlates-of-protection threads, vaccine waning models, paperclip-evaluation themes around versioned-correlate papers) requires KB content not provided in this arm.

## Uncertainty

- The bundle header flags this case as the "canonical preprint-returned-when-final-requested case" and notes "Final paper has different curves/parameters than the medRxiv preprint; version distinction matters." The metadata block delivered the final article, so the preprint-substitution failure mode is not directly observed here; whether a downstream retrieval pipeline would have returned the preprint is outside this synthesis.
- Numerical estimates (20.2%; 3%; 250-day decay window) are reported with confidence intervals in the abstract but without the underlying functional form, so I cannot independently re-evaluate them.
- Author affiliations and contribution structure (two co-first authors marked equal) are clear; per-author contributions are not.

## Prohibited inferences

- I have not stated the link function (logit/probit), decay half-life, named the seven trials, given individual-trial efficacy points, or specified assay types — none are in the abstract.
- I have not stated what changed between the medRxiv preprint and the final Nature Medicine paper — that diff is not in the bundle.
- I have not summarized the content of the three Comments — only their existence is in the metadata.
- I have not invoked external knowledge of Khoury et al., correlates-of-protection literature, or subsequent variant-era validations.
- I have not used KB content; the KB-themes prompt is answered as unavailable.
