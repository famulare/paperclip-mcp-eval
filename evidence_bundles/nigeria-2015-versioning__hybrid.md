# Evidence Bundle: nigeria-2015-versioning | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** arXiv 1504.02751 | PMID 26317401 | DOI 10.1371/journal.pone.0135765
**Case notes:** Canonical version-lineage case.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: nigeria-2015-versioning

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Nigeria 2015 arXiv -> PLOS ONE
**Case type:** preprint/journal/postprint version lineage
**Wheelhouse:** yes

## PubMed source-of-record

- **PMID:** 26317401
- **PMCID:** PMC4552877
- **DOI:** 10.1371/journal.pone.0135765
- **Title:** Has Wild Poliovirus Been Eliminated from Nigeria?
- **Authors (top 6):** Famulare M
- **Journal:** PloS one
- **Pub date:** 2015
- **Also:** doi = 10.1371/journal.pone.0135765

## Abstract (fair-use snippet)

```
1. PLoS One. 2015 Aug 28;10(8):e0135765. doi: 10.1371/journal.pone.0135765. 
eCollection 2015.

Has Wild Poliovirus Been Eliminated from Nigeria?

Famulare M(1).

Author information:
(1)Institute for Disease Modeling, Bellevue, WA, United States of America.

Wild poliovirus type 3 (WPV3) has not been seen anywhere since the last case of 
WPV3-associated paralysis in Nigeria in November 2012. At the time of writing, 
the most recent case of wild poliovirus type 1 (WPV1) in Nigeria occurred in 
July 2014, and WPV1 has not been seen in Africa since a case in Somalia in 
August 2014. No cases associated with circulating vaccine-derived type 2 
poliovirus (cVDPV2) have been detected in Nigeria since November 2014. Has WPV1 
been eliminated from Africa? Has WPV3 been eradicated globally? Has Nigeria 
interrupted cVDPV2 transmission? These questions are difficult because polio 
surveillance is based on paralysis and paralysis only occurs in a small fraction 
of infections. This report provides estimates for the probabilities of 
poliovirus elimination in Nigeria given available data as of March 31, 2015. It 
is based on a model of disease transmission that is built from historical polio 
incidence rates and is designed to represent the uncertainties in transmission 
dynamics and poliovirus detection that are fundamental to interpreting long time 
periods without cases. The model estimates that, as of March 31, 2015, the 
probability of WPV1 elimination in Nigeria is 84%, and that if WPV1 has not been 
eliminated, a new case will be detected with 99% probability by the end of 2015. 
The probability of WPV3 elimination (and thus global eradication) is > 99%. 
However, it is unlikely that the ongoing transmission of cVDPV2 has been 
interrupted; the probability of cVDPV2 elimination rises to 83% if no new cases 
are detected by April 2016.
```

## arXiv source-of-record

### arXiv:1504.02751

- **Title:** Has wild poliovirus been eliminated from Nigeria?
- **Authors:** Michael Famulare
- **Versions:** v1 submitted 2015-04-10; v2 revised 2015-07-10
- **arXiv URL:** https://arxiv.org/abs/1504.02751
- **Note:** v2 adds cVDPV2 forecast updates relative to v1; PLOS ONE final = 10.1371/journal.pone.0135765 (2015-08-28). Source: arXiv abs page, captured pass-2 validation_logs/source_metadata.md.

## Diagnostic claim anchors (scorer reference)

- Models WPV elimination probability given surveillance sensitivity in Nigeria.
- arXiv v1 submitted 2015-04-10; v2 revised 2015-07-10 with updates including cVDPV2 forecast.
- Published in PLOS ONE 2015. Version label is the whole point of this case.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### nigeria-2015-versioning__lookup_arxiv_1504_02751.txt

```
# command: lookup arxiv 1504.02751
# captured: 2026-05-22T00:19:33.1214730-07:00

Found 1 papers

  1. Has wild poliovirus been eliminated from Nigeria?
     Michael Famulare
     1504.02751 · arXiv · 2015-04-10
     https://doi.org/10.1371/journal.pone.0135765


```

### nigeria-2015-versioning__lookup_doi.txt

```
# command: lookup doi 10.1371/journal.pone.0135765
# captured: 2026-05-22T00:19:32.0344872-07:00

Found 1 papers

  1. Has wild poliovirus been eliminated from Nigeria?
     Michael Famulare
     1504.02751 · arXiv · 2015-04-10
     https://doi.org/10.1371/journal.pone.0135765


```

### nigeria-2015-versioning__lookup_pmid.txt

```
# command: lookup pmid 26317401
# captured: 2026-05-22T00:19:32.5650516-07:00

Found 1 papers

  1. Has Wild Poliovirus Been Eliminated from Nigeria?
     Michael Famulare
     PMC4552877 · PLoS ONE · 2015
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4552877/


```

### nigeria-2015-versioning__ls.txt

```
# command: ls /papers/PMC4552877/
# captured: 2026-05-22T00:19:35.3927425-07:00

meta.json  content.lines  (116 lines)  sections/  supplements/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### nigeria-2015-versioning__map_n_probe.txt

```
# command: map --from s_0ee69dd3 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:19:40.1649933-07:00

Map complete: 4/4 tasks succeeded in 1509ms
Results ID: m_f8fe6d27
Full results: /.gxl/map_m_f8fe6d27.txt

  [success] Has wild poliovirus been eliminated from Nigeria?  (arx_1504.02751)
    The provided text does not contain a research paper or any content addressing the elimination of wild poliovirus in Nigeria. Therefore, I cannot ident
  [success] Sub-national estimation of surveillance sensitivity to inform declarat  (med_a0b332816c2a)
    The paper claims that a statistical framework—specifically a multi-stage, multi-component "scenario tree" approach—can be used to quantify the time-va
  [success] Eradication of wild poliovirus in Nigeria: Lessons learnt  (PMC9461633)
    The central claim of this paper is that Nigeria’s successful eradication of wild poliovirus was achieved through a multi-faceted strategy—specifically
  [success] Poliovirus-nonsusceptible Vero cell line for the World Health Organiza  (bio_7f8114f26da7)
    The paper claims that the newly generated **Vero $\Delta$PVR1/2 double-knockout (DKO) cell line** is resistant to poliovirus (PV) infection because it

Full results: /.gxl/map_m_f8fe6d27.txt

```

### nigeria-2015-versioning__search_title.txt

```
# command: search -t --all "Has wild poliovirus been eliminated from Nigeria?" -n 5
# captured: 2026-05-22T00:19:34.4425971-07:00

Found 4 papers  [s_536e96a7]

  1. Has wild poliovirus been eliminated from Nigeria?
     Michael Famulare
     arx_1504.02751 · arXiv · 2015-04-10
     https://doi.org/10.1371/journal.pone.0135765
     "This study modeled poliovirus transmission in Nigeria to estimate elimination probabilities. Wild poliovirus type 1 and 3 are likely eliminated, but circulating vaccine-derived type 2 poliovirus transmission continues."

  2. Sub-national estimation of surveillance sensitivity to inform declaration of disease elimination: A retrospective validation against the elimination of wild poliovirus in Nigeria
     Emily S Nightingale *, Ly Pham-Minh, Isah Mohammed Bello, Samuel Okrior, Tesfaye Bedada Erbeto, Mary...
     med_a0b332816c2a · medRxiv · 2025-01-30
     https://doi.org/10.1101/2025.01.30.25321401
     "A statistical framework estimated the sensitivity of polio surveillance in Nigeria. This framework's validation showed it can prospectively inform disease elimination declarations."

  3. Eradication of wild poliovirus in Nigeria: Lessons learnt
     Osmond C. Ekwebelem, Obinna V. Nnorom-Dike, Abdullahi Tunde Aborode, Nicholas C. Ekwebelem, Job C. A...
     PMC9461633 · biomedrxiv · 2021-05-15
     https://doi.org/10.1016/j.puhip.2021.100144
     "Nigeria's polio eradication initiative successfully eliminated wild poliovirus through effective partnerships and community mobilization. This achievement highlights the importance of sustained prioritization and global support for global polio eradication."

  4. Poliovirus-nonsusceptible Vero cell line for the World Health Organization global action plan
     Yuko Okemoto-Nakamura, Kenji Someya, Toshiyuki Yamaji, Kyoko Saito, Makoto Takeda, Kentaro Hanada *
     bio_7f8114f26da7 · bioRxiv · 2020-08-19
     https://doi.org/10.1101/2020.08.19.257204
     "A poliovirus-nonsusceptible Vero cell subline was generated. This cell line can be used to isolate viruses without the risk of generating poliovirus-infected materials, aiding global polio eradication efforts."

[815ms, saved to s_536e96a7]

💡 Extract data across these results with: map --from s_536e96a7 "your question"

```

### nigeria-2015-versioning__wc.txt

```
# command: wc /papers/PMC4552877/content.lines
# captured: 2026-05-22T00:19:35.9757086-07:00

116    7126   43204 /papers/PMC4552877/content.lines

```


