# Evidence Bundle: khoury-2021-natmed | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** DOI 10.1038/s41591-021-01377-8 | PMID 34002089 | medRxiv 10.1101/2021.03.09.21252641
**Case notes:** Final article vs preprint; canonical preprint-returned-when-final-requested case.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: khoury-2021-natmed

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Khoury 2021 Nature Medicine + medRxiv preprint
**Case type:** versioned correlate paper
**Wheelhouse:** yes

## PubMed source-of-record

- **PMID:** 34002089
- **DOI:** 10.1038/s41591-021-01377-8
- **Title:** Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection.
- **Authors (top 6):** Khoury DS; Cromer D; Reynaldi A; Schlub TE; Wheatley AK; Juno JA; et al.
- **Journal:** Nature medicine
- **Pub date:** 2021 Jul
- **Also:** preprint = medRxiv 10.1101/2021.03.09.21252641 (2021)

## Abstract (fair-use snippet)

```
1. Nat Med. 2021 Jul;27(7):1205-1211. doi: 10.1038/s41591-021-01377-8. Epub 2021 
May 17.

Neutralizing antibody levels are highly predictive of immune protection from 
symptomatic SARS-CoV-2 infection.

Khoury DS(#)(1), Cromer D(#)(1), Reynaldi A(1), Schlub TE(1)(2), Wheatley AK(3), 
Juno JA(3), Subbarao K(3)(4), Kent SJ(3)(5)(6), Triccas JA(7)(8), Davenport 
MP(9).

Author information:
(1)Kirby Institute, University of New South Wales, Sydney, New South Wales, 
Australia.
(2)Sydney School of Public Health, Faculty of Medicine and Health, University of 
Sydney, Sydney, New South Wales, Australia.
(3)Department of Microbiology and Immunology, University of Melbourne at the 
Peter Doherty Institute for Infection and Immunity, Melbourne, Victoria, 
Australia.
(4)WHO Collaborating Centre for Reference and Research on Influenza, Peter 
Doherty Institute for Infection and Immunity, Melbourne, Victoria, Australia.
(5)Australian Research Council Centre for Excellence in Convergent Bio-Nano 
Science and Technology, University of Melbourne, Melbourne, Victoria, Australia.
(6)Melbourne Sexual Health Centre and Department of Infectious Diseases, Alfred 
Hospital and Central Clinical School, Monash University, Melbourne, Victoria, 
Australia.
(7)School of Medical Sciences, Faculty of Medicine and Health, University of 
Sydney, Sydney, New South Wales, Australia. jamie.triccas@sydney.edu.au.
(8)Charles Perkins Centre and Marie Bashir Institute for Infectious Diseases and 
Biosecurity, University of Sydney, Sydney, New South Wales, Australia. 
jamie.triccas@sydney.edu.au.
(9)Kirby Institute, University of New South Wales, Sydney, New South Wales, 
Australia. m.davenport@unsw.edu.au.
(#)Contributed equally

Comment in
    Nat Med. 2021 Jul;27(7):1147-1148. doi: 10.1038/s41591-021-01432-4.
    EBioMedicine. 2022 May;79:104034. doi: 10.1016/j.ebiom.2022.104034.
    Nature. 2022 Sep;609(7926):232-233. doi: 10.1038/d41586-022-02806-5.

Predictive models of immune protection from COVID-19 are urgently needed to 
identify correlates of protection to assist in the future deployment of 
vaccines. To address this, we analyzed the relationship between in vitro 
neutralization levels and the observed protection from severe acute respiratory 
syndrome coronavirus 2 (SARS-CoV-2) infection using data from seven current 
vaccines and from convalescent cohorts. We estimated the neutralization level 
for 50% protection against detectable SARS-CoV-2 infection to be 20.2% of the 
mean convalescent level (95% confidence interval (CI) = 14.4-28.4%). The 
estimated neutralization level required for 50% protection from severe infection 
was significantly lower (3% of the mean convalescent level; 95% CI = 0.7-13%, 
P = 0.0004). Modeling of the decay of the neutralization titer over the first 
250 d after immunization predicts that a significant loss in protection from 
SARS-CoV-2 infection will occur, although protection from severe disease should 
be largely retained. Neutralization titers against some SARS-CoV-2 variants of 
concern are reduced compared with the vaccine strain, and our model predicts the 
relationship between neutralization and efficacy against viral variants. Here, 
we show that neutralization level is highly predictive of immune protection, and 
provide an evidence-based model of SARS-CoV-2 immune protection that will assist 
in developing vaccine strategies to control the future trajectory of the 
pandemic.

© 2021. The Author(s), under exclusive licence to Springer Nature America, Inc.
```

## Diagnostic claim anchors (scorer reference)

- Models neutralizing antibody level as predictor of protection from symptomatic SARS-CoV-2.
- Fits a logistic/probit model relating neutralization titer to vaccine efficacy across trials.
- Final paper has different curves/parameters than the medRxiv preprint; version distinction matters.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### khoury-2021-natmed__lookup_doi.txt

```
# command: lookup doi 10.1038/s41591-021-01377-8
# captured: 2026-05-22T00:19:12.9326641-07:00

No documents found.

```

### khoury-2021-natmed__lookup_pmid.txt

```
# command: lookup pmid 34002089
# captured: 2026-05-22T00:19:13.5190013-07:00

No documents found.

```

### khoury-2021-natmed__ls.txt

```
# command: ls /papers/med_19bd1cbe73d5/
# captured: 2026-05-22T00:19:15.3822553-07:00

meta.json  content.lines  (178 lines)  sections/  supplements/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### khoury-2021-natmed__map_n_probe.txt

```
# command: map --from s_bff83ef1 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:19:19.6340635-07:00

Map complete: 5/5 tasks succeeded in 1531ms
Results ID: m_4b8786f4
Full results: /.gxl/map_m_4b8786f4.txt

  [success] Level and duration of IgG and neutralizing antibodies to SARS-CoV-2 in  (med_19bd1cbe73d5)
    The central claim of this paper is that children, whether symptomatic or asymptomatic, develop robust neutralizing and IgG antibody responses to SARS-
  [success] What level of neutralising antibody protects from COVID-19?  (med_3287fa4e6d00)
    The central claim of this paper is that neutralisation level is highly predictive of immune protection against SARS-CoV-2 (L14). Specifically, the aut
  [success] A paper-based multiplexed serological test to monitor immunity against  (arx_2402.17774)
    The paper claims that a paper-based multiplexed serological test can be combined with machine learning algorithms to accurately monitor immunity again
  [success] Correlates of Protection, Thresholds of Protection, and Immunobridging  (PMC9881762)
    The central claim of this paper is that despite variations in reported thresholds of protection and different assay methodologies, results across mult
  [success] Symptomatic and Asymptomatic SARS-CoV-2 Infection and Follow-up of Neu  (PMC9850449)
    The central empirical claim of this paper is that while symptomatic and asymptomatic individuals exhibit high levels of neutralizing antibodies at ear

Full results: /.gxl/map_m_4b8786f4.txt

```

### khoury-2021-natmed__search_title.txt

```
# command: search -t --all "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection" -n 5
# captured: 2026-05-22T00:19:14.8304582-07:00

Found 5 papers  [s_dd72b32b]

  1. Level and duration of IgG and neutralizing antibodies to SARS-CoV-2 in children with symptomatic or asymptomatic SARS-CoV-2 infection
     Alka Khaitan, Dibyadyuti Datta, Caitlin Bond, Michael Goings, Katrina Co, Eliud O. Odhiambo, Lin Zha...
     med_19bd1cbe73d5 · medRxiv · 2022-04-12
     https://doi.org/10.1101/2022.04.12.22273466
     "This study measured SARS-CoV-2 antibodies in symptomatic and asymptomatic children and adults. Symptomatic children developed robust neutralizing antibodies that persisted longer than in adults, though all antibody levels waned over time."

  2. What level of neutralising antibody protects from COVID-19?
     David S Khoury, Deborah Cromer, Arnold Reynaldi, Timothy E Schlub, Adam K Wheatley, Jennifer A Juno,...
     med_3287fa4e6d00 · medRxiv · 2021-03-09
     https://doi.org/10.1101/2021.03.09.21252641
     "This study modeled the relationship between in vitro neutralisation levels and observed protection from COVID-19. Neutralisation level is highly predictive of protection, with 50% protection from infection estimated at 20% of convalescent levels."

  3. A paper-based multiplexed serological test to monitor immunity against   SARS-CoV-2 using machine learning
     Merve Eryilmaz, Artem Goncharov, Gyeo-Re Han, Hyou-Arm Joung, Zachary S. Ballard, Rajesh Ghosh, Yiji...
     arx_2402.17774 · arXiv · 2024-02-19
     https://doi.org/10.1021/acsnano.4c02434
     "This study developed a paper-based test to monitor SARS-CoV-2 immunity by detecting antibody levels. The test accurately categorized individuals into protected, unprotected, or infected groups using a machine learning algorithm."

  4. Correlates of Protection, Thresholds of Protection, and Immunobridging among Persons with SARS-CoV-2 Infection
     David S. Khoury, Timothy E. Schlub, Deborah Cromer, Megan Steain, Youyi Fong, Peter B. Gilbert, Kant...
     PMC9881762 · biomedrxiv · 2023-02-01
     https://doi.org/10.3201/eid2902.221422
     "Neutralizing antibody levels were normalized across studies to assess their relationship with SARS-CoV-2 protection. This normalization revealed a consistent correlation between antibody levels and protection, aiding in vaccine planning and immunity assessment."

  5. Symptomatic and Asymptomatic SARS-CoV-2 Infection and Follow-up of Neutralizing Antibody Levels
     Shu Juan CUI, Yi ZHANG, Wen Jing GAO, Xiao Li WANG, Peng YANG, Quan Yi WANG, Xing Huo PANG, Xiao Pen...
     PMC9850449 · PMC · 2023-01-19
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9850449/
     "Neutralizing antibody levels were measured in symptomatic and asymptomatic COVID-19 patients at 6 and 10 months post-infection. Antibody levels dropped significantly in both groups by 6 months, suggesting ongoing monitoring is necessary."

[754ms, saved to s_dd72b32b]

💡 Extract data across these results with: map --from s_dd72b32b "your question"

```

### khoury-2021-natmed__wc.txt

```
# command: wc /papers/med_19bd1cbe73d5/content.lines
# captured: 2026-05-22T00:19:16.0515253-07:00

178    7817   54947 /papers/med_19bd1cbe73d5/content.lines

```


