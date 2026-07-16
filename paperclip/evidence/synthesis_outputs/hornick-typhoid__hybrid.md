---
case_id: hornick-typhoid
arm: hybrid
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: hornick-typhoid | Arm: Hybrid

## Retrieval validity status

**Mixed / partially failed.** Three sources combined, with conflicting signal across them:

- **Web/API identity (authoritative):** PubMed source-of-record confirms the target: PMID 4916913, DOI 10.1056/NEJM197009242831306, "Typhoid fever: pathogenesis and immunologic control," Hornick RB, Greisman SE, Woodward TE, DuPont HL, Dawkins AT, Snyder MJ, N Engl J Med 1970 Sep 24;283(13):686-91.
- **Paperclip retrieval (failed for target):** `lookup pmid 4916913` returned "No documents found." Title search for "Typhoid fever pathogenesis and immunologic control" returned 5 papers, none of them the Hornick 1970 paper — top hit is a 2024 medRxiv desk review (med_1d85b4706e45). The corpus does not contain the target paper. The `map -n 1` probe scoped from `s_f5c17030` produced summaries of unrelated typhoid papers, not Hornick 1970.
- **Local PDF slices (OCR-failed for target content):**
  - `hornick-typhoid__1966`: 7 pages, 7 chars total — effectively empty OCR.
  - `hornick-typhoid__1970`: 8 pages, 2704 chars, but the head slice is entirely composed of repeated NEJM watermark/header boilerplate ("The New England Journal of Medicine / Downloaded from nejm.org at UC SHARED JOURNAL COLLECTION on March 30, 2015..."). No body text is visible in the slice provided.
  - `hornick-typhoid__2008` (reprint): 6 pages, 1944 chars, same watermark-only pattern.

Net: **identity is established by web/API; no usable content evidence about the target paper's claims is present in either Paperclip or the visible PDF slices.**

## Available context

What this bundle gives me about the target paper:

- **Identity (from PubMed):** PMID 4916913; DOI 10.1056/NEJM197009242831306; title "Typhoid fever: pathogenesis and immunologic control"; six authors led by Hornick RB; NEJM 1970 Sep 24;283(13):686-91.
- **Diagnostic claim anchors (from ground-truth section of the bundle):** describes typhoid fever pathogenesis and immunologic control using human challenge experiments; pre-1980, older typography, OCR-poor in many digital copies; foundational reference for typhoid dose-response and challenge methodology.
- **Local PDFs exist** for what appear to be a 1966 companion paper, the 1970 paper itself, and a 2008 reprint — but the slices provided are watermark-only, with no body text.
- **Paperclip corpus** does not contain the target. It does contain adjacent typhoid literature (Sztein PMC4209864 on adaptive immunity to enteric fevers; Yang/Chong/Song PMC6160957 on eradication challenges; a medRxiv risk-factor review; an arXiv math model; an eosinopenia case-control study), but none of these can stand in for the Hornick paper's claims.

## Cross-arm conflicts

- **Identity vs Paperclip content:** Web/API and ground-truth confirm the target is Hornick 1970 NEJM. Paperclip returned five unrelated papers when asked to map "the central claim of THIS paper" — including a 2024 risk-factor review and a 2014 immunity review. Treating any of these `map` summaries as content evidence for Hornick 1970 would be a substitution error. **Flagged: Paperclip arm returned different papers than the target.**
- **PDF slot vs PDF content:** Filenames (`Hornick_1966_...`, `Hornick_Snyder_1970_..._Part_2.pdf`, `Hornick_R._B._Snyder_2008_...`) match the target family, but the OCR slices contain only header/watermark boilerplate. The slot metadata is correctly labeled; the extracted content is not usable. **Flagged: local-PDF arm has correct file identity but no usable text content.**
- **No conflict on identity itself:** All three arms point at the Hornick 1970 NEJM paper as the target; they disagree only on whether usable content was actually retrieved (web/API: yes for metadata, no for content; Paperclip: no; local PDF: file present, body text not in slice).

## 8 prompts

### Prompt 1 — Central claim of the paper

I cannot state the central claim from this bundle. The PubMed identity confirms the paper is about "typhoid fever pathogenesis and immunologic control," and the bundle's scorer-facing diagnostic anchors say it uses human challenge experiments and is foundational for typhoid dose-response and challenge methodology — but the abstract snippet provided contains only the citation header, not the abstract text, and the PDF slices contain only watermark boilerplate. Paperclip returned no matching document. **Cannot answer beyond the title-level paraphrase without inventing content.**

### Prompt 2 — Study design / methods

Not derivable from this bundle. The diagnostic anchors mention "human challenge experiments," consistent with the Hornick group's known program, but the bundle provides no body text describing inoculum, route, dose ladders, volunteer selection, or endpoint definitions. The 1966 PDF slot (likely the dose-response companion paper) is empty (7 chars). The 1970 and 2008 slot slices are watermark-only. **Cannot describe methods from arm evidence.**

### Prompt 3 — Key quantitative results

Not derivable. No numerical content (attack rates, ID50, incubation distributions, antibody titers) is present in any of the three arms' content. **Cannot answer.**

### Prompt 4 — Population / setting

Not derivable from arm content. Identity metadata places the paper in NEJM 1970 with US-based authors (Hornick, Greisman, Woodward, DuPont — known Maryland/Walter Reed/USAMRIID-era investigators by external knowledge, but that is outside the bundle and therefore prohibited as evidence here). The bundle itself does not state the volunteer population. **Cannot answer from arm evidence.**

### Prompt 5 — Comparators / controls

Not derivable. No methods text is present. **Cannot answer.**

### Prompt 6 — Limitations / caveats stated by authors

Not derivable. No discussion text is present in any arm. **Cannot answer.**

### Prompt 7 — Relation to prior / subsequent literature

The bundle's Paperclip search surfaces adjacent typhoid literature — a 2014 review by Sztein et al. on complex adaptive immunity to enteric fevers (PMC4209864) and a 2018 review by Yang/Chong/Song on eradication challenges (PMC6160957) — both of which, by their abstracts in the bundle, treat *S.* Typhi pathogenesis and immunity as continuing open problems. This is **circumstantial evidence** that the Hornick 1970 paper sits upstream of a continuing literature on typhoid pathogenesis and immunologic control, consistent with the ground-truth anchor calling it "foundational." But the bundle does not contain text in which any of those later papers explicitly cites or characterizes Hornick 1970. **Cannot make a sourced citation-level claim.**

### Prompt 8 — Bottom-line takeaway for a knowledge base

From this bundle, the durable takeaway is procedural rather than scientific:

1. The paper is correctly identified by PMID 4916913 / DOI 10.1056/NEJM197009242831306, NEJM 283(13):686-91, 1970 Sep 24, Hornick et al.
2. Topic per title: typhoid fever pathogenesis and immunologic control; per ground-truth anchors, based on human challenge experiments and foundational for typhoid dose-response and challenge methodology.
3. **No content claims about mechanism, dose, immunity, or outcomes can be supported from this bundle.** All three arms failed to deliver body text: Paperclip lacks the paper; local PDFs returned watermark-only OCR; the web/API snippet provided only the citation header. Any synthesis of the paper's scientific content would require either re-OCR of the PDFs or a different retrieval path.

## Uncertainty

- **Identity:** high confidence — corroborated by PubMed metadata in the bundle and by filename matches on the local PDFs.
- **Content (claims, methods, results, comparators, limitations):** unrecoverable from this bundle. Uncertainty is total at the content level; I have a title, six authors, a journal/date, and a one-sentence scorer anchor — nothing more.
- **Pre-1980 + OCR stress signal:** confirmed. The 1966 slot extracted 7 characters from 7 pages; the 1970 and 2008 slot slices show repeated header/watermark text and no body. This is the failure mode the case was constructed to expose.
- **Paperclip corpus coverage:** confirmed gap. The corpus does not contain Hornick 1970 under either PMID lookup or title search; nearest neighbors are recent reviews and a desk review, not the foundational paper.

## Prohibited inferences

I will not, from this bundle:

- Quote or paraphrase any specific claim from Hornick 1970 about challenge dose, attack rate, incubation period, immunity, or pathogenesis mechanism. None of those are in the arm evidence.
- Substitute the `map` summaries of the medRxiv desk review, the Yang/Chong/Song eradication review, the Sztein adaptive-immunity review, the arXiv math model, or the eosinopenia case-control study for content of the Hornick paper. Paperclip returned these as nearest matches, not as the target.
- Treat the filename of the 1966 PDF (`Hornick_1966_Study_of_induced_typhoid_fever_in_man._I._Evaluati.pdf`) as evidence about the 1970 paper's contents, or as evidence of the 1966 paper's contents (slice is effectively empty).
- Import external/prior knowledge about the Hornick/Maryland typhoid challenge program (volunteer numbers, ID50 estimates, strain identity, etc.) — that knowledge exists outside this bundle and the synthesizer rule forbids using it.
- Infer the paper's conclusions from the fact that later reviews exist in the Paperclip corpus. The bundle does not contain text linking those reviews to Hornick 1970.
- Treat the 2008 file as evidence of an updated/revised version; by filename and ground-truth context it is a 2008 reprint/archive copy of the 1970 paper, but the slice provides no text to confirm this.
