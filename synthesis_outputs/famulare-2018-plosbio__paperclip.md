---
case_id: famulare-2018-plosbio
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: famulare-2018-plosbio | Arm: Paperclip MCP

## Retrieval validity status

**Partial / contaminated-map.** The target paper was located by PMID lookup (PMC5942853) and confirmed by title search as the top hit. However, no actual content from the paper body, sections, figures, or supplements was retrieved into this bundle. The grep for "supplement|appendix" returned no matches, and `ls` shows the paper has `content.lines` (252 lines), `sections/`, `supplements/` (containing `pbio.2002468.s001.pdf` and `pbio.2002468.s002.zip`), and `figures/` — but none of these were opened/read. The only substantive claim-level content is from the `map -n 1` probe, which (per known Paperclip behavior and visible output) processed 5 papers, not 1; this is **contaminated**. I will extract only the PMC5942853 segment of the map output and refuse to use the other four entries.

## Available context

- Supplements visible in this arm: **partially** — directory listing shows two supplement files exist (`pbio.2002468.s001.pdf`, `pbio.2002468.s002.zip`), but their contents are NOT in the bundle.
- Version label identifiable from this arm: **no** — bundle notes "preprint-final lineage" exists (bioRxiv 10.1101/084012), but no version metadata was retrieved.
- Trial registry context: **inapplicable** — this is a modeling paper, not a trial.
- Figures/tables visible: **no** — `figures/` directory exists but no figure contents retrieved.

## Prompt 1 — Central mechanistic claim

From the contaminated map output, the PMC5942853-tagged segment states:

> [success] Assessing the stability of polio eradication after the withdrawal of o (PMC5942853)
>     The central claim of this paper is that the long-term stability of polio eradication post-OPV cessation depends on the local transmission rate of a co

The text is **truncated mid-sentence** ("of a co…"). The search-title abstract snippet adds:

> "A mathematical model assessed polio transmission risks after oral polio vaccine (OPV) withdrawal. In high-transmission settings without population immunity, OPV-derived poliovirus poses risks similar to wild poliovirus."

**Inference (from these two fragments):** The central mechanistic claim appears to be that post-OPV-cessation eradication stability is governed by local transmission rate, and in high-transmission/low-immunity settings, OPV-derived poliovirus behaves comparably to wild poliovirus in transmission risk. The completing object of "depends on the local transmission rate of a co[…]" is not recoverable from this arm — likely "community" or "cohort" but I refuse to fabricate it.

## Prompt 2 — Evidence supporting it

**Cannot answer from this arm's evidence.** No content from the paper body, methods, results, figures, tables, or supplements was retrieved. The two visible fragments (map summary stub + search snippet) describe the claim but provide no supporting evidence (no model equations, no parameter ranges, no data sources, no sensitivity analyses). Missing: `content.lines`, `sections/`, `figures/`, and the two supplement files.

## Prompt 3 — Hidden detail in a supplement, table, figure, appendix, protocol, SAP, or registry field

**Cannot answer from this arm's evidence.** The `ls /papers/PMC5942853/supplements/` output confirms two supplement files exist:

> pbio.2002468.s001.pdf  pbio.2002468.s002.zip

But neither file was opened. The `grep -n -i -m 5 "supplement|appendix" /papers/PMC5942853/content.lines` returned:

> (no matches found)

This is itself a finding: either the paper body does not lexically reference "supplement" or "appendix" in those terms (possible — many papers say "S1 Text", "S1 Fig", "Methods"), OR the grep pattern missed the actual referent labels. Per the bundle's stated Paperclip caveat ("Empty /papers/<id>/supplements/ directory does not mean no supplements"), the converse also applies: a non-empty directory with no body-text matches for "supplement|appendix" suggests the paper likely cross-references supplements under PLOS-style labels (S1 PDF, S2 Zip) that the chosen grep pattern did not catch. **No actual supplement content available.**

## Prompt 4 — What would a domain expert notice that a generic summary might miss

**Cannot answer from this arm's evidence.** With only a truncated one-sentence claim summary and an abstract-style snippet, there is no domain-specific detail (model class, R0/Reff assumptions, serotype-specific behavior, OPV2 vs bOPV cessation context, waning immunity functional form, age structure, paralysis-to-infection ratios, environmental surveillance modeling, etc.) for an expert to inspect. The paper's 252-line `content.lines`, 81MB-equivalent textual depth (1,081,313 characters per `wc`), `sections/`, `figures/`, and supplements were not read.

## Prompt 5 — What would be dangerous to overclaim

Given only the visible fragments, the dangers of overclaiming from this arm itself are acute:

1. **Treating the map summary as authoritative.** The map probe was issued with `-n 1` but returned 5 papers (per the bundle's stated known bug: "map -n 1 does NOT honor the result limit"). Confirmed by the output:

   > Map complete: 5/5 tasks succeeded in 3176ms

   Any synthesis that conflates the other 4 papers' claims (Western Pacific Region; opinion-dynamics networked epidemics; bOPV cessation risks; VDPV2/Nigeria) with this paper's claim would be a contamination error.

2. **Treating "OPV-derived poliovirus poses risks similar to wild poliovirus" as unconditional.** The snippet itself conditions on "high-transmission settings without population immunity" — overgeneralizing to all settings would invert the paper's likely point.

3. **Inferring policy prescriptions** (e.g., "do not withdraw OPV", "supplement with IPV") — none of these are visible in the retrieved fragments.

4. **Claiming the paper resolves the post-cessation outbreak question.** The visible verb is "Assessing… stability"; the word "assessed" / "assessing" is investigative, not conclusive. The bundle does not contain the paper's actual confidence calibration.

## Prompt 6 — Which author claims are not well-supported by the data presented

**Cannot answer from this arm's evidence.** Adjudicating support requires seeing both the claims and the data/figures/parameters. Only a truncated claim summary is available; no data, figures, tables, or methods text was retrieved.

## Prompt 7 — Which claims depend on external literature, assumptions, registry context, or expert judgment

**Cannot answer from this arm's evidence in detail.** **Inference only:** From the snippet "A mathematical model assessed polio transmission risks…", the work is mechanistic-model-based, so by class it will depend on:
- prior literature for parameter values (transmission rates, waning, shedding duration);
- assumptions about population mixing, age structure, and immunity dynamics;
- expert judgment on serotype-specific OPV reversion and cVDPV emergence;
- external surveillance and seroprevalence inputs.

None of these dependencies can be verified from the retrieved fragments — the methods section, citations, and supplement S1 PDF were not opened.

## Prompt 8 — Connection to KB themes

**Inference from visible fragments only:**

- **Mechanistic over narrative:** Direct hit on intent — the visible characterization "A mathematical model assessed polio transmission risks" and "the long-term stability of polio eradication post-OPV cessation depends on the local transmission rate" are mechanistic-causal framings, not narrative or epidemiological-correlation framings. (Inference)
- **Surveillance as measurement:** **Cannot answer from this arm's evidence.** No content about AFP surveillance, environmental surveillance, seroprevalence sampling, or detection sensitivity was retrieved.
- **Multi-scale modeling:** **Cannot answer from this arm's evidence.** The phrase "local transmission rate" hints at sub-population structure, but the bundle does not show whether the model is single-population, age-structured, spatially structured, or hierarchical.
- **Continuous immunity:** **Cannot answer from this arm's evidence.** No retrieved text addresses waning, boosting, or graded immunity vs binary susceptible/immune categories.

## Uncertainty

- The completing words of the truncated central-claim sentence ("local transmission rate of a co…") are unrecoverable here.
- It is unknown whether the paper covers OPV2-only cessation (the 2016 "switch") or all serotypes generically; the snippet says "oral polio vaccine (OPV) withdrawal" without serotype specificity.
- It is unknown whether "OPV-derived poliovirus" in the snippet refers to cVDPV, iVDPV, OPV-reverted-but-undeclared, or all categories.
- The supplements `s001.pdf` and `s002.zip` could contain the actual model specification, parameter table, sensitivity analyses, code/data — or could be unrelated archival material. Not opened in this arm.
- The 252-line `content.lines` may contain figure captions, methods, results, and discussion in compact form; none of this was retrieved.
- Whether `grep "supplement|appendix"` returning zero matches is a true negative on textual content or a pattern miss (e.g., "S1 Text", "S2 File") cannot be distinguished from this arm.

## Prohibited inferences (what I refused to claim)

- I refused to use the four non-PMC5942853 entries in the contaminated `map -n 1` output (Western Pacific Region; networked-epidemic opinion dynamics; bOPV cessation; VDPV2/Nigeria) as evidence about this paper.
- I refused to complete the truncated claim sentence ("local transmission rate of a co…") by guessing "community," "cohort," "country," etc.
- I refused to invent serotype-specific (PV1/PV2/PV3, OPV2, bOPV, tOPV, IPV) findings not present in the retrieved text.
- I refused to attribute specific numerical results, parameter values, R0 values, or quantitative thresholds.
- I refused to characterize the model class (deterministic ODE / stochastic / agent-based / network / spatial) since the bundle does not specify it.
- I refused to claim what the supplements contain.
- I refused to claim that the paper does or does not address environmental surveillance, IPV use, or post-cessation outbreak response, since the body text was not retrieved.
