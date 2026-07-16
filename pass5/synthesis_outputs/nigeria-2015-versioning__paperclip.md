---
case_id: nigeria-2015-versioning
arm: paperclip
synthesizer: Claude Opus 4.8
---

# Synthesis: nigeria-2015-versioning | Arm: Paperclip MCP

## Retrieval validity

Identity resolution is strong across three resolvers, all returning the same paper — "Has wild poliovirus been eliminated from Nigeria?" by Michael Famulare:
- `lookup arxiv 1504.02751` → "Found 1 papers ... 1504.02751 · arXiv · 2015-04-10 ... https://doi.org/10.1371/journal.pone.0135765"
- `lookup doi 10.1371/journal.pone.0135765` → same record
- `lookup pmid 26317401` → "Has Wild Poliovirus Been Eliminated from Nigeria? ... PMC4552877 · PLoS ONE · 2015 ... https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4552877/"

Two version/provenance concerns to flag:
1. The arXiv and DOI lookups both label the paper as "1504.02751 · arXiv · 2015-04-10" yet attach the *journal* DOI `10.1371/journal.pone.0135765`, while the PMID lookup returns "PMC4552877 · PLoS ONE · 2015." The bundle therefore surfaces two distinct versions (arXiv preprint vs. PLoS ONE journal final) collapsed under overlapping identifiers, without an explicit version label distinguishing them.
2. **Content was not served.** `ls /papers/PMC4552877/` shows "content.lines (116 lines) sections/ supplements/ figures/" and `wc` reports "116 7126 43204" (116 lines / 7126 words), but the bundle contains none of that body text. The only content-bearing text in the entire bundle is a single search snippet.

The `map --from s_0ee69dd3 -n 1` probe **did not honor `-n 1`** ("Map complete: 4/4 tasks succeeded") — a known contamination behavior. Worse, the map result for the *target* paper (arx_1504.02751) is empty of substance: "The provided text does not contain a research paper or any content addressing the elimination of wild poliovirus in Nigeria. Therefore, I cannot ident[ify]..." The other three map results describe *different* Nigeria-polio papers (a medRxiv surveillance-sensitivity paper, PMC9461633 "Eradication of wild poliovirus in Nigeria: Lessons learnt," and a bioRxiv Vero cell-line paper), none of which is the target. Those must not be attributed to this paper.

## Prompt 1 — Central mechanistic claim

The only substantive characterization of the paper in the bundle is the `search -t` snippet: "This study modeled poliovirus transmission in Nigeria to estimate elimination probabilities. Wild poliovirus type 1 and 3 are likely eliminated, but circulating vaccine-derived type 2 poliovirus transmission continues." Combined with the title "Has wild poliovirus been eliminated from Nigeria?", the central empirical claim is: a transmission model of poliovirus in Nigeria yields estimated elimination probabilities indicating that wild poliovirus types 1 and 3 are *likely* eliminated, while circulating vaccine-derived poliovirus type 2 (cVDPV2) transmission continues.

Note the map result generated *for this paper* did not corroborate this — it returned "cannot ident[ify]" — so this answer rests entirely on the one-sentence search snippet, not on the paper's body text.

## Prompt 2 — Evidence supporting it

Partially answerable. The snippet identifies the method only at the highest level: "This study modeled poliovirus transmission in Nigeria to estimate elimination probabilities." No data sources, model structure, parameters, priors, or analyses appear in the bundle. `wc /papers/PMC4552877/content.lines` reports a 7126-word body exists ("116 7126 43204"), but that text was not served, and the `map` over the target returned no content. Beyond "modeled ... to estimate elimination probabilities," the specific evidence supporting the claim **cannot be answered from this arm's evidence** — the body, methods, and any tables/figures were not exposed.

## Prompt 3 — Hidden detail

Cannot answer from this arm's evidence. `ls /papers/PMC4552877/` lists "sections/  supplements/  figures/" directories, but none are enumerated or served. Per the bundle's known-behavior note, "Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines," so the presence or absence of supplements is undetermined. No table, figure, appendix, protocol, statistical-analysis-plan, or registry field content is present in the bundle to inspect.

## Prompt 4 — Expert eye

Largely cannot answer from this arm's evidence. The one detail a domain reader would flag from the snippet is the type-specific distinction: WPV1 and WPV3 "likely eliminated" versus continuing cVDPV2 transmission — i.e., "elimination" is not uniform across serotypes and the vaccine-derived type-2 problem persists. Any deeper expert observation (model assumptions, surveillance-sensitivity caveats, uncertainty quantification) would require the body text, which is not in the bundle.

## Prompt 5 — Overclaim risk

Two risks are visible from the bundle:
1. **Certainty.** The snippet hedges — "likely eliminated" — so asserting that wild poliovirus *has been* eliminated (as the title's question implies but does not answer) would overstate the paper's conclusion. The continuing-cVDPV2 clause further cautions against a blanket "polio eliminated" claim.
2. **Cross-paper contamination.** The `search` and `map` outputs return three other Nigeria-polio papers (medRxiv `med_a0b332816c2a`, PMC9461633 "Eradication of wild poliovirus in Nigeria: Lessons learnt," bioRxiv `bio_7f8114f26da7`). Because the target paper's own `map` result was empty, there is a real risk of importing those siblings' claims (e.g., "eradication ... achieved through a multi-faceted strategy") into a summary of *this* paper. That would be an overclaim/misattribution.

## Prompt 6 — Under-supported claims

Cannot answer from this arm's evidence. Assessing which of the author's claims are under-supported requires the paper's data and analyses, which the bundle does not contain (body text not served; map over target empty). The bundle provides only a one-sentence abstract-level snippet, which is insufficient to evaluate support.

## Prompt 7 — External dependencies

Cannot answer from this arm's evidence. A transmission model estimating "elimination probabilities" would ordinarily depend on surveillance data, case/AFP inputs, and modeling assumptions, but none of that is stated in the bundle. No external-literature dependencies, registry context, or expert-judgment inputs are visible in the served text.

## Prompt 8 — KB-theme connection

- **Mechanistic-over-narrative:** Supported at snippet level. "This study modeled poliovirus transmission in Nigeria to estimate elimination probabilities" indicates a mechanistic/quantitative modeling approach rather than a narrative account (contrast the sibling PMC9461633, described in the search output as eradication "through effective partnerships and community mobilization" — narrative — which is *not* the target).
- **Surveillance-as-measurement:** Cannot answer from this arm's evidence. The bundle's surveillance-sensitivity material belongs to a *different* paper (`med_a0b332816c2a`, "Sub-national estimation of surveillance sensitivity..."), not the target; the target's own body is not served.
- **Multi-scale modeling:** Cannot answer from this arm's evidence — no model-structure detail is present.
- **Continuous immunity:** Cannot answer from this arm's evidence — the bundle is silent on immunity dynamics.

## Uncertainty

- The single content-bearing sentence (the `search -t` snippet) is the sole basis for Prompts 1, 2, and 8's mechanistic bullet; it is an abstract-level summary, not verified against the paper body, which the arm did not serve.
- The arm confirms a 7126-word body exists (`wc`) and that `sections/`, `supplements/`, and `figures/` directories exist (`ls`), but served none of them — so all content-level, supplement-level, and figure/table-level prompts are unanswerable, not negatively answered.
- The `map -n 1` probe returned 4 papers (limit not honored) and produced *no* usable content for the target paper, so cross-paper contamination is an active risk; the three non-target polio papers in the outputs must not be attributed to this paper.
- Version ambiguity: arXiv-preprint and PLoS ONE journal-final records are surfaced under overlapping identifiers (arXiv date + journal DOI) without an explicit version label.
