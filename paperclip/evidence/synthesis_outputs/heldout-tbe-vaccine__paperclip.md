---
case_id: heldout-tbe-vaccine
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: heldout-tbe-vaccine | Arm: Paperclip MCP

## Retrieval validity status

**Status: MISS on the target PMID. Adjacent corpus available, but the target paper (PMID 23997980, "Tick-borne Encephalitis Vaccines") is not in the Paperclip index.**

Evidence:
- `lookup pmid 23997980` returned `"No documents found."` (bundle line 20).
- The title search `"Tick-borne Encephalitis Vaccines"` returned 5 hits, none of which match the target. The top hit (`bio_41d493ca7185`) is a 2024 bioRxiv preprint on a *nanoparticle* TBE vaccine. The second hit (PMC3899155) is a 2013 review on *epidemiology and prevention by available vaccines* (Amicizia et al.) — same year/topic neighborhood as the target but a different paper.
- The `map --from s_d002d6ad -n 1 ...` call is the documented Paperclip bug where `-n 1` is *not* honored: 5 papers' worth of mechanistic-claim output came back (bundle lines 41–55), so any synthesis that doesn't carefully attribute per-paper will be contaminated across the 5-paper search set.

**Per the synthesizer rule, the rest of this synthesis must be answered using only what Paperclip returned — which does not include the target paper.** The Paperclip outputs do, however, partially probe the *adjacent* paper PMC3899155 (Amicizia et al. 2013, "Epidemiology of tick-borne encephalitis (TBE) in Europe and its prevention by available vaccines"), so where the prompts are answerable about *that* paper rather than the held-out target, I will answer for that paper and label it as a substitute, not the target.

## Available context

What Paperclip provided that is on-topic for TBE vaccines:

1. A 5-hit title search across the TBE-vaccine neighborhood (bundle lines 66–96), with one-sentence abstract-style blurbs per paper.
2. A contaminated 5-paper map-claim probe (bundle lines 41–55), each ~1 sentence of mechanistic claim per paper.
3. Confirmation that PMC3899155 is present in the index, with `meta.json`, a 203-line `content.lines`, and a `sections/` directory (bundle lines 27–30; `wc` confirms 203 lines / 7895 words / 52247 chars at lines 109).

What Paperclip did not provide:
- Any content from PMID 23997980 itself (the held-out target).
- Any quoted text or section-level structure from PMC3899155 (only `ls` and `wc` were run, no `read`/`grep`/`section` calls).
- Any supplements, tables, or figures.

## Prompt responses

### 1. Central mechanistic claim of the paper

**Cannot answer for the target (PMID 23997980): not retrieved.**

Substitute, for the nearest neighbor in the bundle, PMC3899155 (Amicizia et al. 2013), quoting Paperclip's map result verbatim (bundle line 48): *"The paper claims that vaccination is the most effective measure to prevent Tick-borne encephalitis (TBE) and that current TBE vaccines (FSME-Immun®, E..."* — the sentence is truncated in the map output. The search blurb (line 78) adds: *"Vaccines demonstrate high efficacy, safety, and cross-protection against different TBE virus strains."*

This is a *review-paper* central claim (vaccination is effective; available vaccines work and cross-protect), not a mechanistic claim of the held-out target.

### 2. Evidence cited for the central claim

**Cannot answer.** Paperclip's bundle never read into `content.lines` for any paper. Only the `ls`/`wc`/`map`/`search` outputs are available. The map blurb gives a *claim* but no enumerated evidence. No effect sizes, study designs, or numbers were retrieved.

### 3. Hidden / load-bearing detail a casual reader would miss

**Cannot answer from the bundle.** No paper body was read; only abstract-grade summaries and bibliographic metadata are present. There is no basis in the bundle for naming any load-bearing detail.

### 4. What would a domain expert immediately notice?

A domain expert reading the *Paperclip outputs themselves* (not the target paper) would notice:

- The held-out target is missing from the Paperclip corpus entirely (`lookup pmid 23997980` → `No documents found.`, line 20). This is consistent with a *Vaccine*-journal paper that is not deposited in PMC.
- The top title-search hit is a 2024 nanoparticle-vaccine preprint, not the canonical TBE-vaccine review one would expect for that exact title — a relevance/recency artifact of the index.
- The map call uses the `-n 1` flag that is documented as broken; the bundle explicitly flags this ("map -n 1 does NOT honor the result limit"), and indeed 5 papers were mapped, not 1. Any downstream synthesis treating these 5 blurbs as a single paper's content would be wrong.
- PMC3899155 has `203 lines` / `7895 words` (line 109) — small enough to read end-to-end, but Paperclip never did so in this bundle.

### 5. Most dangerous overclaim a careless reader could make

The most dangerous overclaim in this bundle is treating any of the 5 returned papers as if it were the held-out target. In particular:

- Treating PMC3899155 (Amicizia 2013 review) as a stand-in for PMID 23997980 ("Tick-borne Encephalitis Vaccines"). They are both 2013, both about TBE vaccines, and the search interface presents them in the same result set — but they are different papers with different scope, evidence, and authorship.
- Treating the contaminated `map -n 1` output as if its five bullets were five claims from one paper, when in fact each bullet is from a distinct paper (a nanoparticle preprint, a Europe-epidemiology review, an arXiv forecasting paper that didn't even have full text, a cross-subtype meta-analysis, and a cross-neutralisation study).
- Asserting that "TBE vaccines cross-protect across subtypes" as a finding of the target paper, when the bundle's support for that statement comes from PMC5443051 and PMC5627269 (bundle lines 51–54, 91–96), not from PMID 23997980.

### 6. Claims in this synthesis NOT directly supported by the bundle

By construction, almost any substantive claim about PMID 23997980 would be unsupported, because the target is not retrieved. Specifically, the bundle does *not* support:

- Any statement about the target paper's authorship, journal (Vaccine), publication date, study design, immunogenicity numbers, formulation comparisons (FSME-Immun vs Encepur, pediatric vs adult, Western vs Russian vaccines), schedule recommendations, seroconversion rates, duration of protection, or adverse-event profiles.
- Any quantitative claim about TBE vaccine efficacy. The bundle contains only qualitative blurbs ("high efficacy, safety, and cross-protection") with no numbers.
- The bundle does support (within Paperclip's own returned text) the *existence* of papers asserting cross-subtype immunogenicity and cross-neutralisation, but not the magnitudes or conditions.

### 7. External-literature dependence

The bundle's text is bibliographic — short abstract-style blurbs plus map-derived single-sentence "claim" summaries. To do anything beyond paraphrasing those blurbs, a reader must go to external literature. In particular, to answer the assignment's actual question about PMID 23997980, one must leave Paperclip entirely (e.g., go to the Vaccine-journal site or a non-PMC source), because the target is not in this index.

The 5-paper search set does form a coherent micro-literature around TBE vaccines (preclinical nanoparticle development; European epidemiology + available vaccines; cross-subtype immunogenicity meta-analysis; cross-neutralisation across the TBE complex). A user could use Paperclip to *triangulate around* the missing target — but reconstructing the target's specific claims would require external retrieval.

### 8. KB themes / connections worth flagging

(KB instructions ask the synthesizer to surface non-trivial connections; what's surfaceable from *this bundle alone*?)

- **Retrieval-failure pattern**: This is a clean instance of the "outside-wheelhouse" failure mode that the evaluation is designed to elicit — a clinically important paper indexed only in non-PMC venues (Vaccine journal) is invisible to a PMC-leaning corpus. This is the same shape of failure as other Paperclip misses where the underlying corpus, not the tool, is the bottleneck.
- **Known-bug confirmation**: The `map -n 1` non-honoring behavior fired exactly as the bundle's preamble warned. This is now a reproduced, not just rumored, contamination source.
- **Adjacent-corpus richness**: Even on a target miss, Paperclip surfaced four genuinely related papers (Amicizia review, Domnich cross-subtype meta-analysis, McAuley cross-neutralisation, Wang nanoparticle vaccine). For a user willing to accept neighborhood-not-target answers, the tool is still useful — but the synthesizer must be explicit about the substitution, which is what I have done above.
- **Disconfirmation hygiene**: The `lookup pmid` returning "No documents found" is a clean negative signal. Unlike search-rank ambiguity, this is unambiguous evidence of absence in the index, and should always be trusted over a top-1 search hit that happens to share keywords.

## Uncertainty

- High confidence: the held-out target paper is not in Paperclip's index (direct `lookup pmid` negative).
- High confidence: PMC3899155 is in the index and is a 2013 European TBE-vaccine review — but is not the target.
- Low/no confidence on any substantive claim about the target paper itself; bundle is silent.
- Moderate confidence that the 5-paper neighborhood is the most relevant set Paperclip can surface for this query, given the search and map outputs.

## Prohibited inferences

I have not used any external knowledge of PMID 23997980, its authors, its journal, or its content. I have not extrapolated from training-data knowledge of TBE vaccines (e.g., specific efficacy numbers, FSME-Immun vs Encepur head-to-heads, Russian vaccine names, schedule details). I have not treated any of the 5 retrieved papers as a stand-in for the target except where I explicitly labeled the substitution and the limitation. I have not paraphrased the `map -n 1` contaminated output as if it described a single paper.
