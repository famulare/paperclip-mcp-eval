---
case_id: famulare-2018-plosbio
arm: paperclip
synthesizer: Claude Opus 4.8
---

## Retrieval validity

What the bundle contained:

- **PMID lookup resolved correctly.** `lookup pmid 29702638` returned exactly one paper — "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine" by "Michael Famulare, Christian Selinger, Kevin A. McCarthy, Philip A. Eckhoff, Guillaume Chabot-Couture", tagged "PMC5942853 · PLoS Biology · 2018". This matches the requested identifier set.
- **DOI lookup failed.** `lookup doi 10.1371/journal.pbio.2002468` returned "No documents found." (the case notes flag this as the "canonical Paperclip-DOI-miss case").
- **Title search top-1 matched the target.** `search -t` returned the target as hit #1 with matching PMCID (PMC5942853), authors, and a summary snippet. Hits #2–#5 are other polio/epidemic-modeling papers, not the target.
- **`map -n 1` did not honor the limit and is contaminated.** The command requested `-n 1` but "Map complete: 5/5 tasks succeeded" — output spans five different papers (PMC5942853, med_ef5c8f1f6c08, arx_2304.12516, PMC5892013, PMC4934862). Only the first `[success]` line pertains to the target paper; the other four are other documents' claims and must not be attributed to this paper. This is the flagged map-contamination behavior, observed here.
- **Body text was NOT surfaced.** `ls /papers/PMC5942853/` shows `content.lines (252 lines)`, `sections/`, `supplements/`, `figures/`; `wc` reports `252 317634 1081313`. But no lines of `content.lines`, no section text, no figure/table content are quoted in the bundle. The only prose about the paper is the search snippet and the (truncated) first map result.
- **Supplements are listed but not served.** `ls /papers/PMC5942853/supplements/` shows `pbio.2002468.s001.pdf` and `pbio.2002468.s002.zip`. A `grep -n -i -m 5 "supplement|appendix"` over `content.lines` returned "(no matches found)" — consistent with the flagged behavior that an inventory can exist while the body text does not mention/contain the supplement material.

Net: the bundle is strong on **identity resolution** (PMID) and **supplement inventory**, but exposes almost no primary content — the substantive answers below rest on two short summaries (search snippet + one truncated map line).

## Prompt 1 — Central mechanistic claim

The bundle gives two overlapping statements of the central claim, both from Paperclip-generated summaries rather than quoted body text.

From the target's map result: "The central claim of this paper is that the long-term stability of polio eradication post-OPV cessation depends on the local transmission rate of a co" (the line is truncated in the bundle at "co").

From the search snippet: "A mathematical model assessed polio transmission risks after oral polio vaccine (OPV) withdrawal. In high-transmission settings without population immunity, OPV-derived poliovirus poses risks similar to wild poliovirus."

So the central claim, as recoverable from the bundle: using a **mathematical model**, the paper argues that the **stability of polio eradication after OPV withdrawal depends on local transmission rate**, and that where transmission is high and population immunity absent, **OPV-derived poliovirus poses risks comparable to wild poliovirus**. The full formulation is cut off ("...transmission rate of a co"), so the complete predicate cannot be recovered from this arm.

## Prompt 2 — Evidence supporting it

Partial. The bundle identifies the **method** but exposes none of the underlying data, parameters, or analyses.

- Method: the search snippet states "A mathematical model assessed polio transmission risks after oral polio vaccine (OPV) withdrawal." So the supporting apparatus is a mathematical transmission model.
- The paper's body clearly exists — `content.lines` has 252 lines and `wc` reports 1,081,313 bytes — but **no lines of it are quoted**, and `sections/`, `figures/`, and `supplements/` are listed but not opened. No parameter values, model equations, datasets, or specific analyses appear anywhere in the bundle.

Cannot answer further from this arm's evidence: the specific data, parameters, and analyses that support the claim are not surfaced.

## Prompt 3 — Hidden detail

Two supplementary artifacts are inventoried but their content is not served:

`ls /papers/PMC5942853/supplements/` →
```
pbio.2002468.s001.pdf  pbio.2002468.s002.zip
```

So important detail plausibly lives in **`pbio.2002468.s001.pdf`** (a supplementary PDF) and **`pbio.2002468.s002.zip`** (a supplementary archive, likely code/data given the `.zip`). The bundle also lists `sections/` and `figures/` subtrees that were not enumerated.

Flag: a `grep` of `content.lines` for "supplement|appendix" returned "(no matches found)" — so the body text as surfaced does not point into these supplements. Per the bundle's stated behavior ("Empty ... supplements/ directory does not mean no supplements — may be merged into content.lines"), the inverse also holds here: a populated `supplements/` inventory exists while the body grep is silent. **What is inside s001.pdf / s002.zip cannot be determined from this arm** — only that the artifacts exist.

## Prompt 4 — Expert eye

Partially answerable, and mostly as a caution about the retrieval rather than the science.

- A domain expert would notice that the risk-equivalence claim is **conditional**, not absolute: the snippet qualifies it as holding "In high-transmission settings without population immunity" — i.e., the equivalence of OPV-derived and wild poliovirus risk is contingent on transmission setting and immunity status, and the truncated map line ties stability to "the local transmission rate." A generic summary might drop that conditioning.
- An expert reviewing the retrieval (not the paper) would notice the **map output is contaminated across five papers**, so any "cross-paper" reading of the map results would wrongly blend claims from medRxiv/arXiv/other PMC papers into this one.

Beyond the conditional framing, the bundle exposes no body content, so deeper expert-level nuance (model structure, assumptions, sensitivity) is: Cannot answer from this arm's evidence.

## Prompt 5 — Overclaim risk

Two overclaim risks are visible from the bundle:

1. **Dropping the conditions.** The snippet asserts OPV-derived poliovirus "poses risks similar to wild poliovirus" only "In high-transmission settings without population immunity." Stating the equivalence unconditionally — as if it holds in all settings or under existing immunity — would overclaim beyond what the bundle text supports.
2. **Attributing contaminated map content to this paper.** Because `map -n 1` returned 5/5 papers, treating the second–fifth `[success]` lines (Western Pacific immunity shortfalls; opinion-dynamics eradication; bOPV cessation risks; VDPV2 emergence and routine-coverage effects) as findings of *this* paper would be a serious overclaim. Only the first result belongs to PMC5942853.

## Prompt 6 — Under-supported claims

Cannot answer from this arm's evidence. Assessing which author claims are under-supported requires the paper's data and analyses, and the bundle exposes none of the body (`content.lines`, `sections/`, `figures/`, and the two supplements are all unopened). The only claim text available is Paperclip's own high-level summaries, which cannot be checked against the paper's evidence from within this bundle.

## Prompt 7 — External dependencies

Partial. The recoverable claim depends on **model inputs/assumptions**: the truncated map line makes stability depend on "the local transmission rate," and the snippet conditions the risk-equivalence on "population immunity" — both are modeling assumptions/parameters rather than directly observed quantities. So the central claim is contingent on how transmission rate and population immunity are specified.

Dependence on external literature, registry context, or specific expert judgment: Cannot answer from this arm's evidence — no reference list, citations, or registry fields are surfaced in the bundle.

## Prompt 8 — KB-theme connection

- **mechanistic-over-narrative:** Supported. The search snippet states the work is "A mathematical model" of "polio transmission risks," i.e., a mechanistic modeling study rather than a narrative review.
- **surveillance-as-measurement:** Cannot answer from this arm's evidence. Nothing in the bundle addresses surveillance or measurement.
- **multi-scale modeling:** Cannot answer from this arm's evidence. The truncated map line ties stability to "the local transmission rate," hinting at a local/global distinction, but the sentence is cut off and the bundle does not establish an explicit multi-scale structure.
- **continuous immunity:** Cannot answer from this arm's evidence. The snippet refers to "population immunity" in a binary framing ("without population immunity"); the bundle does not surface any treatment of immunity as a continuous quantity.

## Uncertainty

Could not determine from this arm:
- The complete central-claim statement — the target's map result is truncated at "...the local transmission rate of a co".
- Any primary evidence: model equations, parameter values, datasets, or specific analyses (body `content.lines`, `sections/`, `figures/` are listed but not quoted).
- The contents of the two supplements (`pbio.2002468.s001.pdf`, `pbio.2002468.s002.zip`) — inventoried only.
- Which author claims are under-supported (Prompt 6) — no body evidence exposed.
- External-literature / registry dependencies (Prompt 7) — no references surfaced.
- Version/provenance: the bundle labels the item variously as "PLoS Biology · 2018" (PMID lookup) and "PMC · 2018-04-27" (search), and the case notes mention a "preprint-final lineage / bioRxiv 10.1101/084012", but the bundle does not itself distinguish preprint vs. accepted vs. journal-final for the resolved document.
- Note: the requested DOI (10.1371/journal.pbio.2002468) did not resolve ("No documents found"); identity was established only via PMID.
