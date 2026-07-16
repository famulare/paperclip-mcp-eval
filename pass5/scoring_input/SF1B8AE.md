# Synthesis SF1B8AE — case_id: nct04232943-pmid36746739

# Synthesis — nct04232943-pmid36746739 | Arm: this arm

## Retrieval validity

Identity resolution is correct. `lookup pmid 36746739` returned "Found 1 papers" resolving to "PMC9996288 · Vaccine · 2023" (lookup_pmid.txt L31–L36), which matches the requested PMID 36746739 and PMCID PMC9996288. `search -t --all` returned the same paper as its top hit with matching PMCID (search_title.txt L117–L121). So the document identity behind this bundle is trustworthy.

Three surfaces are degraded, and the bundle's own "Known this arm behaviors" header (L7–L10) flags them:

- **the summarize step did not honor the limit and is contaminated.** `map --from s_9187a999 -n 1` returned "Map complete: 5/5 tasks succeeded" (map_n_probe.txt L68) — five papers, not one. Only result #1 (PMC9996288) is the target; the other four (a SARS-CoV-2 vaccine BBV152, a trivalent Sabin sIPV infant trial, a cancer-vaccine-adjuvant LLM paper, and a Sabin sIPV phase III trial — L74–L81) are unrelated. I use only the PMC9996288 line and treat the rest as contamination.
- **Trial→paper the summarize step failed with a UUID error.** `map --from s_1971aa39 -n 1 "Summarize the registered arms, enrollment, and primary endpoints."` returned `ERR: map: invalid input syntax for type uuid: "tri_7fa7a997858a"` `[exit 1]` (trial_map.txt L158–L161). The registered arms/enrollment/endpoints were therefore never extracted, even though the trial record was found by `search`.
- **Supplement surface is empty/unconfirmed.** `ls /papers/PMC9996288/supplements/` returned only "(read-only — use /.the provider/ for writable storage)" with no file listing (ls_supplements.txt L47). Per the bundle header (L9), an empty supplements directory does not mean there are no supplements — they may be merged into `the content file`.

Content actually available: `the content file` is 116 lines / 8242 words / 51441 chars (wc.txt L171; ls.txt L57), plus `sections/` and `figures/` directories whose contents are not shown, plus two abstract-level excerpts (search_title.txt L121; map_n_probe.txt L73), and two lines of the statistical-methods text captured by grep (grep_supplement.txt L20–L21). No results tables, no figures, and no numeric outcome data are present in the bundle.

## Prompt 1 — Central mechanistic claim

The clearest statement is the abstract excerpts returned by title search: "This Phase 1 study evaluated inactivated poliovirus vaccine (IPV) with or without a dmLT adjuvant in healthy adults. **The addition of dmLT did not enhance humoral or intestinal immunity or reduce virus shedding.**" (search_title.txt L121). The the summarize step output corroborates the setup but is truncated: "The central empirical claim of this paper is that the addition of the mucosal adjuvant dmLT to an intramuscularly administered inactivated poliovirus" (map_n_probe.txt L73 — sentence cut off mid-clause).

So the central empirical claim, as far as the bundle exposes it, is a **negative/null result**: adding the mucosal adjuvant dmLT to intramuscular IPV in healthy adults did not enhance humoral or intestinal immunity and did not reduce poliovirus shedding. The underlying (tested) mechanistic hypothesis was that a mucosal adjuvant would improve intestinal immunity / reduce shedding; the paper reports that hypothesis was not supported.

## Prompt 2 — Evidence supporting it

The bundle exposes the study's **statistical design and analysis plan**, not the outcome numbers. From the two grep-captured methods lines (grep_supplement.txt L20–L21):

- **Sizing / power.** "With 30 participants per IPV group, this study had an 80% probability of detecting at least one AE that occurs at a rate of 5.3% or higher. With 27 evaluable participants per IPV arm, this study was designed to provide at least 96% power to detect ≥60% reduction in shedding rate 8 days post-challenge in the IPV + dmLT group assuming the shedding rate in the IPV alone group was at least 80%." (L20)
- **Primary endpoint analysis.** "The primary viral shedding endpoint was assessed in the per protocol population. The proportion of participants with stool positive for poliovirus was summarized by time point and group including corresponding 95% CIs. Proportions shedding in IPV groups were compared for each serotype and overall via one minus the relative risk … computed using the Farrington and Manning method [22]." (L21)
- **Time-to-event.** "The type-specific time to cessation of shedding was analyzed by Kaplan-Meier methods, including right-censoring … using the Greenwood method [23]." Cessation defined as "the day of the first PCR-negative stool for challenge virus after which the next two consecutive stool samples were also PCR-negative." (L21)
- **Shedding index.** "A viral shedding index estimate was calculated using the arithmetic mean of the log10 CCID50/g samples collected on Days 36, 43, 50, and 57 … supplemented with the difference in medians (IPV + dmLT minus IPV alone) with corresponding two-sided 95% CIs computed using the percentile bootstrap method." A ratio was computed with a "90% CI … back-transformed using the antilog … used to enable a one-sided level 0.05 non-inferiority test." (L21)

**Limitation:** these are methods, not results. The bundle contains no shedding rates, no immunogenicity titers, and no AE counts, so the actual data supporting the "did not enhance / did not reduce" conclusion (abstract, Prompt 1) is **not present** in this arm's evidence — only the analytic machinery that would have produced it.

## Prompt 3 — Hidden detail

Two hidden-detail items surface from the bundle:

1. **Statistical analysis plan detail buried in body text.** The power basis, endpoint populations, non-inferiority framing, and shedding-index construction (grep_supplement.txt L20–L21, quoted in Prompt 2) are the kind of SAP detail a generic summary would omit. Notable specifics: the primary shedding analysis is in the **per protocol** population; the non-inferiority test is **one-sided at level 0.05** using a **90% CI**; the shedding index averages log10 CCID50/g on **Days 36, 43, 50, and 57**; the study assumed **≥80% shedding in the IPV-alone arm** and was powered for a **≥60% reduction**.
2. **A registry field for an immunlogic secondary endpoint.** The trial search surfaced, from NCT04232943, "Proportion of participants developing type-specific poliovirus antibody secreting cell (ASC) responses defined as ≥8 ASC/10^6 peripheral blood mononuclear cells (PBMC) at any time point following …" (search_nct.txt L103). This ASC threshold definition is a protocol/registry detail not visible in the paper abstract.

**Not available:** the actual supplement inventory. `ls /papers/PMC9996288/supplements/` produced no file list (ls_supplements.txt L47), and per the header caveat this may mean supplements are merged into `the content file` rather than absent. `sections/` and `figures/` directories exist (ls.txt L57) but their contents are not exposed in the bundle, so tables/figures cannot be inventoried here.

## Prompt 4 — Expert eye

- **Design is a challenge study framed as non-inferiority on shedding.** The trial title reads "Inactivated Poliovirus Vaccine (IPV) With or Without E.Coli Double Mutant Heat-Labile Toxin (dmLT) Challenge Study in Healthy Adults" and involves "Poliovirus Shedding Post-bOPV Challenge in Healthy IPV-Primed Adult Subjects" (search_nct.txt L95–L98). An expert would note the endpoint is shedding after a live **bOPV challenge** in **IPV-primed** adults, and that the primary shedding comparison uses a **one-sided 0.05 non-inferiority** structure (grep_supplement.txt L21) — an unusual framing to pair with a hypothesis that the adjuvant would *reduce* shedding.
- **Power rests on strong assumptions.** 96% power depends on "assuming the shedding rate in the IPV alone group was at least 80%" and targeting a "≥60% reduction" (L20). If the base shedding rate were lower, the study would be underpowered — an expert would flag the sensitivity of the null result to that assumption.
- **Small sample, healthy adults.** Only "30 participants per IPV group" / "27 evaluable per IPV arm" (L20); the AE-detection power is only for events at ≥5.3%. Rare or moderate AEs would not be reliably detected.
- **Tooling artifacts an expert user would catch:** the the summarize step cross-paper contamination (map_n_probe.txt L74–L81) and the trial-map UUID crash (trial_map.txt L158) — the trial record exists but its arms/enrollment were never extracted.

## Prompt 5 — Overclaim risk

- **Do not flip the negative result into a positive one.** The abstract explicitly states dmLT "did not enhance humoral or intestinal immunity or reduce virus shedding" (search_title.txt L121). It would be dangerous to claim dmLT works as a poliovirus-shedding-reducing adjuvant.
- **Do not generalize beyond a small Phase 1 healthy-adult challenge study.** n≈30/group, IPV-primed healthy adults (grep_supplement.txt L20; search_nct.txt L98). Nothing supports extrapolation to infants, endemic settings, or field efficacy.
- **Do not treat "did not reduce shedding" as proven equivalence.** The design is non-inferiority-flavored and powered under a specific assumed base rate (≥80%) and effect size (≥60%) (L20); absence of a detected reduction is not the same as a proven no-effect, and the bundle shows no confidence intervals to bound it.
- **Do not attribute the contaminating papers' claims to this paper.** The the summarize step output mixes in a SARS-CoV-2 BBV152 vaccine, two Sabin sIPV papers, and an LLM adjuvant-NER paper (map_n_probe.txt L74–L81); none of their claims belong to PMC9996288.

## Prompt 6 — Under-supported claims

Cannot fully answer from this arm's evidence. The bundle contains the **conclusion** (abstract-level negative result, search_title.txt L121) and the **analysis plan** (grep_supplement.txt L20–L21) but **no results** — no shedding proportions, no immunogenicity titers, no CIs, no AE tables. Without the outcome data I cannot check whether specific author claims are backed by the numbers.

What I *can* flag from within the bundle: the truncated the summarize step restatement of the central claim (map_n_probe.txt L73) is cut off mid-sentence and cannot be relied on as a complete claim; and the "did not reduce virus shedding" conclusion is stated at abstract granularity with no supporting effect sizes present in this arm, so its strength is unverifiable here. State: **partially "Cannot answer from this arm's evidence"** — the results section needed to adjudicate support/overreach is missing.

## Prompt 7 — External dependencies

- **External statistical-methods literature.** The analysis depends on the "Farrington and Manning method [22]" for comparing shedding proportions and the "Greenwood method [23]" for Kaplan-Meier variance (grep_supplement.txt L21) — both external references not reproduced in the bundle.
- **Registry / protocol context.** The endpoint definitions and the ASC threshold (≥8 ASC/10^6 PBMC) come from the ClinicalTrials.gov record NCT04232943 (search_nct.txt L103); linking the paper to its registered arms/enrollment depends on that trial record, which the tool located but failed to map (trial_map.txt L158).
- **Domain assumptions.** The power calculation depends on the assumed "≥80%" base shedding rate in the IPV-alone arm (L20) — an external/prior assumption, not a measured quantity in the bundle.
- **Challenge-model context.** The result is interpretable only against the bOPV-challenge / IPV-primed-adult paradigm named in the trial title (search_nct.txt L96–L98), which is background knowledge the bundle references but does not explain.

## Prompt 8 — KB-theme connection

- **mechanistic-over-narrative** — The paper tests a specific mechanistic hypothesis (a mucosal adjuvant, dmLT, added to IM IPV to boost intestinal immunity / cut shedding) and reports it mechanistically as a null: "did not enhance humoral or intestinal immunity or reduce virus shedding" (search_title.txt L121; map_n_probe.txt L73). This is a mechanistic, hypothesis-driven design rather than a narrative one.
- **surveillance-as-measurement** — Strong connection. The primary endpoint is quantitative virologic measurement: "proportion of participants with stool positive for poliovirus … summarized by time point and group," time to cessation of shedding by PCR-negative stools, and a "viral shedding index estimate … arithmetic mean of the log10 CCID50/g samples" with LLOQ/ULOQ handling (grep_supplement.txt L21). Shedding is treated as a measured surveillance quantity.
- **multi-scale modeling** — Cannot answer from this arm's evidence. The bundle shows statistical estimation (bootstrap CIs, Kaplan-Meier, non-inferiority testing) but no multi-scale or dynamical model.
- **continuous immunity** — Partial. The study measures humoral and intestinal immunity and, per the registry, "type-specific poliovirus antibody secreting cell (ASC) responses … at any time point" (search_nct.txt L103), i.e., immune responses over follow-up days. But the bundle does not frame immunity as a continuous quantity in the KB's modeling sense, so beyond noting the immunogenicity endpoints I cannot answer the theme's intent from this arm's evidence.

## Uncertainty

- The bundle exposes **methods and abstract-level conclusions only** — no results tables, no figures, no numeric outcomes. Prompts asking about evidence strength (2, 6) and hidden data (3) are answerable only for the analysis-plan text captured by grep, not for the actual findings.
- The **supplement inventory is unresolved**: `ls .../supplements/` returned no listing (ls_supplements.txt L47), which per the bundle's own caveat (header L9) does not confirm the absence of supplements. `sections/` and `figures/` exist (ls.txt L57) but were not read into the bundle.
- The **trial→paper bridge is broken**: the trial record NCT04232943 was found (search_nct.txt), but the summarize step on it crashed with a UUID error (trial_map.txt L158), so registered arms/enrollment/endpoints were not extracted — only two fragmentary registry excerpts are available.
- The **the summarize step central-claim probe is contaminated and truncated**: five papers returned instead of one (map_n_probe.txt L68, L74–L81), and the target's claim sentence is cut off (L73). I relied on the title-search abstract (L121) as the primary source for the central claim and discarded the four unrelated papers.
- Identity itself is **not** uncertain: PMID→PMCID resolution is internally consistent (lookup_pmid.txt L31–L36; search_title.txt L119).
