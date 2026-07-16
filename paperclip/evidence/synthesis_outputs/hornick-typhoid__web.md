---
case_id: hornick-typhoid
arm: web
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: hornick-typhoid | Arm: Live web/API

## Retrieval validity status

Retrieval succeeded at the metadata level. PubMed source-of-record fields (PMID, DOI, title, authors, journal, publication date) are present and consistent. However, this is a pre-1980 NEJM article and the abstract block from PubMed contains only the citation header — no abstract body text is available. This is expected behavior for NEJM articles of this vintage; many lack structured abstracts in PubMed.

> 1. N Engl J Med. 1970 Sep 24;283(13):686-91. doi: 10.1056/NEJM197009242831306.
>
> Typhoid fever: pathogenesis and immunologic control.
>
> Hornick RB, Greisman SE, Woodward TE, DuPont HL, Dawkins AT, Snyder MJ.

No abstract body, no MeSH terms, no keyword list, and no full-text content are included in the bundle.

## Available context

- **PMID:** 4916913
- **DOI:** 10.1056/NEJM197009242831306
- **Title:** "Typhoid fever: pathogenesis and immunologic control."
- **Authors (top 6):** Hornick RB; Greisman SE; Woodward TE; DuPont HL; Dawkins AT; Snyder MJ
- **Journal:** The New England Journal of Medicine
- **Publication date:** 1970 Sep 24 (vol. 283, no. 13, pp. 686–691)
- **Bundle-stated case context:** pre-1980 NEJM + OCR stress case; foundational reference for typhoid dose-response and challenge methodology (per scorer-reference anchors).

## 1. Central mechanistic claim

Cannot answer from web/API metadata + abstract only. The title — "Typhoid fever: pathogenesis and immunologic control" — names the topics (pathogenesis of typhoid; immunologic control) but the bundle contains no abstract body, no Results/Discussion text, and no MeSH terms. No specific mechanistic claim (e.g., dose-infection relationship, role of stomach acid, role of vaccination, gut-translocation pathway) can be extracted from the title alone without external knowledge.

## 2. Evidence

Cannot answer from web/API metadata + abstract only. No methods, sample sizes, challenge doses, attack rates, vaccine arms, or statistical results are present in the bundle. The scorer-reference anchor mentions "human challenge experiments" but that string is in the scorer notes, not in the PubMed-retrieved abstract, so it cannot be used as web-arm-derived evidence here.

## 3. Hidden detail

Cannot answer from web/API metadata + abstract only. The bundle contains no body text, so any inconspicuous-but-load-bearing methodological detail (challenge strain, inoculum vehicle, prior-vaccination status of volunteers, antibiotic-treatment endpoint, ethical framing) is unrecoverable from this arm.

## 4. Domain expert notice

A domain expert reviewing only this bundle would notice:

- The author list (Hornick, Greisman, Woodward, DuPont — all University of Maryland / Baltimore infectious-disease names associated with the mid-twentieth-century Maryland volunteer-challenge program) signals this is part of the Maryland human-challenge tradition.
- The publication venue (NEJM, 1970, a paginated short article — 6 pages) and the title pairing "pathogenesis and immunologic control" suggests a review/synthesis article rather than a primary single-experiment report.
- The absence of an abstract body is a known artifact of pre-1980 NEJM indexing, not a retrieval failure — an expert would not over-interpret the empty abstract.
- A domain expert would not be able to verify specific dose-response numbers, vaccine efficacy estimates, or attack-rate figures from this bundle alone.

## 5. Dangerous overclaim

The most dangerous overclaim a downstream consumer could make from this bundle is to attribute specific quantitative findings (e.g., "10^5 organisms cause illness in 25–50% of volunteers," specific vaccine efficacy percentages, or a defined ID50) to this paper on the basis of having "retrieved" it. The metadata confirms only that the paper exists, who wrote it, where, and when — it does not confirm any numerical or mechanistic finding. Treating the bundle as substantive evidence about typhoid biology rather than as a bibliographic stub would be a category error.

## 6. Unsupported claims

Any of the following would be unsupported by this arm's evidence:

- Specific challenge doses or ID50 estimates.
- Specific attack rates, incubation periods, or fatality figures.
- Vaccine-efficacy point estimates or comparative-arm results.
- Mechanistic claims about gastric-acid barrier, lymphatic spread, gallbladder carriage, or endotoxin tolerance.
- Claims about ethical review, informed-consent procedures, or prisoner-volunteer status of subjects.
- Any direct quotation beyond the title and author list.

## 7. External-literature dependence

To answer prompts 1–3 substantively, this arm would require either (a) the abstract body, (b) MeSH terms / keyword indexing, or (c) full-text retrieval (the DOI resolves to NEJM but the bundle does not include retrieved full text). Without those, every mechanistic or quantitative answer depends on external literature or background knowledge — which this exercise prohibits. The bundle is therefore strongly external-literature-dependent for any non-bibliographic question.

## 8. KB themes

From metadata alone, themes that this paper plausibly touches — and that intersect the evaluator's KB — include: human challenge studies as a method (relevant to current polio CHIM discussions), pathogen dose-response (foundational for transmission modeling), and the historical infectious-disease literature from the Maryland volunteer program (a methodological lineage). However, claiming the paper *substantiates* any specific KB theme requires evidence beyond what this bundle provides.

## Uncertainty

- **High confidence:** bibliographic identity of the paper (PMID, DOI, authors, journal, date, title).
- **Cannot assess from this bundle:** any substantive claim about typhoid pathogenesis, dose-response, vaccine efficacy, or experimental methodology.
- The empty abstract is a known pre-1980 NEJM indexing pattern, not evidence of a retrieval failure or a redacted paper.

## Prohibited inferences

I have not used external knowledge of the Hornick/Maryland typhoid-challenge program to fill in mechanistic content, dose-response numbers, ID50 estimates, vaccine arms, or volunteer-cohort details. Wheelhouse-status and the scorer-reference description of "human challenge experiments" and "foundational reference for typhoid dose-response" were used only to frame what is and is not answerable from the bundle — not as substantive content. No content from the diagnostic claim anchors was treated as web-arm evidence; per the synthesizer rule, those anchors are for scorers, not for arm-output sourcing.
