---
case_id: kew-2005-opv-review
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: kew-2005-opv-review | Arm: Paperclip MCP

## Retrieval validity status

**Status: RETRIEVAL FAILURE — target paper not present in the Paperclip index.**

- `lookup doi 10.1146/annurev.micro.58.030603.123625` returned:
  > No documents found.
- `lookup pmid 16153180` returned:
  > No documents found.
- Title search for "Vaccine-derived polioviruses and the endgame strategy for global polio eradication" returned 5 hits, none of which are the Kew 2005 Annual Reviews paper. The top hits are:
  > 1. Battle of Polio eradication in the Western Pacific Region in the transition to COVID-19 endemicity ... med_ef5c8f1f6c08 · medRxiv · 2022-11-30
  > 2. The final stages of the global eradication of poliomyelitis ... Nicholas C. Grassly ... PMC3720038 · biomedrxiv · 2013-08-05
  > 3. Leveraging Opinions and Vaccination to Eradicate Networked Epidemics ... arx_2304.12516 · arXiv · 2023-04-25
  > 4. Polio endgame risks and the possibility of restarting the use of oral poliovirus vaccine ... PMC6168953 · biomedrxiv · 2018-01-01
  > 5. Reflections on Modeling Poliovirus Transmission and the Polio Eradication Endgame ... PMC7983882 · PMC · 2020-04-27

None of these is the Kew 2005 Annual Reviews of Microbiology review. The top-1 hit (`med_ef5c8f1f6c08`) is a 2022 medRxiv paper by Mei et al. on the Western Pacific Region — different authors, venue, and year. Per the bundle's stated rule, "Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target," this is a confirmed identity miss.

- `ls /papers/med_ef5c8f1f6c08/` and `wc /papers/med_ef5c8f1f6c08/content.lines` were run against the non-target paper.
- `map --from s_33cd8f0d -n 1 ...` returned 5 successful results across 5 different papers, confirming the known Paperclip behavior that `map -n 1` does NOT honor the result limit. Per the synthesizer rule ("Treat `map -n 1` outputs that processed >1 paper as contaminated"), this output is **contaminated** and cannot be attributed to the target paper.

**Cannot answer from this arm's evidence.** The bundle contains zero text drawn from Kew et al. 2005. All probes either failed (lookup) or returned non-target material (search/ls/wc/map).

## Available context

- **Supplements:** Cannot determine. The only `ls` shown is for a non-target paper (`med_ef5c8f1f6c08`), which reports a `supplements/` directory exists but does not list its contents. No information about supplements for the Kew 2005 target.
- **Version label:** Not available — target paper not retrieved.
- **Trial registry:** Not applicable / not available — target paper not retrieved.
- **Figures/tables:** Not available — target paper not retrieved. The non-target `med_ef5c8f1f6c08` listing shows a `figures/` directory but contents are not enumerated and are not relevant to the target.

## 8 Prompts

### 1. Central mechanistic claim

Cannot answer from this arm's evidence. The `map -n 1` probe is contaminated (5 papers processed), and none of those 5 papers is the target Kew 2005 review.

### 2. Evidence

Cannot answer from this arm's evidence. No content from Kew et al. 2005 is present in the bundle.

### 3. Hidden detail

Cannot answer from this arm's evidence. No target-paper content was retrieved; therefore no detail — hidden or otherwise — is available.

### 4. Domain expert notice

Cannot answer from this arm's evidence. No target-paper content was retrieved.

### 5. Dangerous overclaim

Cannot answer from this arm's evidence. No target-paper content was retrieved. (Meta-note: a dangerous overclaim *about Paperclip's behavior* would be to treat the contaminated `map -n 1` output, or the non-matching top-1 search hit, as if it represented the target paper.)

### 6. Unsupported claims

Cannot answer from this arm's evidence. No target-paper content was retrieved.

### 7. External-literature dependence

Cannot answer from this arm's evidence. No target-paper content was retrieved.

### 8. KB themes

Cannot answer from this arm's evidence. No target-paper content was retrieved. Any thematic linkage to the KB would have to be inferred from outside knowledge of Kew 2005, which this synthesizer is instructed not to consult.

## Uncertainty

- Confidence that the target paper is **absent** from the Paperclip index: high. Both DOI and PMID lookups returned "No documents found," and a title search surfaced 5 unrelated papers with no Kew 2005 match in the top-5.
- Confidence that the `map -n 1` output is **contaminated** and cannot be used: high. The probe reports "5/5 tasks succeeded" across 5 distinct paper IDs, matching the known Paperclip failure mode flagged in the bundle.
- Residual uncertainty: the search was capped at `-n 5`. It is possible (though not supported by evidence in this bundle) that Kew 2005 sits deeper in the title-search ranking. However, given that DOI and PMID lookups both failed, the most parsimonious reading is that the paper is not indexed.

## Prohibited inferences

The following inferences are **explicitly prohibited** for this synthesis and were not made:

1. Do not synthesize a "central claim of Kew 2005" from the contaminated `map -n 1` output. The 5 papers returned (Mei 2022, Grassly 2013, Leung 2023, Duintjer Tebbens & Thompson 2018, Thompson & Kalkowska 2020) are not the target and their summaries cannot be attributed to Kew et al.
2. Do not treat the top-1 search hit (`med_ef5c8f1f6c08`, Mei et al. 2022 medRxiv) as a stand-in for Kew 2005.
3. Do not import outside knowledge of Kew et al. 2005 (authors, content, conclusions, year, venue) to fill the gap. Per the bundle's synthesizer rule, only Paperclip outputs in this bundle may be used.
4. Do not infer the presence or absence of supplements, figures, or trial registry data for Kew 2005 from the non-target paper's directory listing.
