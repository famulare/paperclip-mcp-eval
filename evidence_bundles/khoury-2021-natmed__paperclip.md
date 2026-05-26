# Evidence Bundle: khoury-2021-natmed | Arm: Paperclip MCP

**Target identifier(s) requested:** DOI 10.1038/s41591-021-01377-8 | PMID 34002089 | medRxiv 10.1101/2021.03.09.21252641
**Case notes:** Final article vs preprint; canonical preprint-returned-when-final-requested case.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

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

