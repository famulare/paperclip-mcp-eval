---
case_id: famulare-2018-plosbio
arm: web
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: famulare-2018-plosbio | Arm: Live web/API

## Retrieval validity status
The web/API bundle resolved authoritative bibliographic identifiers (PMID 29702638, PMCID PMC5942853, DOI 10.1371/journal.pbio.2002468) and provided the PubMed abstract plus preprint lineage (bioRxiv 10.1101/084012, 2016). Only metadata and abstract are visible; no figures, tables, supplements, methods, or registry are present. Synthesis is therefore constrained to abstract-level claims, and several evaluation prompts cannot be fully answered from this arm.

## Available context
- Supplements visible: no
- Version label identifiable: yes (PLOS Biology 2018 final; bioRxiv 2016 preprint noted)
- Trial registry context: inapplicable (modeling study, not a trial)
- Figures/tables visible: no

## Prompt 1 — Central mechanistic claim
The paper builds a multi-scale mathematical model that links within-host vaccination/waning-immunity dynamics to between-host transmission, and uses it to claim that the stability of polio eradication after OPV cessation is setting-dependent — specifically, that in high-transmission settings without population immunity, Sabin (OPV) strains become "nearly as capable of causing outbreaks as WPV."

> "we built a multi-scale mathematical model of infection and transmission calibrated to data from clinical trials and field epidemiology studies."

> "Absent population immunity, the Sabin strains from OPV will be nearly as capable of causing outbreaks as WPV."

## Prompt 2 — Evidence supporting it
From the abstract only, the claimed evidentiary basis is calibration of the model to "data from clinical trials and field epidemiology studies," with the within-host layer parameterized by vaccination effects on "shedding and oral susceptibility to infection" and the between-host layer by "sanitation and person-to-person contact patterns."

> "At the within-host level, the model describes the effects of vaccination and waning immunity on shedding and oral susceptibility to infection. At the between-host level, the model emulates the interaction of shedding and oral susceptibility with sanitation and person-to-person contact patterns to determine the transmission rate in communities."

Cannot answer further from web/API metadata + abstract only — specific datasets, sample sizes, parameter estimates, and fit diagnostics are not visible.

## Prompt 3 — Hidden detail in supplement/table/figure/appendix/protocol/SAP/registry
Cannot answer from web/API metadata + abstract only. The bundle exposes no supplements, figures, tables, appendices, or protocol; this is the canonical "supplement-heavy" case where the web/API arm is structurally blind to most of the substance.

## Prompt 4 — What would a domain expert notice that a generic summary might miss
From the abstract alone, a polio/transmission modeler would notice: (a) the framing pivots on "oral susceptibility to infection" as a distinct quantity from paralytic disease risk, implying the model tracks transmission-relevant immunity separately from clinical protection; (b) the result is stratified by transmission-rate regime (low / moderate / high), implying threshold or bifurcation behavior rather than a single global recommendation; (c) the claim that Sabin can become "nearly as capable" as WPV under low immunity implicitly invokes reversion dynamics of Sabin strains, even though the abstract does not name them. Beyond these abstract-level observations, expert-level detail cannot be answered from web/API metadata + abstract only.

## Prompt 5 — What would be dangerous to overclaim
Three over-claim hazards visible from the abstract:
1. Treating "Sabin nearly as capable as WPV" as an unconditional statement rather than a conditional one ("Absent population immunity ... in high transmission rate settings").
2. Generalizing the IPV-sufficiency conclusion ("IPV is sufficient to prevent outbreaks in low transmission rate settings") beyond the low-transmission regime it is scoped to.
3. Reading the model results as empirical observation rather than as model-based inference calibrated to trial and field data — the abstract describes a modeling synthesis, not a natural experiment.

## Prompt 6 — Which author claims are not well-supported by the data presented
Cannot answer from web/API metadata + abstract only. Adjudicating support requires the methods, calibration targets, sensitivity analyses, and figures, none of which are exposed by this arm.

## Prompt 7 — Which claims depend on external literature/assumptions/registry/expert judgment
From the abstract, the following depend on inputs external to the paper itself: (a) the "10,000-fold" historical burden reduction attributed to OPV; (b) the "clinical trials and field epidemiology studies" used for calibration (unnamed in the abstract); (c) assumed sanitation and contact-pattern structures driving between-host transmission; (d) the characterization of vaccine-derived outbreaks as historically "rare." All of these are stated as background or calibration inputs and are not internally re-derived in the abstract.

## Prompt 8 — Connection to KB themes
- Mechanistic over narrative: The paper is explicitly mechanistic — a within-host/between-host coupled model — rather than a narrative epidemiological review.
- Surveillance as measurement: Not directly addressed in the abstract; the closing sentence about "post-cessation outbreak responses" gestures at surveillance/response coupling but does not develop it at this level of visibility.
- Multi-scale modeling: Directly central. The abstract names "multi-scale mathematical model" and articulates the within-host ↔ between-host coupling that is the defining feature of this KB theme.
- Continuous immunity: Directly central. "Waning immunity," "shedding," and "oral susceptibility to infection" are continuous (not binary protected/unprotected) state variables driving transmission outcomes.

## Uncertainty
- All Prompt 2/3/6 content beyond abstract-level paraphrase is unavailable; the arm is metadata-only by construction.
- The abstract does not name the specific clinical trials or field studies used for calibration, so the empirical anchoring cannot be evaluated here.
- Threshold values separating "low," "moderate," and "high" transmission-rate settings are not visible.
- Sabin reversion dynamics are inferable from domain context but are not stated in the abstract.

## Prohibited inferences (what I refused to claim)
- I did not import the "Sabin-strain reversion dynamics" anchor from the scorer reference as if it were stated in the abstract; the abstract only implies it.
- I did not quote or characterize any figure, table, supplement, parameter value, or sensitivity analysis.
- I did not assess goodness-of-fit, identifiability, or calibration quality.
- I did not adjudicate disagreements with external literature.
- I did not infer the paper's policy recommendations beyond what the abstract explicitly states about IPV sufficiency and OPV reintroduction conditions.
