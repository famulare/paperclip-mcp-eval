---
case_id: hornick-typhoid
arm: asta
synthesizer: Claude Opus 4.8
---

# Synthesis: hornick-typhoid | Arm: Asta

## Retrieval validity

The bundle resolves a specific paper by PMID. `get_paper` for `PMID:4916913` returned `"status": OK` with a matching identity block: `"title": "Typhoid fever: pathogenesis and immunologic control."`, `"venue": "New England Journal of Medicine"`, `"year": 1970`, `"publicationDate": "1970-09-24"`, `journal` `"volume": "283 13"` / `"pages": "686-91"`, and cross-IDs `"DOI": "10.1056/NEJM197010012831406"`, `"PubMed": "4916913"`, `"CorpusId": 19324387`. So identifier resolution succeeded.

However, there is **no body text and no abstract**. `get_paper` reports `"isOpenAccess": false`, `openAccessPdf.status": "CLOSED"`, and `"abstract": null`, with the disclaimer that `"The following paper fields have been elided by the publisher: {'abstract'}"`. The `snippet_search` call (`query: "typhoid fever pathogenesis immunologic control challenge dose"`, `paper_ids: "PMID:4916913"`) returned `"data": []`. Per the Asta arm caveat, an empty snippet result means the paper's full text is not in Asta's snippet index and should be treated as "no body-text evidence available," not evidence of absence in the paper. Consequently, only metadata is available; all content-level prompts are unanswerable from this bundle.

## Prompt 1 — Central mechanistic claim

Cannot answer from this arm's evidence. The only content-bearing surface is the title, `"Typhoid fever: pathogenesis and immunologic control."`, and the venue/year (`NEJM`, `1970`). The title names the paper's topic (pathogenesis and immunologic control of typhoid fever) but states no specific mechanistic or empirical claim. The abstract is `null` (elided by the publisher) and `snippet_search` returned `"data": []`, so no claim text is present in the bundle.

## Prompt 2 — Evidence supporting it

Cannot answer from this arm's evidence. No data, methods, parameters, or analyses appear in the bundle. `"abstract": null` and `snippet_search` `"data": []` mean no body text, results, or figures/tables were retrieved. Missing: any excerpt of the paper's methods or results.

## Prompt 3 — Hidden detail

Cannot answer from this arm's evidence. The Asta arm has "no supplement, table, figure, or trial-registry surface" (bundle caveat), and here even the abstract/body are absent (`"abstract": null`, snippet `"data": []`). Nothing about supplements, tables, figures, appendices, protocols, statistical-analysis plans, or registry fields can be recovered. Missing: any full-text or supplementary surface.

## Prompt 4 — Expert eye

Cannot answer from this arm's evidence. Beyond metadata, the only expert-relevant signals are structural: this is a 1970 `New England Journal of Medicine` paper (`"volume": "283 13"`, `"pages": "686-91"`) authored by `R. Hornick`, `S. E. Greisman`, `T. Woodward`, `H. Dupont`, `A. T. Dawkins`, and `M. J. Snyder`, and it is closed access (`"isOpenAccess": false`, `openAccessPdf.status": "CLOSED"`). No substantive content is exposed for a domain expert to evaluate. Missing: the paper's text.

## Prompt 5 — Overclaim risk

Cannot answer from this arm's evidence. Because no claims, data, or results are present (`"abstract": null`, snippet `"data": []`), the bundle gives no basis to judge what would be dangerous to overclaim. The one meta-risk this bundle itself illustrates: the paper resolved by identifier but returned zero content, so any content assertion would be fabrication. Missing: the paper's substantive claims.

## Prompt 6 — Under-supported claims

Cannot answer from this arm's evidence. No author claims are quoted in the bundle (`"abstract": null`, snippet `"data": []`), so none can be assessed for support. Missing: the paper's claims and the data presented for them.

## Prompt 7 — External dependencies

Cannot answer from this arm's evidence. With no body text or abstract, the bundle contains no claims whose dependence on external literature, assumptions, registry context, or expert judgment could be traced. Missing: the paper's content. (Note only that the bundle itself flags an external route for the elided abstract — the publisher disclaimer points to `https://api.unpaywall.org/...` / `https://doi.org/10.1056/NEJM197010012831406` — but that is a retrieval pointer, not a claim within the paper.)

## Prompt 8 — KB-theme connection

- **mechanistic-over-narrative:** Cannot answer from this arm's evidence. The title mentions `"pathogenesis"` but no mechanistic content is available (`"abstract": null`, snippet `"data": []`).
- **surveillance-as-measurement:** Cannot answer from this arm's evidence. No content on surveillance or measurement is present in the bundle.
- **multi-scale modeling:** Cannot answer from this arm's evidence. No modeling content is present in the bundle.
- **continuous immunity:** Cannot answer from this arm's evidence. The title mentions `"immunologic control"` but no content on immunity dynamics is retrievable (`"abstract": null`, snippet `"data": []`).

## Uncertainty

- **Identity is high-confidence; content is absent.** `get_paper` returned `"status": OK` with a fully consistent metadata block (title, NEJM, 1970-09-24, vol 283(13), pp. 686-91, DOI `10.1056/NEJM197010012831406`, PMID `4916913`), so the resolver clearly located the right record. But `"isOpenAccess": false` / `openAccessPdf.status": "CLOSED"` / `"abstract": null` and `snippet_search` `"data": []` mean no content surface exists in this arm.
- **Empty snippet is a coverage property, not evidence of absence.** Per the bundle caveat, `"data": []` indicates the paper's full text is not in Asta's snippet index (expected for closed-access papers), so silence here says nothing about what the paper contains.
- Prompts 1–8 are therefore unanswerable at the content level from this arm; only bibliographic metadata (identity, authors, venue, closed-access status) is verifiable.
