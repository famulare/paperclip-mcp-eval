---
case_id: hornick-typhoid
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: hornick-typhoid | Arm: Paperclip MCP

## Retrieval validity status

**Target paper NOT retrieved.** The target is Hornick et al. 1970 NEJM (PMID 4916913), a pre-1980 NEJM human-challenge study on typhoid fever pathogenesis and immunologic control.

- `lookup pmid 4916913` returned: `No documents found.`
- `search -t --all "Typhoid fever pathogenesis and immunologic control" -n 5` returned 5 papers, **none of which is Hornick 1970**. The top hits are:
  1. Okyere et al. 2024, medRxiv, "Risk factors for typhoid fever: A desk review" (med_1d85b4706e45)
  2. Yang/Chong/Song 2018, "Why Is Eradicating Typhoid Fever So Challenging..." (PMC6160957)
  3. Masasila et al. 2023, arXiv, mathematical model of information dynamics (arx_2310.09825)
  4. Sztein/Salerno-Goncalves/McArthur 2014, "Complex Adaptive Immunity to Enteric Fevers..." (PMC4209864)
  5. Ishaq et al. 2020, "Eosinopenia in Patients With Typhoid Fever..." (PMC7549842)
- The corpus appears to lack the pre-1980 NEJM paper entirely; no surrogate Hornick record was returned.
- The subsequent `map --from s_f5c17030 -n 1` probe is **contaminated**: despite `-n 1`, it ran across all 5 search hits (known Paperclip behavior — `-n 1` does not honor the result limit). None of those 5 papers is the target.
- The `ls /papers/med_1d85b4706e45/` and `wc /papers/med_1d85b4706e45/content.lines` calls operate on the Okyere 2024 desk review, not on Hornick 1970.

**Conclusion:** Paperclip missed the target entirely. All downstream prompts must be answered as "no evidence in bundle for the target paper."

## Available context

The bundle contains zero retrieval of Hornick 1970. The only retrievable artifact is metadata and a single content map line for the Okyere 2024 desk review (med_1d85b4706e45), which "synthesized evidence on typhoid fever risk factors from 1928-2023" — so it may *cite* Hornick-era literature but is not the target and was not deep-read in the bundle. No section text, no figures, no abstract, no methods, no results from Hornick 1970 are available.

## 1. Central mechanistic claim of the target paper

**Unable to answer from bundle.** Paperclip did not return Hornick 1970. The 5 papers it did return concern, respectively: socio-economic/WASH risk factors (Okyere 2024); MDR strains and vaccine challenges (Yang 2018); information-behavior math model (Masasila 2023); cell-mediated immunity in enteric fever (Sztein 2014); and eosinopenia as a diagnostic marker (Ishaq 2020). None of these is a substitute for the Hornick human-challenge dose-response and immunity findings.

## 2. Evidence for the claim

**Unable to answer.** No content from the target paper was retrieved. No quotations, tables, figures, or methodological detail from Hornick 1970 are present in the bundle.

## 3. Hidden / easily-overlooked detail

**Unable to answer.** Cannot identify hidden detail in a paper that was not retrieved.

## 4. What a domain expert would notice

**Unable to answer from bundle.** A domain expert reviewing *this Paperclip session* (rather than the target paper) would notice: (a) the corpus appears to lack pre-1980 NEJM coverage; (b) Paperclip silently returns "No documents found" on PMID lookup without offering nearest-neighbor suggestions; (c) the title-search ranking surfaces a 2024 medRxiv desk review above any classical immunology reference — suggesting recency or full-text indexing bias; (d) the `map -n 1` contamination bug is visible here in that the probe fanned out to all 5 search hits.

## 5. Most dangerous overclaim a non-expert could make

**The single most dangerous failure mode this bundle invites:** A non-expert who does not check the returned IDs against the requested PMID could read the `map` output and conclude that "the central mechanistic claim of Hornick 1970 is that typhoid transmission is driven by socio-economic/housing/WASH risk factors" — i.e., conflate the Okyere 2024 desk review's claim with the Hornick paper. This is a category error: Hornick 1970 is a controlled human-challenge dose-response study, not an observational risk-factor review. The Paperclip output gives no warning that the target was not found and the substituted papers are unrelated in study design and era.

A secondary risk: treating the Sztein 2014 cell-mediated-immunity review as a stand-in for Hornick's immunity findings would propagate 40+ years of intervening science backwards into the 1970 source.

## 6. Claims the paper would NOT support

**Unable to enumerate target-specific unsupported claims** since the paper was not retrieved. Generically, anything Paperclip returned in this session about typhoid (risk factors, MDR resistance, eosinopenia diagnostics, information-behavior modeling, modern CMI mechanisms) should NOT be attributed to Hornick 1970 on the basis of this bundle.

## 7. External-literature dependence

The bundle is **entirely dependent on external literature** to answer anything about Hornick 1970, because the target was not retrieved. Even a partial answer would require either: (a) finding the paper in another corpus, or (b) relying on the synthesizer's prior knowledge — which the protocol prohibits. The Okyere 2024 desk review might, in principle, cite Hornick (its date range 1928-2023 covers it), but the bundle includes no extracted citation list, so this cannot be verified from the bundle.

## 8. Connection to KB themes

**Unable to make grounded connections** because the target paper's content is absent from the bundle. The KB themes around dose-response, controlled human infection models, and the foundations of vaccine challenge studies cannot be linked to specific Hornick 1970 findings using only what Paperclip returned.

## Uncertainty

- **High confidence:** Paperclip's corpus does not contain Hornick 1970, or contains it under an indexing that is not reachable via PMID 4916913 or the title query used. The bundle provides no evidence of the target paper.
- **High confidence:** The `map` output is contaminated across 5 unrelated papers (known `-n 1` bug) and should not be read as describing the target.
- **Moderate uncertainty:** Whether alternative queries (author search "Hornick", year-bounded search, DOI lookup) would have surfaced the paper. The bundle did not attempt these.
- **Moderate uncertainty:** Whether the Okyere 2024 desk review's reference list contains Hornick 1970; the bundle does not surface references.

## Prohibited inferences

Given the retrieval failure, the following inferences are **prohibited** from this bundle:

1. Any claim about Hornick 1970's dose-response findings, inoculum sizes, attack rates, incubation periods, or immunity correlates.
2. Any claim that Hornick 1970 supports or contradicts the socio-economic/WASH risk-factor framing of Okyere 2024.
3. Any claim mapping modern CMI/humoral immunity findings (Sztein 2014) backward onto Hornick 1970.
4. Any claim about MDR or vaccine-design implications (Yang 2018) as if Hornick had addressed them.
5. Any quotation, paraphrase, or "according to Hornick" attribution sourced from this bundle — there is no Hornick text in the bundle.
6. Any inference that "Paperclip's top hit is the target" — the top hit (Okyere 2024) is demonstrably not PMID 4916913.
7. Any treatment of the contaminated `map` output as if it described a single paper, much less the target.

The only valid conclusion from this bundle is the **negative retrieval result**: Paperclip, under the queries issued, did not return Hornick 1970 NEJM and offered no signal that the target was missing rather than answered.
