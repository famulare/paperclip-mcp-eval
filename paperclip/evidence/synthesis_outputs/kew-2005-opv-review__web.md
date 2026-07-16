---
case_id: kew-2005-opv-review
arm: web
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: kew-2005-opv-review | Arm: Live web/API

## Retrieval validity status

Valid retrieval. PubMed source-of-record matches the requested identifiers:

> **PMID:** 16153180
> **DOI:** 10.1146/annurev.micro.58.030603.123625
> **Title:** Vaccine-derived polioviruses and the endgame strategy for global polio eradication.
> **Authors (top 6):** Kew OM; Sutter RW; de Gourville EM; Dowdle WR; Pallansch MA
> **Journal:** Annual review of microbiology
> **Pub date:** 2005

Abstract (fair-use snippet) is present. Diagnostic claim anchors are scorer-only and not used as evidence below.

## Available context

The web/API arm provides:
- Authoritative bibliographic metadata (PMID, DOI, title, authors, journal, year, citation `Annu Rev Microbiol. 2005;59:587-635`).
- Author affiliation: Division of Viral and Rickettsial Diseases, National Center for Infectious Diseases, CDC, Atlanta.
- The published abstract.

No full text, no figures, no tables, no methods/section content. Synthesis is bounded by abstract-level claims.

## Prompt 1. Central mechanistic claim

The abstract's central mechanistic claim is that OPV's attenuated phenotype rests on a small number of substitutions that frequently revert during replication in humans, and this reversion is the underlying cause of vaccine-associated and vaccine-derived disease.

> "The live, attenuated oral poliovirus vaccine (OPV) ... is genetically unstable. Reversion of the small number of substitutions conferring the attenuated phenotype frequently occurs during OPV replication in humans and is the underlying cause of the rare cases of vaccine-associated paralytic poliomyelitis (VAPP) in OPV recipients and their close contacts."

A second mechanistic-strategic claim is that this genetic instability produces two additional adverse-event categories — long-term VDPV excretion in primary immunodeficient persons, and circulating VDPV (cVDPV) outbreaks in low-coverage areas — which jointly define the endgame problem.

> "two other adverse events have been identified more recently: (a) long-term excretion of highly evolved vaccine-derived polioviruses (VDPVs) in persons with primary immunodeficiencies, and (b) polio outbreaks associated with circulating VDPVs in areas with low rates of OPV coverage."

## Prompt 2. Evidence

This is a review article, not primary data; the abstract does not enumerate evidence. From the abstract alone the supporting evidence is asserted rather than shown:

> "Reversion of the small number of substitutions conferring the attenuated phenotype frequently occurs during OPV replication in humans..."
> "two other adverse events have been identified more recently..."

Cannot answer from web/API metadata + abstract only for any quantitative evidence (substitution counts, reversion rates, case counts, outbreak sizes, immunodeficient excretor durations). Those would live in the full text, which this arm does not have.

## Prompt 3. Hidden detail

Cannot answer from web/API metadata + abstract only. "Hidden detail" presupposes access to body text where small but consequential mechanistic specifics (e.g., specific attenuating sites in Sabin 1/2/3, recombination dynamics, definitions of VDPV by divergence thresholds, surveillance windows, the cVDPV/iVDPV/aVDPV taxonomy distinctions) would appear. The abstract names the categories at the highest level only and does not enumerate the iVDPV / cVDPV / aVDPV classification, divergence cutoffs, or recombination mechanisms.

## Prompt 4. Domain expert notice

A polio domain expert reading only this metadata + abstract would notice:
- The abstract frames the endgame around three risks: VAPP, iVDPV, cVDPV — but uses only the umbrella term VDPV and does not in the abstract distinguish iVDPV / cVDPV / aVDPV by name, nor mention ambiguous (aVDPV) VDPVs.

> "(a) long-term excretion of highly evolved vaccine-derived polioviruses (VDPVs) in persons with primary immunodeficiencies, and (b) polio outbreaks associated with circulating VDPVs in areas with low rates of OPV coverage."

- The framing "as the global eradication of wild poliovirus nears" is a 2005 vantage point; the cVDPV problem is described as recently identified, consistent with the post-Hispaniola-2000 / Egypt era. Recombination with non-polio enteroviruses, the role of intestinal mucosal immunity, and IPV's role in the endgame are not mentioned in the abstract.

> "Developing a posteradication strategy to minimize the risks of VDPV emergence and spread has become an urgent WHO priority."

- Author lineup (Kew, Sutter, de Gourville, Dowdle, Pallansch) is the CDC/WHO polio molecular-epidemiology core circa 2005 — a strong signal that the review is authoritative for VDPV classification but written from the eradication-program perspective.

## Prompt 5. Dangerous overclaim

From abstract alone, no dangerous overclaim is evident. The abstract is appropriately hedged ("rare cases," "more recently identified," "urgent WHO priority"). A reader could over-read "the underlying cause" as if reversion at a few sites is fully sufficient — whereas in OPV2 the picture also involves recombination and intestinal immunity dynamics — but the abstract does not itself overclaim; it just compresses. Cannot answer from web/API metadata + abstract only whether the full text overreaches.

## Prompt 6. Unsupported claims

From abstract alone, no claims appear unsupported by the article's own framing — every assertion is qualitative and bounded ("frequently," "rare," "small number of substitutions"). The abstract makes no numerical, comparative, or causal claim that the abstract itself does not also frame as established knowledge or as the article's subject. Cannot answer from web/API metadata + abstract only for any claim made in the body of the review.

## Prompt 7. External-literature dependence

High. The abstract is a stand-alone summary of a review article; the actual content (mechanistic details, surveillance data, outbreak case studies, the VDPV taxonomy and divergence thresholds, recombination findings, immunity correlates) lives in the 49-page body (`pp. 587-635`) and in its cited primary literature. Anything beyond "OPV reverts, VAPP exists, iVDPV and cVDPV are the two newer adverse events, endgame strategy is needed" requires external literature.

## Prompt 8. KB themes

Cannot answer from this arm's evidence. The web/API arm is arm-isolated and does not have access to the Fermi KB. The bundle contains only PubMed metadata + abstract. Connections to KB themes (e.g., Famulare 2018 OPV2 cessation modeling, polio endgame transmission, IPV/bOPV switch, nOPV2) cannot be made from within this arm without violating arm isolation.

## Uncertainty

- Abstract-only synthesis: any prompt requiring body-text content is bounded by "Cannot answer from web/API metadata + abstract only." This is the dominant uncertainty.
- The abstract uses the umbrella "VDPV" — whether the body text formalizes the iVDPV / cVDPV / aVDPV taxonomy with divergence thresholds is plausible but not confirmable from this arm.
- "Frequently occurs" and "small number of substitutions" are unquantified in the abstract.
- Whether recombination with non-polio enteroviruses, intestinal mucosal immunity, and IPV's posteradication role are addressed in the full review cannot be determined from the abstract.

## Prohibited inferences

- The scorer-only "Diagnostic claim anchors" section (cVDPV/iVDPV/aVDPV classification by epidemiologic context, review-not-primary-data framing) was not used as evidence; per instructions it is the scorer's key, not the synthesizer's source. (It is, however, consistent with what the abstract gestures at.)
- No use of trained-prior knowledge about polio molecular epidemiology beyond what the abstract states. Specific reversion sites (e.g., domain V of the 5' UTR, VP1 sites), Sabin recombination patterns, the standard >=1% VP1 divergence threshold for VDPV definition, the Hispaniola 2000 outbreak, and post-2016 OPV2 cessation events are not in the abstract and are not asserted here as findings of this article.
- No KB cross-referencing performed; arm isolation preserved.
- No inference about the article's quantitative content, figures, tables, or specific cited studies — none are visible in this arm.
