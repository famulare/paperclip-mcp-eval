---
case_id: kew-2005-opv-review
arm: local
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: kew-2005-opv-review | Arm: Local PDF

## Retrieval validity status

**Critical limitation: the evidence bundle is effectively unusable for content synthesis.**

The bundle exposes only two slices of a 52-page, 423,036-character document:

- **Head slice (~2,500 chars):** title block, author list, and institutional affiliations only. Cuts off mid-affiliation.
- **Tail slice (~700 chars):** Annual Reviews corrections-log footer and a stray "Contents ix" line — i.e., front-matter/back-matter artifacts, not body text.

No abstract, introduction, body sections, figures, tables, conclusions, references, or discussion are present in the slice. The extraction is not OCR-poor in the slice we have (the visible text is clean), but the bundle is **content-sparse to the point of being non-substantive**: ~3,200 of 423,036 characters (~0.76%) are exposed, and all of it is metadata wrapping. This appears to be a slicing/extraction artifact rather than a PDF-quality problem.

Treat every prompt below as a forced answer under near-total content blindness.

## Available context

What the slice does establish:

> "Vaccine-Derived Polioviruses and the Endgame Strategy for Global Polio Eradication"

> "Olen M. Kew,1 Roland W. Sutter,2 Esther M. de Gourville,2 Walter R. Dowdle,3 and Mark A. Pallansch1"

> "1 Division of Viral and Rickettsial Diseases, National Center for Infectious Diseases, Centers for Disease Control and Prevention, Atlanta, Georgia 30333"

> "2 World Health Organization, CH-1211, Geneva 27, Switzerland"

> "Annu. Rev. Microbiol. 2005.59:587-635"

From the bundle metadata: Annual Reviews venue, 2005, pages 587-635 (a 49-page review article), DOI 10.1146/annurev.micro.58.030603.123625, PMID 16153180. Authors are CDC (Kew, Pallansch) and WHO (Sutter, de Gourville) polio program leadership plus Walter Dowdle.

Nothing about findings, claims, evidence, or mechanisms is recoverable from the slice itself.

## 1. Central mechanistic claim

**Cannot be determined from the slice.** The title — "Vaccine-Derived Polioviruses and the Endgame Strategy for Global Polio Eradication" — implies the article concerns vaccine-derived poliovirus (VDPV) biology and its policy implications for ending OPV use, but no mechanistic claim is stated in the exposed text.

The slice does not contain an abstract, thesis statement, or framing paragraph. Any specific mechanistic claim (e.g., about OPV reversion, circulating VDPV emergence dynamics, immunodeficient excretion, or cessation strategy) would be inferred from the title alone, not from evidence in the bundle.

## 2. Evidence the article uses

**Cannot be determined from the slice.** No methods, data, figures, tables, references, or evidentiary statements are present in the exposed text. The bundle does not reveal whether the review draws on outbreak surveillance, sequencing data, modeling, serology, or program records.

## 3. Hidden detail an MCP-style summary would likely miss

**Cannot be determined from the slice.** Identifying hidden detail requires access to the body of the article. The only thing the slice itself surfaces that a citation-only summary might omit is the **mixed CDC/WHO authorship** — this is a joint eradication-program leadership review, not a pure academic synthesis. That framing matters for reading the recommendations as program-aligned rather than independent, but it is a meta-observation about provenance, not a finding from the article.

## 4. What would a domain expert notice that a generalist misses

**Cannot be determined from the slice.** No technical content is available to evaluate.

A polio-domain expert reading only the title page would note that this 2005 Kew et al. review is widely treated as the foundational VDPV classification reference (cVDPV / iVDPV / aVDPV taxonomy), and that the 587-635 page range plus the author roster signals a comprehensive program-defining review — but that is external knowledge, not content from the slice.

## 5. Most dangerous overclaim risk if the article were misread

**Cannot be determined from the slice.** Without the article's actual conclusions, the overclaim risk cannot be diagnosed from evidence. Generic risks for a 2005 endgame-strategy review (e.g., treating program-era recommendations as still-current after 20 years of subsequent VDPV experience, or treating policy proposals as established findings) are inferable from the title and date but are not grounded in the bundle.

## 6. Claims in the article not supported by its own evidence

**Cannot be determined from the slice.** No claims and no evidence are exposed. This prompt is unanswerable from the bundle.

## 7. Dependence on external literature

**Cannot be determined from the slice.** No reference list, no in-text citations, and no methods are accessible. The review is published in Annual Reviews (a synthesis venue), so by genre it is heavily dependent on external literature, but the bundle reveals no specifics about which literatures are integrated.

## 8. Connections to KB themes

**Cannot be drawn from the slice.** The title aligns with the KB's polio eradication / OPV cessation thread by topic, and the Kew/Sutter/Pallansch/Dowdle authorship places this firmly in the CDC-WHO program-science lineage that recurs across the polio KB. But no substantive connection (e.g., to a specific model, claim, or contradiction in the KB) can be supported by content from the bundle — only by the title and authorship metadata.

## Uncertainty

Uncertainty is **maximal across all eight prompts**. The bundle does not expose the article's content. Every substantive answer above is either "cannot be determined" or derived from the title/author block alone. This synthesis should not be used as a content summary of Kew 2005 under any circumstances; it documents only what the local-arm extraction made available.

If this case is meant to evaluate the local-PDF arm's ability to support synthesis, the finding is that **the slicing strategy (head + tail of a 52-page review) returns only front-matter and back-matter** and provides no body text for a long-form review article. A middle slice or section-aware extraction would be required.

## Prohibited inferences

Per the synthesizer rule, I have not consulted external knowledge to fill in the article's content. Specifically, I have **not**:

- Stated the article's actual VDPV definitions, thresholds (e.g., divergence percentages), or classification scheme
- Cited specific outbreaks, country cases, or surveillance findings the article discusses
- Attributed specific endgame-strategy recommendations (OPV cessation, IPV transition, containment) to the article
- Summarized the article's position on iVDPV chronic excretion, cVDPV emergence conditions, or aVDPV interpretation
- Listed references the article cites
- Compared the article's conclusions to subsequent literature or to KB models of OPV dynamics

All such content, even though plausibly present in the full article, is **not in the evidence bundle** and is therefore excluded from this synthesis.
