---
case_id: nigeria-2015-versioning
arm: web
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: nigeria-2015-versioning | Arm: Live web/API

## Retrieval validity status
The web/API bundle resolved authoritative bibliographic identifiers for the journal source-of-record (PMID 26317401, PMCID PMC4552877, DOI 10.1371/journal.pone.0135765) and the preprint source-of-record (arXiv:1504.02751, v1 2015-04-10, v2 2015-07-10). The PubMed abstract is present in full; the arXiv abs-page metadata is summarized (titles, authors, version dates, and a one-line note that v2 adds cVDPV2 forecast updates). No body text, figures, tables, supplements, or methods are exposed for either version. Synthesis is therefore constrained to abstract-level claims plus version-lineage metadata; several evaluation prompts cannot be answered fully from this arm. Version-lineage is the explicit point of this case and is fully resolvable at the metadata level.

## Available context
- Supplements visible: no
- Version label identifiable: yes (PLOS ONE final 2015-08-28; arXiv v1 2015-04-10; arXiv v2 2015-07-10)
- Trial registry context: inapplicable (modeling/estimation study using surveillance data, not a trial)
- Figures/tables visible: no

## Prompt 1 — Central mechanistic claim
The paper estimates the probability that poliovirus transmission has been interrupted in Nigeria as of March 31, 2015, using a transmission/detection model that accounts for the fact that paralysis-based surveillance observes only a small fraction of infections. The central mechanistic move is to combine historical incidence-rate priors with the uncertainty in transmission dynamics and detection sensitivity to produce posterior elimination probabilities by serotype.

> "This report provides estimates for the probabilities of poliovirus elimination in Nigeria given available data as of March 31, 2015. It is based on a model of disease transmission that is built from historical polio incidence rates and is designed to represent the uncertainties in transmission dynamics and poliovirus detection that are fundamental to interpreting long time periods without cases."

The headline serotype-specific estimates: P(WPV1 eliminated in Nigeria) = 84%; P(WPV3 eliminated, hence globally eradicated) > 99%; P(cVDPV2 transmission interrupted) is low at the data cutoff but rises to 83% conditional on no new cases through April 2016. A complementary forward statement: if WPV1 is not yet eliminated, "a new case will be detected with 99% probability by the end of 2015."

## Prompt 2 — Evidence supporting it
From the abstract, the evidentiary inputs are: (a) the surveillance record of paralytic cases (last WPV3 case in Nigeria in November 2012; last WPV1 case in Nigeria in July 2014; last African WPV1 case in Somalia in August 2014; last cVDPV2 case in Nigeria in November 2014); (b) historical polio incidence rates used to build the transmission model; (c) implicit knowledge of the paralysis-to-infection ratio that drives surveillance sensitivity. The conversion from "time since last case" to elimination probability is the model's job; the abstract presents these as the data inputs and frames the model as a structured way to incorporate detection uncertainty.

Cannot answer further from web/API metadata + abstract only — specific data sources, the form of the transmission model, prior distributions, likelihood structure, and fit diagnostics are not visible.

## Prompt 3 — Hidden detail in supplement/table/figure/appendix/protocol/SAP/registry
Cannot answer from web/API metadata + abstract only. No supplements, figures, tables, methods sections, or appendices are exposed. The version-lineage metadata does, however, reveal one substantive hidden detail at the meta level: arXiv v2 (2015-07-10) "adds cVDPV2 forecast updates relative to v1" (2015-04-10). This implies that the cVDPV2 component of the analysis — including the conditional "83% by April 2016" figure that appears in the final PLOS ONE abstract — was added or substantially revised between preprint versions, and is therefore a v2/journal feature, not a v1 result. Without the v1 abstract or body, the specific delta cannot be characterized further.

## Prompt 4 — What would a domain expert notice that a generic summary might miss
From the abstract plus version metadata, a polio surveillance/transmission modeler would notice: (a) the three estimands are structurally different — WPV1 and WPV3 are about confirming interruption that may already have occurred, while cVDPV2 is about an ongoing, recently-detected outbreak, so the cVDPV2 probability is conditional on a future no-case window in a way the WPV statements are not; (b) the > 99% WPV3 figure carries a global implication ("and thus global eradication") because WPV3 had not been detected anywhere globally since the same Nigeria 2012 case — this is a single-country estimate doing double duty as a global claim; (c) the 99% "new case detected by end of 2015" statement is a posterior-predictive surveillance statement, useful as an operational test of the model's own elimination hypothesis; (d) the data cutoff (March 31, 2015) sits between v1 (April 10, 2015) and v2 (July 10, 2015), so v2 incorporates ~3 months of additional surveillance without moving the nominal cutoff — the cVDPV2 update is the most plausible substantive change. Beyond these abstract-and-metadata-level observations, expert detail cannot be answered from web/API metadata + abstract only.

## Prompt 5 — What would be dangerous to overclaim
Four over-claim hazards visible from the abstract and version metadata:
1. Reading "P(WPV1 elimination) = 84%" as a confident declaration of interruption rather than as a probability with substantial residual uncertainty; the abstract itself supplies the falsification test (a new case by end of 2015 with 99% probability if not eliminated).
2. Treating the cVDPV2 "83%" number as unconditional. The abstract conditions it on "if no new cases are detected by April 2016" — it is a forward conditional, not a current estimate.
3. Citing the paper as a single 2015 result without acknowledging the version lineage: the cVDPV2 forecast was a v2/journal addition relative to arXiv v1, so citations of the cVDPV2 numbers should anchor on v2 or the PLOS ONE version, not v1.
4. Extending the > 99% WPV3 global-eradication probability to wild poliovirus as a whole or to vaccine-derived strains; the abstract is explicit that WPV1 status and cVDPV2 status are separate, less certain estimands.

## Prompt 6 — Which author claims are not well-supported by the data presented
Cannot answer from web/API metadata + abstract only. Adjudicating support for the 84% / > 99% / 83% probability estimates requires the model specification, priors, likelihood, sensitivity analyses, and goodness-of-fit assessments, none of which are exposed by this arm.

## Prompt 7 — Which claims depend on external literature/assumptions/registry/expert judgment
From the abstract, the following depend on inputs external to the paper itself or on modeling assumptions not internally re-derived: (a) "historical polio incidence rates" used to build the transmission model — an external empirical input; (b) the paralysis-to-infection ratio implicit in the surveillance-sensitivity argument — a domain-standard parameter, not stated in the abstract; (c) the global-eradication implication of the WPV3 estimate depends on surveillance evidence from outside Nigeria, which is acknowledged in the abstract ("WPV3 has not been seen anywhere since the last case ... in Nigeria in November 2012") but not modeled here; (d) the WPV1 African-elimination question depends on Somalia surveillance ("WPV1 has not been seen in Africa since a case in Somalia in August 2014"), which is treated as background fact rather than re-estimated.

## Prompt 8 — Connection to KB themes
- Mechanistic over narrative: The paper is structurally mechanistic — it converts observed silence on surveillance into an elimination probability via an explicit transmission/detection model, rather than narrating the epidemiological situation.
- Surveillance as measurement: Directly central. The whole premise is that "polio surveillance is based on paralysis and paralysis only occurs in a small fraction of infections," so absence of cases is informative only when modeled against detection sensitivity. This is the paradigmatic surveillance-as-measurement statement.
- Multi-scale modeling: Not the primary frame of this paper at abstract level; the model is described as a transmission model with detection uncertainty, not a within-host/between-host coupled model.
- Continuous immunity: Not addressed in the abstract.
- Version lineage / provenance: Directly central to this case. The arXiv v1 -> v2 -> PLOS ONE chain, with v2 adding cVDPV2 forecast updates, is itself a KB-relevant pattern about how scientific claims migrate and accrete between preprint and journal versions.

## Uncertainty
- All Prompt 2/3/6 content beyond abstract-level paraphrase and version-metadata summary is unavailable; the arm is metadata-only by construction.
- The specific delta between arXiv v1 and v2 is summarized only as "adds cVDPV2 forecast updates"; the precise scope (new estimand, revised numbers, new sensitivity analysis, or all of the above) cannot be resolved from the bundle.
- The model class (deterministic vs. stochastic, Bayesian vs. frequentist, branching-process vs. compartmental) is not stated in the abstract.
- The data cutoff (March 31, 2015) is named, but the exact data sources (e.g., AFP surveillance, environmental surveillance) are not.
- The relationship between this paper and any companion ground-truth posterior assessments (i.e., what actually happened in Nigeria after 2015) is outside the bundle.

## Prohibited inferences (what I refused to claim)
- I did not import the "models WPV elimination probability given surveillance sensitivity in Nigeria" diagnostic anchor as if it were a quote from the abstract; it appears in scorer reference only. The abstract phrasing supports an equivalent claim, but the diagnostic-anchor wording is not lifted.
- I did not characterize the specific contents of arXiv v1 beyond what the bundle states ("v2 adds cVDPV2 forecast updates relative to v1"); I did not claim the v1 abstract said X or did not say X.
- I did not quote or characterize any figure, table, supplement, parameter value, prior distribution, posterior distribution, or sensitivity analysis.
- I did not assess identifiability, calibration quality, or model adequacy.
- I did not adjudicate against subsequent events (e.g., the 2016 Borno WPV1 detections) — that would require knowledge outside the bundle.
- I did not infer authorial intent for the v1 -> v2 revision beyond the one-line note in the bundle.
