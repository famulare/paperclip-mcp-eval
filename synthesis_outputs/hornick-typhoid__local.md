---
case_id: hornick-typhoid
arm: local
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: hornick-typhoid | Arm: Local PDF

## Retrieval validity status

**Status: RETRIEVAL FAILED — content not assessable from local PDF slices.**

All three PDF slots are present as files, but OCR/text-extraction yielded essentially no substantive content:

- **1966 slot** (`Hornick_1966_Study_of_induced_typhoid_fever_in_man._I._Evaluati.pdf`): 7 pages, **7 chars, 1 line** of extracted text. The head slice is effectively empty (blank). This is a scanned image PDF with no embedded text layer accessible to the extractor.
- **1970 slot** (`Hornick_Snyder_1970_Typhoid_fever_pathogenesis_and_immunologic_Part_2.pdf`): 8 pages, 2704 chars, 25 lines. The entire extracted text consists solely of repeating NEJM archive watermark boilerplate ("The New England Journal of Medicine / Downloaded from nejm.org at UC SHARED JOURNAL COLLECTION on March 30, 2015 / From the NEJM Archive. Copyright © 2010..."). No body content extracted.
- **2008 reprint slot** (`Hornick_R._B._Snyder_2008_Typhoid_Fever_Pathogenesis_and_Immunologic_Control.pdf`): 6 pages, 1944 chars, 19 lines. Identical pattern — only NEJM archive watermark boilerplate from UNIVERSITY OF VIRGINIA download. No body content extracted.

The local PDFs are pre-1980 NEJM scans whose only machine-extractable text is the modern archive watermark overlay; the underlying article text is image-only and was not OCR'd before extraction. **The synthesizer therefore has zero access to the scientific content of these papers via the local-arm bundle.**

## Available context

What is recoverable from the slices, with no inference beyond it:

- Three distinct files exist on disk, corresponding to a **1966** publication titled (per filename) *"Study of induced typhoid fever in man. I. Evaluati[on]..."*, a **1970** publication titled *"Typhoid fever pathogenesis and immunologic [control] Part 2"* by Hornick and Snyder, and a **2008** item titled *"Typhoid Fever Pathogenesis and Immunologic Control"* by Hornick and R. B. Snyder.
- The 1970 and 2008 PDFs both came from the NEJM Archive (the 2008 file is therefore most plausibly a re-served archival reprint of the same Hornick & Snyder NEJM article, not a new 2008 paper — but this is **inference from filename and watermark only**, not from the article body, which is inaccessible).
- The target identifier from the bundle header is **PMID 4916913, N Engl J Med 1970**.

Nothing about study design, subject numbers, dose, inoculum strain, attack rates, antibiotic regimens, immunologic findings, conclusions, or any quantitative result is present in the extracted text.

## Prompt 1 — Central mechanistic claim

**Cannot assess.** The body text of all three PDFs is absent from the local slices (only watermark boilerplate and a blank head slice were extracted). No mechanistic claim can be identified from filename metadata alone without inferring content the bundle does not contain.

## Prompt 2 — Evidence cited for the claim

**Cannot assess.** No evidence statements, tables, dose-response data, subject counts, or experimental protocols are present in the extracted text.

## Prompt 3 — Hidden detail a careful reader would catch

**Cannot assess from local arm.** The only "hidden detail" recoverable is meta-level and watermark-derived: the 2008 PDF and the 1970 PDF appear to be archival copies of the same NEJM paper, downloaded from different institutions (UC Shared Journal Collection vs. University of Virginia) on different dates (2015-03-30 vs. 2013-12-04). The "2008" in the filename is most likely a copyright/repagination year on the NEJM Archive rather than a new publication — but again, this is filename/watermark inference, not body-content evidence.

## Prompt 4 — What a domain expert would notice that a lay reader would miss

**Cannot assess.** The scientific content is not accessible.

## Prompt 5 — Most dangerous overclaim if quoted out of context

**Cannot assess.** No claims are present to evaluate for overclaim risk. (A general caveat applies: the underlying Hornick studies belong to a mid-20th-century literature of deliberate human pathogen challenge in incarcerated/institutional populations, where any specific mechanistic or efficacy quote read in 2026 carries ethical and external-validity context that the local arm cannot supply — but stating this requires going beyond the bundle, which the synthesizer rule forbids.)

## Prompt 6 — Unsupported claims in the paper itself

**Cannot assess.** No claims extracted.

## Prompt 7 — Where the paper depends on external literature

**Cannot assess from extracted text.** No reference list, citation, or background-literature sentence was recovered.

## Prompt 8 — Connections to KB themes

**Cannot assess from local arm content.** Any KB-thematic connection (e.g., to dose-response modeling, challenge-study ethics, typhoid carriage dynamics, vaccine efficacy estimation) would have to be sourced from the case identifier (Hornick typhoid challenge studies) rather than from the local PDF text, which is the data this arm is restricted to. Per synthesizer rule, no such external-knowledge link is asserted here.

## Uncertainty

- **Extraction-layer uncertainty: maximal.** Three PDFs, ~4.6 KB of extractable text combined, of which essentially 100% is repeated archival watermark. Zero body sentences. No figures, tables, abstracts, or section headers were recovered.
- **File-identity uncertainty: low-moderate.** Filenames are specific enough to identify the papers in principle, but they cannot substitute for content. The pairing of the 1970 and 2008 files as the same underlying article is an inference, not a verified fact from the slices.
- **All eight evaluation prompts return "cannot assess"** for the local arm. This is itself an evaluation result: it characterizes the local arm's failure mode on pre-1980 image-only NEJM scans, not a deficiency in the underlying scientific work.

## Prohibited inferences (explicitly NOT made here)

The synthesizer rule restricts answers to the local PDF text slices. The following were available as temptations but **deliberately not used**:

- Background knowledge of the Hornick Maryland House of Correction typhoid challenge studies (subject population, ID50 estimates, vaccine arms, ethical context).
- Knowledge of the standard typhoid pathogenesis model (oral inoculum → ileal Peyer's patches → mesenteric lymph nodes → bacteremia → reticuloendothelial colonization → secondary bacteremia and clinical illness).
- Knowledge of how this paper is cited in the modern challenge-study and dose-response literature.
- Comparative reading against the MCP-arm or web-search-arm bundles for the same case.

If any of the above appears in this synthesis, it is a violation of the local-arm rule and should be flagged.

---

**Bottom line:** The local arm cannot evaluate this case. The PDFs are scan-only with no embedded text layer; without an OCR pre-pass, the bundle contains no science. This is a substantive negative finding about the local-retrieval pipeline's behavior on pre-1980 scanned medical literature, even though it produces no answers to the eight prompts.
