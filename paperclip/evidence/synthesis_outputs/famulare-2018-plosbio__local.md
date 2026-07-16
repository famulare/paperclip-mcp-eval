---
case_id: famulare-2018-plosbio
arm: local
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: famulare-2018-plosbio | Arm: Local PDF

## Retrieval validity status

The local PDF arm provided only head and tail slices (first 2500 chars and last 700 chars) of two files: the main manuscript (71 pages, 326,834 chars) and the S1 supplement (17 pages, 53,223 chars). The slices are well-formatted and readable, not OCR-poor, but they expose only the abstract opening and final references for the main paper, and only the supplement's table of contents and final references for S1. The vast middle of both documents (Methods, Results, Discussion, parameter tables, model equations, figures) is not in the bundle. The version label is clearly identifiable as the bioRxiv preprint deposit ("bioRxiv preprint first posted online Oct. 27, 2016; doi: http://dx.doi.org/10.1101/084012"), not the final PLoS Biology 2018 typesetting, despite the case_id naming convention.

## Available context
- Supplements visible: yes (S1 table of contents and final references only — body not visible)
- Version label identifiable: yes (bioRxiv preprint 2016-10-27, doi 10.1101/084012; PLoS Biology 2018 final not confirmed in slice)
- Trial registry context: inapplicable (modeling/synthesis paper, not a trial)
- Figures/tables visible: no (Table A is referenced in the S1 TOC but its body is truncated mid-row in the slice; no figures visible)

## Prompt 1 — Central mechanistic claim

From the visible abstract text, the central mechanistic claim is that OPV's effectiveness in poor-sanitation settings derives specifically from its ability to block local transmission, and that the cross-immunity afforded by bivalent OPV (types 1 and 3) against type 2 is mechanistically insufficient to perform this transmission-blocking role:

> "Our results demonstrate that in settings with poor sanitation: (1) OPV has been effective in all populations because it blocks transmission locally, (2) cross-immunity against type 2 produced by bivalent types 1 and 3 OPV is insufficient to block"

The sentence is truncated by the head-slice cutoff, so the second clause's conclusion is not fully recoverable from the bundle.

## Prompt 2 — Evidence supporting it

The abstract states the evidence base is a synthesis of "75 years of polio literature detailing how vaccination affects individual susceptibility to infection and viral shedding," combined with "close-contact transmission data from the USA and India." The S1 TOC confirms the named datasets:

> "Part C.1   Houston 1960"
> "Part C.2   Louisiana 1953–1955"
> "Part C.3   Uttar Pradesh and Bihar 2003–2008"

And the within-host model has explicit components for:

> "Part B.2   Shedding duration after OPV challenge or WPV infection"
> "Part B.3   Concentration of poliovirus in stool"
> "Part B.4   Oral susceptibility to infection from OPV challenge"
> "Part B.5   Waning immunity against infection"

The actual quantitative evidence (parameter values, fit statistics, transmission estimates) is not visible in the slices.

## Prompt 3 — Hidden detail in supplement/table/figure/appendix/protocol/SAP/registry

Hidden in the S1 supplement is a structural detail visible only because the TOC and the start of Table A leaked into the head slice: the model uses an "OPV-equivalent antibody titer" (denoted NAb) as the individual correlate of immunity, with a referenced range "1, 211" — i.e., the model collapses heterogeneous serological evidence onto a single OPV-equivalent scale rather than treating type-specific antibody titers as independent:

> "OPV-equivalent an-           -            NAb                                                          individual correlate of immunity
> tibody titer"

This unification choice is mechanistically consequential (it determines how data from disparate assays and serotypes are pooled) and would be invisible to a reader of only the main text. Reference [39] in the S1 (Gelfand et al., 1957, Louisiana natural-immunity household episodes study) is also a key archival source that anchors the Louisiana 1953–1955 transmission fit.

## Prompt 4 — What would a domain expert notice that a generic summary might miss

A polio domain expert would notice three things from the visible material:

1. **The lineage problem.** The header explicitly says "bioRxiv preprint first posted online Oct. 27, 2016" with CC-BY-ND license — this is the preprint, not the 2018 PLoS Biology version. A generic summary that conflates the two would miss any peer-review-induced changes.
2. **Houston 1960 and Louisiana 1953–1955 are pre-OPV-era natural-infection household studies**, not OPV trials. Using them to parameterize OPV transmission requires the within-host model to translate WPV transmission parameters into the OPV regime — a non-trivial inferential bridge that a generic summary would gloss as "USA data."
3. **The UP/Bihar 2003–2008 fit is the only modern, poor-sanitation OPV-era anchor.** The entire claim that OPV "blocks transmission locally in poor sanitation" hinges heavily on this single setting, since the USA data are from an era and sanitation regime now extinct.

## Prompt 5 — What would be dangerous to overclaim

From this bundle:

- It would be dangerous to claim the paper proves bOPV cross-protection against type 2 is *zero* or *negligible* — the abstract sentence is truncated at "insufficient to block" and the magnitude/quantitative threshold is not recoverable from the slice.
- It would be dangerous to claim quantitative R0, vaccine efficacy, or shedding-duration numbers because none of the Methods, Results, parameter values, or fit statistics are in the bundle.
- It would be dangerous to claim the paper makes specific policy recommendations about OPV2 reintroduction risk; the abstract sets up the post-2016 cessation context but the policy conclusions are not in the visible slice.
- It would be dangerous to claim the model is validated against any outcome other than the three named datasets (Houston, Louisiana, UP/Bihar).

## Prompt 6 — Which author claims are not well-supported by the data presented

Cannot answer from this arm's evidence. The bundle exposes only abstract-level claims and the supplement TOC; the Results section, parameter fits, residuals, sensitivity analyses, and figures that would let me assess support-vs-claim alignment are not visible. Specifically missing: the actual fit quality plots for Houston/Louisiana/UP-Bihar, parameter posterior ranges, and any out-of-sample validation.

## Prompt 7 — Which claims depend on external literature/assumptions/registry/expert judgment

From what is visible:

- The "75 years of polio literature" synthesis claim is by construction dependent on external literature; the S1 explicitly has a section "Part B.1   Sources of data on shedding and oral susceptibility to infection" indicating a curated external evidence base.
- The translation of pre-OPV household-transmission studies (Houston 1960, Louisiana 1953–1955) into the OPV-era inference depends on the within-host model assumptions described in Part B, and on the assumption that the "OPV-equivalent NAb" scale is a faithful common currency across studies, serotypes, and assays.
- Reference [21] (Asturias et al. 2016, Lancet) on bOPV+IPV schedules and reference [20] (truncated, Lancet Infectious Diseases 2015 phase-4 non-inferiority trial) are cited in the visible tail — the paper depends on these external trials for at least some of its bOPV cross-immunity inferences.
- The choice of Uttar Pradesh and Bihar as the canonical "poor sanitation" exemplar reflects expert judgment about generalizability that the slice does not justify in-text.

## Prompt 8 — Connection to KB themes

- **Mechanistic over narrative**: The paper is explicitly mechanistic — it builds a within-host model (shedding duration, stool concentration, oral susceptibility, waning) and couples it to a transmission model rather than telling a narrative about OPV success. The S1 TOC structure (Part B within-host → Part C transmission) is a textbook two-scale mechanistic decomposition.
- **Surveillance as measurement**: The three transmission datasets (Houston 1960, Louisiana 1953–1955, UP/Bihar 2003–2008) are surveillance / household-study artifacts being repurposed as measurements of transmission rate; the paper's epistemic move is to treat archival surveillance as quantitative measurement, not anecdote.
- **Multi-scale modeling**: Explicit. Within-host (Part B) → between-host close-contact transmission (Part C) → population-level OPV cessation risk landscape (main text framing). This is the canonical multi-scale polio modeling pattern.
- **Continuous immunity**: The "OPV-equivalent antibody titer (NAb)" as an "individual correlate of immunity" is a continuous-immunity construct — immunity is represented as a graded titer, not a binary protected/susceptible state, and waning is treated as its own model component (Part B.5).

## Uncertainty

- Only ~3200 chars of two PDFs totaling ~380,000 chars are in the bundle; ~99% of the source text is unseen.
- The abstract's key second clause about bOPV cross-immunity is truncated mid-sentence.
- Whether the file is the bioRxiv preprint, an intermediate revision, or a copy of the final PLoS Biology 2018 typeset paper with the bioRxiv watermark retained is ambiguous from the slice alone.
- Table A's body is truncated after the first row; the parameter table is effectively invisible.
- No figures are seen.

## Prohibited inferences (what I refused to claim)

- I did not claim any quantitative parameter values, R0 estimates, shedding durations, or vaccine efficacy numbers.
- I did not claim how the truncated "insufficient to block" sentence completes.
- I did not claim what policy recommendations the Discussion makes.
- I did not claim the paper has been peer-reviewed at PLoS Biology based on the slice alone — the visible header is the bioRxiv preprint deposit.
- I did not claim what additional supplements (S2, S3, ...) may or may not exist beyond S1.
- I did not import external knowledge about polio, OPV, or the Famulare et al. work outside what the slices contain.
