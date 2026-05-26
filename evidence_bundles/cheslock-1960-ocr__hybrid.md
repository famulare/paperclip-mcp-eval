# Evidence Bundle: cheslock-1960-ocr | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** Local: Cheslock_McCULLY_1960 PDF
**Case notes:** Old scanned local-only case; no PubMed metadata.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: cheslock-1960-ocr

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Cheslock & McCully 1960 B6 diet
**Case type:** OCR/scan stress
**Wheelhouse:** yes

## Local-only case

No web/API metadata applicable. Identity validated by local archive filename and pdftotext snippet (see local PDF extraction in Phase 5).

## Diagnostic claim anchors (scorer reference)

- Human metabolic ward study of low vitamin B6 diet.
- Reports xanthurenic acid excretion and tryptophan loading test results.
- 1960 print; OCR layer quality is the benchmark issue.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### cheslock-1960-ocr__ls.txt

```
# command: ls /papers/PMC3679127/
# captured: 2026-05-22T00:19:42.1151236-07:00

meta.json  content.lines  (226 lines)  sections/  supplements/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### cheslock-1960-ocr__search_title.txt

```
# command: search -t --all "Response of human beings to a low vitamin B6 diet" -n 5
# captured: 2026-05-22T00:19:41.2355368-07:00

Found 5 papers  [s_f3702a74]

  1. Intestinal commensal bacteria promote  Bactrocera dorsalis  larval development through vitamin B6 synthesis pathway
     Jian Gu, Zhichao Yao, Bruno Lemaitre, Zhaohui Cai *, Hongyu Zhang *, Xiaoxue Li *
     bio_5dd1305074c7 · bioRxiv · 2024-04-15
     https://doi.org/10.1101/2024.04.15.589666
     "Intestinal bacteria were studied for their role in fruit fly larval development under poor diet conditions. Vitamin B6 synthesis by these bacteria was found to be crucial for promoting larval growth."

  2. Metabolomic Analysis Reveals Extended Metabolic Consequences of Marginal Vitamin B-6 Deficiency in Healthy Human Subjects
     Jesse F. Gregory, Youngja Park, Yvonne Lamers, Nirmalya Bandyopadhyay, Yueh-Yun Chi, Kichen Lee, Ste...
     PMC3679127 · biomedrxiv · 2013-01-01
     https://doi.org/10.1371/journal.pone.0063544
     "A study induced marginal vitamin B-6 deficiency in healthy adults and analyzed their plasma metabolome. This deficiency significantly altered amino acid metabolism and other metabolic pathways, demonstrating widespread consequences."

  3. Vitamin D sensitivity to the immune responses and autoimmunity: A   chemical network model study
     Susmita Roy, Krishna Shrinivas and Biman Bagchi
     arx_1304.7193 · arXiv · 2013-04-26
     "This study modeled vitamin D's effects on immune responses using a kinetic network. Lower vitamin D levels lead to aggressive immune responses, while optimal levels promote tolerance and reduce autoimmunity risk."

  4. Method for Evaluation of the Requirements of B-group Vitamins Using Tryptophan Metabolites in Human Urine
     Katsumi Shibata, Junko Hirose, Tsutomu Fukuwatari
     PMC4404996 · biomedrxiv · 2015-01-01
     https://doi.org/10.4137/IJTR.S24412
     "This study evaluated the validity of Japanese B-group vitamin requirements using tryptophan metabolites in urine. Supplementing B-group vitamins beyond recommended levels did not alter tryptophan metabolism, supporting the current DRI-J requirements."

  5. Vitamin B6: A Long Known Compound of Surprising Complexity
     Sutton Mooney, Jan-Erik Leuendorf, Christopher Hendrickson, Hanjo Hellmann
     PMC6253932 · PMC · 2009-01-12
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6253932/
     "This review summarizes vitamin B6's discovery, structure, and pathways, detailing its roles as an enzymatic cofactor and antioxidant. Recent research highlights its importance in cellular metabolism, stress response, transport, and catabolism, impacting human health."

[502ms, saved to s_f3702a74]

💡 Extract data across these results with: map --from s_f3702a74 "your question"

```

### cheslock-1960-ocr__wc.txt

```
# command: wc /papers/PMC3679127/content.lines
# captured: 2026-05-22T00:19:42.6984566-07:00

226    9672   60515 /papers/PMC3679127/content.lines

```


## Section 3 — Local PDF slices

### Slot: cheslock-1960-ocr

# Local PDF Slice: cheslock-1960-ocr

**File:** Cheslock_McCULLY_1960_Response_of_human_beings_to_a_low_vitamin_B6_diet.pdf
**Pages:** 7
**Chars:** 38235
**Lines:** 513

## Head slice (first 2500 chars)

```
Response of Human Beings to a Low-Vitamin BeDiet1

                          KATHERINE E. CHESLOCK AND MARGARET T. McCULLY
                          Nutrition Laboratory, School of Home Economics,
                          University of Delaware, Newark


    Recent findings indicate that vitamin B6 made a brief examination every other
deficiency in human beings may be more week during the experiment. This exami
prevalent     than    heretofore   recognized  nation consisted of an exercise tolerance
(Hunt, '57; Turner and Reynolds, '55).         test following a technique similar to that
Vilter et al. ('53) demonstrated that a de     described by Dr. W. H. Forbes of the Har
ficiency of the vitamin, induced by admin      vard Fatigue Laboratory (Thorndike, '56),
istering the antimetabolite, deoxypyridox-     and an inspection of the lips, mucous
ine, mimics symptoms of deficiencies of membranes of the mouth and the skin. No
other B vitamins. It would be expedient        signs of deficiencies were apparent during




                                                                                                          Downloaded from jn.nutrition.org by on May 20, 2008
if a deficiency of vitamin B6 could be de      the 7 weeks, except the complaint of
tected before latent critical symptoms ap      fatigue in three subjects which is not in
pear.                                          frequent for college students. A record of
    Few tests have proven to be useful in the weight of each subject was kept.
evaluating nutritional status in human be          The subjects were maintained for 52
ings with regard to vitamin B6. Xanthu-        days on a diet which was low in vitamin Bc.
renic acid excretion in the urine of human     The 4-day diet pattern used, with amounts
beings who have received a dose of trypto- of each food, is given in table 1. The diet
phan is increased when the requirement         consisted chiefly of natural foods which
for vitamin B6is abnormally high3 (Wach-       were selected because they were found by
 stein and Gudaitis, '52). Lymphopenia          determination to be low in vitamin BÂ».The
was noted in human subjects when a de          content of vitamin B8in 47 foods is shown
 ficiency was induced with deoxypyridoxine     in table 2. This analysis for vitamin Bs
 (Vilter et al., '53). Tissue concentration     was performed as previously described
 of vitamin BBmay be expected to decrease       (C
```

## Tail slice (last 700 chars)

```
ynolds   1955 Intake     Hawkins     1953 The effect of vitamin BÂ«de
   and elimination of vitamin Be and metabolites    ficiency induced by desoxypyridoxine in human
  by women. II. Pregnant women. J. Am. Dietet.      beings. J. Lab. Clin. Med., 42: 335.
  A., 31; 1119.                                    Wachstein, M., and A. Gudaitis    1952 Disturb
Vilter, R. W., J. F. Mueller, H. S. Glazer, T.      ance of vitamin BÂ«metabolism in pregnancy.
  Jerrold, J. Abraham, C. Thompson and V. R.        J. Lab. Clin. Med., 40: 550.




                                                                                                    Downloaded from jn.nutrition.org by on May 20, 2008

```


