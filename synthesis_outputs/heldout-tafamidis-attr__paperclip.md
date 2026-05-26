---
case_id: heldout-tafamidis-attr
arm: paperclip
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: heldout-tafamidis-attr | Arm: Paperclip MCP

## Retrieval validity status

**Status: MISS (target not in corpus).**

The direct PMID lookup returned no documents: `lookup pmid 30145929` produced
`No documents found.` This is the cleanest possible retrieval-failure signal:
the target paper (PMID 30145929, the NEJM ATTR-ACT pivotal trial) is not
indexed in the Paperclip corpus, consistent with the NEJM paywall / no-PMC
prediction in the case notes.

A title-based search (`search -t --all "Tafamidis Treatment for Patients with
Transthyretin Amyloid Cardiomyopathy" -n 5`) returned 5 papers in the topic
neighborhood, none of which is the ATTR-ACT pivotal trial itself. The closest
adjacent papers are:

- `PMC8763250` — "Long-Term Survival With Tafamidis in Patients With
  Transthyretin Amyloid Cardiomyopathy" (Elliott et al., 2021-12-20). This is
  almost certainly the ATTR-ACT long-term extension / follow-up analysis, not
  the pivotal trial.
- `PMC5606341` — "Treatment With Tafamidis Slows Disease Progression in
  Early-Stage Transthyretin Cardiomyopathy" (Sultan et al., 2017-09-18). This
  is an earlier tafamidis paper, pre-dating the 2018 NEJM pivotal trial.
- `med_cf8e3df76ca2` — a 2023 cost-effectiveness modeling paper on ATTR-CM
  screening (medRxiv preprint).
- `PMC7819654` — a 9-patient real-world cohort study.
- `arx_2112.12879` — a transthyretin amino-acid-sequence evolution paper
  (basic science, unrelated to clinical trial).

No top-1 identity match against PMID 30145929 is achievable; the corpus
contains downstream/adjacent papers but not the pivotal trial.

## Available context

What Paperclip can offer for the 8 prompts is therefore **indirect only**,
through the adjacent papers. The richest single document available is the
medRxiv cost-effectiveness paper `med_cf8e3df76ca2` (126 lines, 5592 words
per `wc`), and the PMC8763250 long-term-survival paper (likely an ATTR-ACT
extension). Neither was opened beyond the search-snippet and map-snippet
level in this bundle. The map probe over the search-result set returned
one- to two-sentence summaries per paper, e.g.:

- `med_cf8e3df76ca2`: "universal systematic screening (USS) for ATTR-CM
  using PYP-scans in older HFpEF patients with ventricular wall [truncated]"
- `PMC5606341`: "treatment with tafamidis significantly slows disease
  progression and improves survival time in patients with early-stage (NYHA
  f[truncated]"
- `PMC8763250`: "patients with transthyretin amyloid cardiomyopathy
  (ATTR-CM) who are treated with tafamidis earlier in the cou[truncated]"
- `PMC7819654`: "in a real-world cohort of patients with transthyretin
  amyloid cardiomyopathy (the majority of whom had advance[truncated]"
- `arx_2112.12879`: "provided text contains only a title... and does not
  include the body of the paper."

Note the `arx_2112.12879` entry confirms a known Paperclip pathology: a paper
indexed by title alone with no body text. The map-probe contamination caveat
(map -n 1 does not honor the limit) is visible — five papers were summarized,
not one.

## 8 evaluation prompts

### 1. Central mechanistic or empirical claim

**Cannot answer from bundle.** The pivotal trial paper (PMID 30145929) is not
in the corpus, so its specific claim — efficacy of tafamidis on the composite
of all-cause mortality and cardiovascular-related hospitalizations in
ATTR-CM — cannot be quoted from Paperclip. Adjacent papers in the bundle
suggest the broader claim space: tafamidis "significantly extended time to
death" in early-stage TTR cardiomyopathy (PMC5606341) and "Continuous
tafamidis treatment significantly reduced all-cause mortality compared to
placebo followed by tafamidis" in long-term follow-up (PMC8763250). The
latter is the strongest indirect proxy and likely references ATTR-ACT.

### 2. Study population / design / sample size

**Cannot answer from bundle.** Population, randomization, and N for the
pivotal trial are not retrievable. The bundle gives no design details for
PMID 30145929. PMC8763250's snippet ("Continuous tafamidis treatment...
compared to placebo followed by tafamidis") implies a long-term extension of
a placebo-controlled RCT, but the bundle does not state the underlying
trial's design or sample size.

### 3. Primary endpoint and effect size

**Cannot answer from bundle.** No effect-size numbers — hazard ratios, NNTs,
mortality differences, hospitalization rates — appear anywhere in the
retrieved snippets. The bundle contains only qualitative descriptors
("significantly extended time to death", "significantly reduced all-cause
mortality") with no magnitudes, confidence intervals, or p-values.

### 4. Comparator / control

**Cannot answer from bundle.** The pivotal trial's comparator is not stated.
PMC8763250's phrasing "placebo followed by tafamidis" suggests a placebo
control in the index trial with crossover at extension, but this is
inference from an extension paper snippet, not a quote from the trial
itself.

### 5. Key secondary endpoints / subgroup findings

**Cannot answer from bundle.** No secondary endpoints, subgroup results,
NYHA-class stratifications, or genotype-stratified (wild-type vs hereditary)
analyses are retrievable.

### 6. Safety / adverse events

**Cannot answer from bundle.** No safety data appear in any snippet.

### 7. Limitations / caveats acknowledged by authors

**Cannot answer from bundle.** No author-acknowledged limitations are
quotable. The adjacent cost-effectiveness paper (`med_cf8e3df76ca2`)
implicitly flags one downstream concern: "unlikely to be cost-effective
due to high treatment costs, despite modest QALY gains" — this is a
post-hoc economic critique of tafamidis at its approved price, not a
limitation acknowledged in the pivotal trial.

### 8. Implications / what the field should do next

**Cannot answer from bundle for the pivotal trial.** The cost-effectiveness
preprint (`med_cf8e3df76ca2`) provides an indirect downstream implication
about systematic screening economics, and the real-world cohort
(`PMC7819654`) notes that in advanced disease "No significant improvements
were observed in cardiac biomarkers or heart failure status within six
months" — both downstream of the pivotal result but not statements about
it.

## Uncertainty

- **Identity uncertainty for adjacent papers is high.** PMC8763250 is
  *probably* an ATTR-ACT long-term extension, but the bundle has no full
  text confirming the index trial it extends. The PMID/PMC mapping was not
  verified within the bundle.
- **Bundle depth is shallow.** No `read` of any paper's content.lines or
  sections was performed. All inference is from search snippets and
  truncated map-probe summaries. Deeper reads of PMC8763250 in particular
  could plausibly yield indirect quotes about ATTR-ACT's design and
  primary endpoint, but were not attempted.
- **Map-probe contamination is present but benign here.** The `-n 1` probe
  returned 5 results, but in this case the contamination is informative
  (it shows the search neighborhood) rather than misleading, because no
  paper was being mistaken for the target.
- **arx_2112.12879 is title-only.** The map probe explicitly confirms the
  body is missing, so this paper cannot contribute substantive content
  even if relevant.

## Prohibited inferences

Because the target paper is not in the corpus and no full text of any
ATTR-ACT-related paper was read, the following inferences are **prohibited**
from this bundle:

1. **Do not quote or attribute specific ATTR-ACT numerical results** (HR,
   mortality reduction percentage, hospitalization reduction, NYHA-class
   subgroup hazard ratios, sample size, follow-up duration). None of these
   are in the bundle.
2. **Do not claim ATTR-ACT's primary endpoint, comparator arms, dosing, or
   stratification scheme** from the bundle. Inferring "placebo-controlled
   with 30-month follow-up" or similar from the PMC8763250 extension
   snippet would be over-reach.
3. **Do not treat PMC8763250's snippet as authoritative on ATTR-ACT.** It
   is an extension/follow-up analysis, not the index trial; conclusions
   from an extension may differ from the pivotal report (e.g., open-label
   continuation bias).
4. **Do not infer wild-type vs hereditary ATTR subgroup effects.** No such
   data appear.
5. **Do not infer regulatory / approval implications** (e.g., FDA-label
   indications) from the bundle. The cost-effectiveness preprint mentions
   approval-era pricing but does not establish label content.
6. **Do not collapse the cost-effectiveness preprint's "modest QALY gains"
   into a critique of ATTR-ACT's effect size.** The QALY language is a
   modeled downstream economic output, not a restatement of the trial's
   effect estimate.
7. **Do not assert "Paperclip retrieved ATTR-ACT."** It did not. The
   pivotal PMID lookup returned `No documents found.` Any synthesis that
   reads as if the trial were retrieved would be a hallucination relative
   to this bundle.
8. **Do not fill gaps from training-data knowledge of ATTR-ACT.** Per the
   synthesizer rule, only Paperclip outputs in this bundle are admissible
   evidence.
