---
case_id: nigeria-2015-versioning
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: nigeria-2015-versioning | Arm: Paperclip MCP

## Retrieval validity status

**Partial retrieval with critical version-lineage failure.** All three target
identifiers (arXiv 1504.02751, DOI 10.1371/journal.pone.0135765, PMID 26317401)
resolve to records the bundle treats as the same paper, but Paperclip silently
collapses the version lineage rather than distinguishing v1/v2/final:

- `lookup arxiv 1504.02751` returns one record dated `2015-04-10` (the v1 date)
  but lists the DOI of the PLOS ONE final (`https://doi.org/10.1371/journal.pone.0135765`).
  No version field is exposed; v1 vs v2 of the arXiv preprint is not addressed.
- `lookup doi 10.1371/journal.pone.0135765` returns the same single record with
  arXiv ID `1504.02751` and date `2015-04-10` — i.e., the published DOI is
  bound to the v1 arXiv date rather than the PLOS ONE publication date.
- `lookup pmid 26317401` returns a *different* record — `PMC4552877 · PLoS ONE · 2015`
  — with no arXiv cross-reference shown and only a year ("2015"), no full date.

So Paperclip stores at least two distinct paper records (`arx_1504.02751` and
`PMC4552877`) that correspond to the same publication lineage but are not
linked to one another in any output here. There is no v1 vs v2 distinction
exposed, and no indication that arXiv 1504.02751 has multiple versions at all.
The arXiv record carries the final DOI as if v1 == final. **This is the
exact failure mode the case was designed to detect.**

A further retrieval contamination: `map --from s_0ee69dd3 -n 1` returns
**4 results across 4 different papers** rather than honoring `-n 1`. The
"THIS paper only" probe response for `arx_1504.02751` is degenerate —
"The provided text does not contain a research paper or any content
addressing the elimination of wild poliovirus in Nigeria" — suggesting
the arXiv record's content payload is empty or wrong. By contrast,
`PMC4552877` has a populated `content.lines` of 116 lines / 7126 words.

## Available context

- One title + one-line abstract for the arXiv record (from search):
  *"This study modeled poliovirus transmission in Nigeria to estimate
  elimination probabilities. Wild poliovirus type 1 and 3 are likely
  eliminated, but circulating vaccine-derived type 2 poliovirus
  transmission continues."*
- Existence (not contents) of `/papers/PMC4552877/` with `meta.json`,
  `content.lines` (116 lines, 7126 words, 43204 chars), and empty-looking
  `sections/`, `supplements/`, `figures/` directories (note: bundle warns
  empty `supplements/` may mean content was merged into `content.lines`).
- Author: Michael Famulare (sole listed author across both records).
- A search for the title surfaces three unrelated papers as well (Nightingale
  et al. 2025 medRxiv; Ekwebelem et al. 2021; Okemoto-Nakamura et al. 2020
  Vero-cell paper) — these are co-retrievals, not co-versions of the target.

No section list, no abstract from the paper body, no figure list, no
references list, and no version metadata were retrieved.

## 1. Central mechanistic claim of THIS paper only

From the one-line search snippet only: the paper models poliovirus
transmission in Nigeria to estimate elimination probabilities, concluding
that **wild poliovirus types 1 and 3 are likely eliminated** while
**circulating vaccine-derived poliovirus type 2 (cVDPV2) transmission
continues**.

The `map` probe targeting the arXiv record itself failed to return any
substantive claim ("The provided text does not contain a research paper…").
No mechanism — e.g., the transmission model class, the reproduction-number
estimation, the likelihood/Bayesian framework, the surveillance-sensitivity
or under-reporting model — is visible in the bundle.

## 2. Evidence supporting the claim

**None retrieved.** The bundle contains no excerpts of methods, data, model
fits, posterior summaries, surveillance counts, AFP/environmental sampling
numbers, or sensitivity analyses. We have only the abstract-snippet assertion
and the existence of a 116-line content file we were not shown.

## 3. Hidden detail a reader would miss without the paper

**Cannot answer from bundle.** No body text, figures, or supplementary
material were retrieved. We have no view into model structure, priors,
data sources, or caveats.

A meta-observation: the most consequential hidden detail relative to *this
case* is what's hidden by Paperclip's *own* index — namely, that
arXiv 1504.02751 has at least two versions (v1 April 2015, v2 July 2015)
distinct from the PLOS ONE final (August 2015), and that the substantive
modeling choices reportedly changed across versions. Paperclip exposes
none of that.

## 4. What a domain expert would notice immediately

A polio domain expert looking at the bundle would notice:

- **Version lineage is invisible.** A canonical example of "preprint
  evolved during review" has been flattened to a single date (2015-04-10)
  with the final DOI attached. The expert would not be able to tell from
  Paperclip which version of the model is being represented.
- **Two records for one paper.** `arx_1504.02751` (empty-content-ish) and
  `PMC4552877` (populated) coexist without being linked. An expert citing
  the paper would not know whether mapping/searching `arx_1504.02751`
  retrieves the same modeling content as `PMC4552877`.
- **The Nightingale et al. 2025 paper** (medRxiv) is a *retrospective
  validation* against Nigeria WPV elimination — an expert would recognize
  it as a downstream confirmation/critique vehicle, not a peer paper.
  Paperclip surfaces it but does not flag the citation relationship.
- **The Vero-cell paper** in result #4 is irrelevant to elimination
  modeling and is a co-retrieval artifact (shared "poliovirus" terms),
  not a topical match.

## 5. Dangerous overclaim risk

**High, structural, version-rooted.** If a downstream user asks Paperclip
"what does Famulare 2015 say about WPV elimination in Nigeria?" the system
will answer as if there is one canonical paper dated 2015-04-10 with the
final PLOS ONE DOI. Any quantitative claim sourced this way (probability
that WPV1 is eliminated, expected detection delay, cVDPV2 risk numbers)
risks being attributed to the wrong version of the model. v1 and v2
estimates can differ; collapsing them is a citation-integrity failure,
not just a metadata cosmetic.

The empty/degenerate `map` response for `arx_1504.02751` also creates a
"silent null" overclaim risk: a user who maps across the arXiv record
will get nothing, and might wrongly conclude the paper has no claim,
when in fact the PMC record has 116 lines of content.

## 6. Unsupported claims in the synthesis itself

This synthesis explicitly limits itself to the bundle. Concrete content
about the model, the data, the Bayesian framework, and the elimination
probability point estimates is **not** asserted here because it is not
in the bundle. The one-line snippet ("WPV1/WPV3 likely eliminated,
cVDPV2 transmission continues") is the only substantive claim relayed,
and it is sourced verbatim from the search abstract.

## 7. External-literature dependence

The bundle contains zero references, citations, or bibliography excerpts.
No external paper is named in the retrieved Paperclip outputs (only
co-retrieved unrelated papers from the title search). External-literature
dependence of the target paper is therefore **not characterizable** from
this arm.

## 8. KB themes this case touches

- **Version lineage and provenance integrity** — the canonical KB concern
  that "same DOI" does not mean "same model"; Paperclip fails this test.
- **Two-layer raw/meta discipline** — Paperclip's index conflates what
  the raw layer should preserve (distinct versions as distinct evidence)
  with what the meta layer might consolidate. Here the conflation happens
  in the index without an audit trail.
- **Origin attribution** — the evaluator's own first-author paper; under KB rules
  this is `Origin: <evaluator>`, and the version distinction matters for which
  modeling choices are the evaluator's locked claims vs earlier drafts.
- **Polio modeling lineage** — connects to the broader KB thread on
  WPV elimination inference, surveillance sensitivity (cf. Nightingale
  et al. 2025 co-retrieval), and cVDPV2 risk that recurs in Famulare's
  later work (e.g., the 2018 PLOS Biology OPV paper).
- **Tool failure modes** — extends the documented Paperclip pathologies
  (map -n 1 ignored, identity-by-top-hit fallacy) with a new one:
  **version lineage erasure for preprint→journal transitions**.

## Uncertainty

- It is possible Paperclip *does* store v1 and v2 as separate records
  under different IDs that simply did not surface for `lookup arxiv 1504.02751`
  (which returned only one row). The bundle cannot rule this in or out.
- It is possible `/papers/arx_1504.02751/content.lines` is populated and
  the `map` probe simply mis-routed; the bundle does not include a `wc`
  or `ls` on the arXiv-side record to confirm.
- The PMC4552877 record's content was not read; all statements about
  its substance are abstract-snippet inferences only.

## Prohibited inferences

The following are **not** supported by the bundle and must not be claimed:

- Any specific numeric elimination probability, posterior interval,
  reproduction number, or detection-delay estimate from the paper.
- The specific model class (e.g., compartmental SIR-style, branching-process,
  hidden-Markov surveillance model) used.
- Differences in numerical results between v1, v2, and the PLOS ONE final
  (the very question the case was designed to probe — Paperclip provides
  no basis to answer it).
- Which co-authors, funders, or institutions are involved beyond
  "Michael Famulare" listed as author.
- Citation relationships to other polio-modeling work (e.g., Kew 2005,
  Thakkar/Famulare, the 2018 PLOS Biology paper) — none are visible
  in the bundle.
- That the empty-looking `supplements/` or `figures/` directories mean
  the paper lacks supplements or figures (bundle warns this is a known
  false-negative pattern).
