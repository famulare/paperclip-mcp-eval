# Evidence Bundle: heldout-tafamidis-attr | Arm: Paperclip MCP

**Target identifier(s) requested:** PMID 30145929
**Case notes:** Held-out outside-wheelhouse: NEJM cardiology RCT.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

### heldout-tafamidis-attr__lookup_pmid.txt

```
# command: lookup pmid 30145929
# captured: 2026-05-22T00:20:09.3917033-07:00

No documents found.

```

### heldout-tafamidis-attr__ls.txt

```
# command: ls /papers/med_cf8e3df76ca2/
# captured: 2026-05-22T00:20:11.8505581-07:00

meta.json  content.lines  (126 lines)  sections/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### heldout-tafamidis-attr__map_n_probe.txt

```
# command: map --from s_a3cfc5ea -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:20:15.9853784-07:00

Map complete: 5/5 tasks succeeded in 1430ms
Results ID: m_a99c5a4e
Full results: /.gxl/map_m_a99c5a4e.txt

  [success] Cost-Effectiveness of Systematic Screening and Treatment of Transthyre  (med_cf8e3df76ca2)
    The central claim of this paper is that universal systematic screening (USS) for ATTR-CM using PYP-scans in older HFpEF patients with ventricular wall
  [success] Treatment With Tafamidis Slows Disease Progression in Early-Stage Tran  (PMC5606341)
    The paper claims that treatment with tafamidis significantly slows disease progression and improves survival time in patients with early-stage (NYHA f
  [success] Evolution of Transthyretin  (arx_2112.12879)
    The provided text contains only a title ("Evolution of Transthyretin") and does not include the body of the paper. Therefore, the central mechanistic 
  [success] Long-Term Survival With Tafamidis in Patients With Transthyretin Amylo  (PMC8763250)
    The central claim of this paper is that patients with transthyretin amyloid cardiomyopathy (ATTR-CM) who are treated with tafamidis earlier in the cou
  [success] Initial Experience With Tafamidis Treatment for Transthyretin Amyloid   (PMC7819654)
    The central claim of this paper is that in a real-world cohort of patients with transthyretin amyloid cardiomyopathy (the majority of whom had advance

Full results: /.gxl/map_m_a99c5a4e.txt

```

### heldout-tafamidis-attr__search_title.txt

```
# command: search -t --all "Tafamidis Treatment for Patients with Transthyretin Amyloid Cardiomyopathy" -n 5
# captured: 2026-05-22T00:20:11.2328568-07:00

Found 5 papers  [s_1057c37c]

  1. Cost-Effectiveness of Systematic Screening and Treatment of Transthyretin Amyloid Cardiomyopathy (ATTR-CM) in Patients with Heart Failure with Preserved Ejection Fraction (HFpEF) in United States
     Anson TC Lau, Robert J. DiDomenico, Kibum Kim *
     med_cf8e3df76ca2 · medRxiv · 2023-08-14
     https://doi.org/10.1101/2023.08.14.23294100
     "Systematic screening for ATTR-CM in HFpEF patients using PYP-scans was modeled. This approach is unlikely to be cost-effective due to high treatment costs, despite modest QALY gains."

  2. Treatment With Tafamidis Slows Disease Progression in Early-Stage Transthyretin Cardiomyopathy
     Marla B Sultan, Balarama Gundapaneni, Jennifer Schumacher, Jeffrey H Schwartz
     PMC5606341 · biomedrxiv · 2017-09-18
     https://doi.org/10.1177/1179546817730322
     "This study compared tafamidis treatment to no treatment in early-stage transthyretin cardiomyopathy. Tafamidis significantly extended time to death in treated patients."

  3. Evolution of Transthyretin
     J. C. Phillips
     arx_2112.12879 · arXiv · 2021-12-21
     "Researchers analyzed transthyretin's amino acid sequence evolution to understand its dynamics. Human TTR evolved a more flexible and stable central region, which also harbors a high density of amyloid-related mutations."

  4. Long-Term Survival With Tafamidis in Patients With Transthyretin Amyloid Cardiomyopathy
     Perry Elliott, Brian M. Drachman, Stephen S. Gottlieb, James E. Hoffman, Scott L. Hummel, Daniel J. ...
     PMC8763250 · biomedrxiv · 2021-12-20
     https://doi.org/10.1161/CIRCHEARTFAILURE.120.008193
     "This study assessed long-term tafamidis use in transthyretin amyloid cardiomyopathy patients. Continuous tafamidis treatment significantly reduced all-cause mortality compared to placebo followed by tafamidis."

  5. Initial Experience With Tafamidis Treatment for Transthyretin Amyloid Cardiomyopathy
     Makiko Nakamura, Teruhiko Imamura, Masakazu Hori, Ryuichi Ushijima, Shuji Joho, Koichiro Kinugawa
     PMC7819654 · PMC · 2020-07-21
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7819654/
     "This study evaluated tafamidis treatment in nine patients with transthyretin amyloid cardiomyopathy. No significant improvements were observed in cardiac biomarkers or heart failure status within six months."

[301ms, saved to s_1057c37c]

💡 Extract data across these results with: map --from s_1057c37c "your question"

```

### heldout-tafamidis-attr__wc.txt

```
# command: wc /papers/med_cf8e3df76ca2/content.lines
# captured: 2026-05-22T00:20:12.5884719-07:00

126    5592   37248 /papers/med_cf8e3df76ca2/content.lines

```

