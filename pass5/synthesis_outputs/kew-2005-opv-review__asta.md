---
case_id: kew-2005-opv-review
arm: asta
synthesizer: Claude Opus 4.8
---

# Synthesis: kew-2005-opv-review | Arm: Asta (Ai2 Scientific Corpus MCP)

## Retrieval validity

The `get_paper` call on `PMID:16153180` resolved to a single, coherent record: title "Vaccine-derived polioviruses and the endgame strategy for global polio eradication.", venue "Annual Review of Microbiology", `"year": 2005`, `"publicationDate": "2005-09-09"`, volume 59, pages 587-635, DOI `10.1146/ANNUREV.MICRO.58.030603.123625`, PubMed `16153180`. Authors resolve to O. Kew, R. Sutter, E. D. de Gourville, W. Dowdle, M. Pallansch. Identity resolution is therefore valid at the bibliographic level.

However, the record is `"isOpenAccess": false` with `openAccessPdf.status": "CLOSED"`, `"abstract": null`, and the disclaimer states: `"The following paper fields have been elided by the publisher: {'abstract'}"`. The `snippet_search` call returned `"data": []` — an empty snippet index result. Per the Asta arm caveat, an empty snippet result means the paper's body text is not in Asta's snippet index (expected for a closed-access publisher-elided paper) and should be treated as "no body-text evidence available," not evidence of absence in the paper. Consequently this bundle carries **bibliographic metadata only** — no abstract, no body text, no snippets, no figures/tables/supplement/registry surface. Most content prompts below cannot be answered from this arm's evidence.

## Prompt 1 — Central mechanistic claim

Cannot answer from this arm's evidence. The bundle exposes only title and metadata. The title — `"Vaccine-derived polioviruses and the endgame strategy for global polio eradication."` — indicates the subject matter (vaccine-derived polioviruses; polio-eradication endgame) but states no mechanistic or empirical claim. The abstract is `null` (elided by publisher) and the snippet result is empty, so no claim text is available.

## Prompt 2 — Evidence supporting it

Cannot answer from this arm's evidence. No data, methods, parameters, or analyses are present in the bundle. The only substantive content is bibliographic metadata; `"abstract": null` and `snippet_search` returned `"data": []`.

## Prompt 3 — Hidden detail (supplement / table / figure / appendix / protocol / SAP / registry)

Cannot answer from this arm's evidence. The Asta arm has "no supplement, table, figure, or trial-registry surface" (bundle caveat), and no body text is indexed here (empty snippet result). Nothing about supplements, tables, figures, appendices, protocols, statistical-analysis plans, or registry fields can be assessed. What is missing: any full-text or supplementary surface for this paper — note this is a review article in Annual Review of Microbiology (`"venue": "Annual Review of Microbiology"`, pages `587-635`), for which Asta indexes only closed metadata.

## Prompt 4 — Expert eye

Cannot answer from this arm's evidence for the paper's substantive content. The only expert-noticeable facts available from the metadata are contextual, not about the paper's arguments: it is a long review (`"pages": "587-635"` ≈ 49 pages) in `Annual Review of Microbiology`, volume 59 (2005), authored by O. Kew, R. Sutter, E. D. de Gourville, W. Dowdle, and M. Pallansch. Any expert reading of the paper's actual content is unavailable because the abstract is elided and no body text is indexed.

## Prompt 5 — Overclaim risk

Cannot answer from this arm's evidence about the paper's claims. The relevant overclaim risk from the *tool's* standpoint is that the empty `snippet_search` (`"data": []`) and `"abstract": null` must not be read as the paper containing no evidence — per the arm caveat, treat empty snippets as "no body-text evidence available," not evidence of absence. No statement about what would be dangerous to overclaim *from the paper* can be made without its content.

## Prompt 6 — Under-supported claims

Cannot answer from this arm's evidence. No author claims are visible in the bundle (abstract `null`, snippets empty), so none can be assessed for support.

## Prompt 7 — External dependencies

Cannot answer from this arm's evidence. Without abstract or body text, the paper's dependencies on external literature, assumptions, registry context, or expert judgment cannot be identified. (Contextually, the metadata indicates a review article — venue `Annual Review of Microbiology`, pages `587-635` — a genre that by nature synthesizes external literature, but the bundle provides no in-text evidence to substantiate specific dependencies.)

## Prompt 8 — KB-theme connection

- **mechanistic-over-narrative:** Cannot answer from this arm's evidence. No content text is available to judge mechanistic vs narrative framing.
- **surveillance-as-measurement:** Cannot answer from this arm's evidence. The title references "global polio eradication," but the bundle contains no text connecting the paper to surveillance-as-measurement.
- **multi-scale modeling:** Cannot answer from this arm's evidence. No content indicating modeling of any scale is present.
- **continuous immunity:** Cannot answer from this arm's evidence. No content on immunity dynamics is present in the metadata-only bundle.

## Uncertainty

The single load-bearing uncertainty is coverage, not correctness. Identity resolution is high-confidence: the `get_paper` externalIds (PubMed `16153180`, DOI `10.1146/ANNUREV.MICRO.58.030603.123625`), title, venue, year (`2005`), and author list are internally consistent and unambiguous. Content is entirely absent: `"abstract": null` (publisher-elided per the disclaimer), `"isOpenAccess": false` / `status": "CLOSED"`, and `snippet_search` → `"data": []`. Under the bundle caveat, the empty snippet reflects the paper being outside Asta's snippet index (a closed-access, publisher-elided Annual Reviews article), not absence of content in the paper itself. All prompts requiring the paper's substantive content (1, 2, 3, 5, 6, 7, and all four KB themes in 8) are therefore un-answerable from this arm; only bibliographic identity and document genre/length (Prompt 4's contextual layer) are supported.
