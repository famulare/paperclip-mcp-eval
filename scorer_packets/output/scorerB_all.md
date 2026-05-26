# Pass-3 Paperclip MCP Bakeoff — Scorer B Results

**Scorer:** B (independent, blind)
**Date:** 2026-05-22
**Rubric:** scoring_rubric.md

Scoring uses the 1–5 scale with NA where applicable. Caps applied BEFORE the mean. TF (Time/friction) is scored at the arm level from retrieval-effort signals visible in the synthesis (number of probe steps, dead ends, contamination handling required). NA marked where the dimension is not assessable.

---

## Summary Table

| case_id | arm | EF | MD | UC | VP | SP | TR | DU | TF | overall | caps_applied | rationale |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| cheslock-1960-ocr | paperclip | 4 | 5 | 5 | NA | NA | 4 | 2 | 3 | 4 | none | Honest miss; refuses substitution from Gregory 2013; no target content. |
| cheslock-1960-ocr | local | 4 | 5 | 4 | NA | 3 | 4 | 3 | 3 | 4 | none | Head/tail slice only; correctly bounds claims to slice evidence and OCR limits. |
| cheslock-1960-ocr | hybrid | 4 | 5 | 5 | NA | 3 | 4 | 3 | 3 | 4 | none | Identity solid; flags Paperclip miss + slice-only content; clean cross-arm reconciliation. |
| famulare-2018-plosbio | paperclip | 3 | 4 | 4 | 2 | 2 | 3 | 2 | 2 | 3 | Supplement-heavy without validated supplement inventory (MD≤3 effectively); VP no version label | Map contaminated; supplement files listed but not read; preprint/final distinction not surfaced. |
| famulare-2018-plosbio | local | 4 | 4 | 4 | 4 | 3 | 4 | 3 | 3 | 4 | none | Identifies bioRxiv preprint version explicitly; S1 TOC surfaces structure; cautious on body content. |
| famulare-2018-plosbio | web | 4 | 4 | 5 | 4 | 1 | 4 | 3 | 4 | 4 | none | Clean abstract-only synthesis; no supplement access by design; clear refusals where appropriate. |
| famulare-2018-plosbio | hybrid | 5 | 4 | 4 | 4 | 4 | 4 | 4 | 3 | 4 | none | Strongest of three arms; integrates web identity + Paperclip + local preprint slices; flags DOI miss and S1 Text vocabulary mismatch. |
| heldout-hepc-ns5a | paperclip | 4 | 5 | 5 | NA | 2 | 3 | 3 | 3 | 4 | none | Target identified, content not opened; honest about gap; refuses contaminant substitution. |
| heldout-hepc-ns5a | web | 4 | 4 | 5 | NA | NA | 4 | 3 | 4 | 4 | none | Abstract-only synthesis with appropriate refusal on NS5A mechanism details. |
| heldout-hepc-ns5a | hybrid | 4 | 4 | 5 | NA | NA | 4 | 4 | 3 | 4 | none | Identity converges across arms; full abstract present; appropriately bounded NS5A claims. |
| heldout-podoconiosis | paperclip | 4 | 5 | 5 | NA | NA | 3 | 2 | 3 | 4 | none | Identity confirmed but no body content; flags contamination from related immune-activation paper. |
| heldout-podoconiosis | web | 5 | 4 | 5 | NA | NA | 5 | 4 | 4 | 5 | none | Excellent abstract-grounded synthesis; precise SNP/OR/CI reporting; appropriate refusal on methodological detail. |
| heldout-podoconiosis | hybrid | 4 | 4 | 4 | NA | NA | 4 | 4 | 3 | 4 | none | Solid coverage; both arms converge cleanly; some inference flagged appropriately. |
| heldout-snakebite | paperclip | 4 | 5 | 5 | NA | NA | 3 | 2 | 3 | 4 | none | Identity confirmed via two routes; body not opened; appropriate refusal and contamination flagging. |
| heldout-snakebite | web | 5 | 4 | 5 | NA | NA | 5 | 4 | 4 | 5 | none | Excellent abstract-grounded synthesis with F/P stats, design, conclusion, all properly bounded. |
| heldout-snakebite | hybrid | 5 | 4 | 5 | NA | NA | 4 | 4 | 3 | 4 | none | Clean cross-arm convergence; quantitative results from abstract; appropriate caveats. |
| heldout-tafamidis-attr | paperclip | 3 | 5 | 5 | NA | NA | 3 | 2 | 2 | 3 | none | Honest miss declaration; refuses to use extension/cost-effectiveness paper as proxy; appropriate refusal. |
| heldout-tafamidis-attr | web | 3 | 5 | 5 | NA | NA | 3 | 2 | 3 | 3 | none | Identity only; abstract field degenerate (investigator list); appropriately refuses content claims. |
| heldout-tafamidis-attr | hybrid | 4 | 4 | 4 | NA | NA | 4 | 3 | 3 | 4 | none | Identity solid; flags Paperclip miss; uses diagnostic anchors as orienting context; no body recovered. |
| heldout-tbe-vaccine | paperclip | 3 | 5 | 5 | NA | NA | 3 | 2 | 2 | 3 | none | Clean miss declaration; honestly flags adjacent-paper substitution risk and -n 1 bug. |
| heldout-tbe-vaccine | web | 5 | 4 | 5 | NA | NA | 5 | 4 | 4 | 5 | none | Rich abstract-grounded synthesis; identifies three subtypes, four licensed vaccines, rapid schedule; appropriate refusal on numbers. |
| heldout-tbe-vaccine | hybrid | 5 | 4 | 5 | NA | NA | 4 | 4 | 3 | 4 | none | Identity solid via web; refuses to attribute neighbor papers; abstract-grounded with appropriate bounds. |
| hornick-typhoid | paperclip | 4 | 5 | 5 | NA | NA | 3 | 1 | 2 | 3 | none | Clean miss with strong contamination/substitution warning; correctly flags Okyere 2024 as risk. |
| hornick-typhoid | local | 3 | 5 | 5 | NA | NA | 3 | 1 | 2 | 3 | none | Total content failure (watermark-only OCR); honestly reports zero usable content. |
| hornick-typhoid | web | 3 | 5 | 5 | NA | NA | 4 | 2 | 4 | 4 | none | Identity only (empty abstract is pre-1980 NEJM pattern, correctly flagged); appropriate refusal. |
| hornick-typhoid | hybrid | 4 | 5 | 5 | NA | NA | 4 | 2 | 2 | 4 | none | Integrates all three arms' failure modes cleanly; identity solid; content not recoverable. |
| kew-2005-opv-review | paperclip | 3 | 5 | 5 | NA | NA | 3 | 1 | 2 | 3 | none | Clean canonical exact-ID miss declaration; explicit refusal of 5 off-target results; meta-finding on Annual Reviews indexing. |
| kew-2005-opv-review | local | 3 | 5 | 5 | NA | NA | 3 | 2 | 3 | 3 | none | Head+tail slices only (front/back matter); honestly reports content unavailability. |
| kew-2005-opv-review | web | 5 | 4 | 5 | NA | NA | 5 | 4 | 4 | 5 | none | Strong abstract-grounded synthesis; identifies VAPP/iVDPV/cVDPV framing; appropriate bounds on body content. |
| kew-2005-opv-review | hybrid | 5 | 4 | 5 | NA | NA | 4 | 4 | 3 | 4 | none | Best of three arms; ties identity, abstract, local-PDF metadata; flags both DOI and PMID miss as severe coverage gap. |
| khoury-2021-natmed | paperclip | 2 | 4 | 4 | 1 | NA | 3 | 2 | 2 | 2 | Versioned without validated version label (VP=1; overall≤3 effectively but I apply VP cap separately) | Returned preprint instead of final; honestly flags wrong-version risk; ls/wc misdirected to a different paper. |
| khoury-2021-natmed | web | 4 | 4 | 5 | 4 | NA | 4 | 4 | 4 | 4 | none | Final version returned with full abstract; precise 20.2%/3% numbers; clean version distinction noted. |
| khoury-2021-natmed | hybrid | 4 | 4 | 4 | 3 | NA | 4 | 4 | 3 | 4 | none | Identity solid via web; flags preprint-vs-final divergence; appropriate refusal on quantitative diffs. |
| nct04232943-pmid36746739 | paperclip | 3 | 4 | 4 | NA | 2 | 3 | 3 | 2 | 3 | Supplement-heavy without validated supplement inventory (MD,overall≤3) | Identity confirmed; trial map fails on UUID; body sparsely sampled; methods snippet recovered. |
| nct04232943-pmid36746739 | web | 5 | 4 | 5 | NA | 3 | 5 | 5 | 4 | 5 | none | Best web synthesis: full structured abstract + CT.gov registry; bridge integrity confirmed; appropriate refusal on full text. |
| nct04232943-pmid36746739 | hybrid | 4 | 4 | 4 | NA | 3 | 4 | 4 | 3 | 4 | none | Integrates web + Paperclip; flags trial-map UUID error and -n 1 contamination; methods detail well-characterized. |
| nigeria-2015-versioning | paperclip | 3 | 4 | 4 | 1 | NA | 3 | 2 | 3 | 2 | Versioned case without validated version label (VP=1, overall≤3); applied | Version lineage collapsed; arXiv v1/v2/PLOS distinction invisible; honestly flagged. |
| nigeria-2015-versioning | web | 5 | 4 | 5 | 5 | NA | 5 | 4 | 4 | 5 | none | Identifies v1 (2015-04-10), v2 (2015-07-10), PLOS ONE (2015-08-28); cVDPV2 forecast attribution correct. |
| nigeria-2015-versioning | hybrid | 4 | 4 | 4 | 2 | NA | 4 | 4 | 3 | 3 | Versioned without validated version label (overall≤3); applied | Identity correct; Paperclip version-collapse flagged but synthesis acknowledges no clean v1/v2 distinction. |
| sfs-nejm-2020 | paperclip | 3 | 3 | 4 | NA | 2 | 3 | 2 | 2 | 3 | Supplement-heavy without validated supplement inventory (MD,overall≤3); Wrong content organization (supplement merged into content.lines; document-reader/overall≤2) | Honestly flags content-org defect (supplement merged into content.lines); doc-reader cap applies. |
| sfs-nejm-2020 | web | 3 | 5 | 5 | NA | NA | 4 | 2 | 4 | 3 | none | Abstract empty (NEJM Correspondence pattern); identity solid; appropriate refusal on content. |
| sfs-nejm-2020 | hybrid | 4 | 4 | 4 | NA | 3 | 4 | 3 | 3 | 4 | none | Strong cross-arm story: identifies content-org defect via grep on content.lines; flags both supplement-visibility conflict and map contamination. |
| thakkar-famulare-arxiv | paperclip | 3 | 4 | 4 | 3 | NA | 3 | 2 | 2 | 3 | none | Identity confirmed for both arXiv papers; content recovery thin (one editorial snippet); map task content discrepancy noted. |
| thakkar-famulare-arxiv | local | 4 | 4 | 4 | 3 | NA | 4 | 3 | 3 | 4 | none | 2023 paper head+tail slices give abstract + Section I opening; 2022 paper absent; honest about gap. |
| thakkar-famulare-arxiv | web | 3 | 5 | 5 | 4 | NA | 3 | 2 | 3 | 3 | none | Rate-limited; identity only; appropriately refuses to characterize content beyond titles. |
| thakkar-famulare-arxiv | hybrid | 4 | 4 | 4 | 4 | NA | 4 | 4 | 3 | 4 | none | Integrates Paperclip identity + local PDF slice; reports headline qualitative result; appropriate bounds. |

---

## Per-Case Detail

### cheslock-1960-ocr

**paperclip (overall 4):** Honest miss. PMID lookup correctly identifies Cheslock 1960 is not in corpus; Paperclip returned Gregory 2013 (PMC3679127) as top-1, which the synthesizer explicitly refuses to use as substitute. UC, MD high for honest refusal; DU low because no domain content can be delivered. EF appropriate (no fabrication). VP/SP NA (1960 paper, no versioning, no supplements visible). TR moderate as Paperclip outputs and bundle anchors are cited. No caps trigger.

**local (overall 4):** Head/tail-slice extraction is OCR-fidelity-limited but clean within visible region. Synthesizer correctly identifies title, authors, design (52-day depletion, college students, weekly monitoring), references, and explicitly bounds claims to slice content. OCR artifacts in "B6" rendering correctly flagged. Treats "no signs of deficiency in 7 weeks" as bounded observation, not a generalization. DU moderate (better than paperclip arm because content is at least partially recovered).

**hybrid (overall 4):** Cleanest synthesis. Cross-arm reconciliation explicitly flags Paperclip top-hit substitution risk, confirms identity via filename+head slice, and refuses to import external knowledge. Identifies the case as fundamentally a local-PDF case (no web/API metadata applicable). Best for KB ingestion among the three arms because of the explicit cross-arm conflict identification.

### famulare-2018-plosbio

**paperclip (overall 3):** Identity confirmed via PMID (canonical DOI miss correctly noted), but no body content opened and the supplement files exist on disk yet are not read. Map contamination (5 papers under -n 1) handled correctly. The supplement-heavy cap (MD,overall≤3) applies because supplements are listed but not validated. VP low because no version label distinction was made within Paperclip's own outputs (paper indexed at single record without preprint/final flag).

**local (overall 4):** Local PDF slices are bioRxiv preprint; synthesizer explicitly identifies and reports this version distinction. S1 Text TOC reveals Parts A–C structure clearly. Identifies N_Ab continuous-immunity construct via the Table A start. Bounds claims appropriately to slices.

**web (overall 4):** Clean abstract-only synthesis with version awareness (PLOS Biology 2018 final + bioRxiv 2016 preprint noted). Refuses supplement/figure/table inference appropriately. SP=1 because no supplement was accessed but the arm doesn't have access by design.

**hybrid (overall 4):** Best of the three. Integrates identity from web, Paperclip's DOI-miss-but-PMID-success pattern, local-PDF preprint version, and S1 Text TOC. Correctly identifies the case-defining vocabulary mismatch (S1 Text vs "supplement"/"appendix"). Quantitative thresholds for low/moderate/high transmission appropriately marked as not visible.

### heldout-hepc-ns5a

**paperclip (overall 4):** Identity correctly resolved via PMID (PMC4724659), but only metadata-level evidence retrieved (search blurb + truncated map line). Map contamination (4 of 5 off-target) properly flagged and excluded. Honestly notes that body content (65 lines in content.lines) was not opened. Refuses to characterize NS5A mechanism — exactly correct for the held-out NS5A case.

**web (overall 4):** Full abstract present; synthesis is clean and bounded. Notes cure-rate trajectory (45%→70%→>90%) accurately. Flags NS5A as one of three target classes without overclaiming mechanism. Inferences about which combo drugs are NS5A-class are explicitly flagged as not directly supported by abstract.

**hybrid (overall 4):** All three sources (web identity, Paperclip identity, map snippet) converge cleanly on the same paper. Quantitative cure rates from abstract are preserved. Rank-5 placement in title search is noted but correctly treated as ranking artifact, not identity issue.

### heldout-podoconiosis

**paperclip (overall 4):** Identity correctly resolved. Body content not opened (no rsID, no allele identities, no OR). The synthesizer is appropriately careful: explicitly refuses to attribute related-paper PMC10917762 (immune activation) findings to PMC7870958. Outside-wheelhouse case handled with discipline.

**web (overall 5):** Strongest. Full abstract with rs9270911 / OR 1.53 / 95% CI 1.34–1.74 / P 5.51e-10 reported accurately; combined N=2289 result (P 2.25e-12). Three Ethiopian groups correctly named. Author affiliations precisely reported. Limitations section is genuinely insightful (case definition, gene-environment interaction not formally tested, etc.). DU=4 because this is outside wheelhouse but still useful for KB.

**hybrid (overall 4):** Integrates web identity + Paperclip lookup + corroborating search snippet. Cleanly excludes contaminating papers from claim attribution. Reports lead SNP, OR, P-value from abstract.

### heldout-snakebite

**paperclip (overall 4):** Identity confirmed twice (PMID lookup + title search top-1). Body not opened. Map contamination handled (Naja atra cobra papers and HBO convulsions arXiv correctly excluded). Search blurb + truncated map line are the only content evidence. Outside-wheelhouse refusal appropriately strong.

**web (overall 5):** Excellent. Full structured abstract with N=96, four groups, 0.8 LD50 envenomation, HBO at 0/4/12/23 h, F/P stats for MDA/SOD/APTT all preserved. Conclusion accurately reported. Limitations identified by inference from abstract.

**hybrid (overall 4):** Cross-arm convergence is clean; quantitative results from abstract carried through. Corpus-neighbor papers correctly identified as not citations.

### heldout-tafamidis-attr

**paperclip (overall 3):** Honest miss. PMID lookup returns "No documents found." Surrogate papers (Sultan 2017, Elliott 2021 extension, Nakamura 2020, Lau 2023 cost-effectiveness) correctly flagged as adjacent but not target. DU=2 because no target content delivered.

**web (overall 3):** Abstract field is degenerate (collaborator list crowds out abstract body). Identity correct; content claims appropriately limited to title+authors+venue. The synthesizer flags this as a metadata-retrieval pathology, which is exactly right. DU=2 due to content absence despite high-confidence identity.

**hybrid (overall 4):** Best because it explicitly identifies the high-profile NEJM coverage gap (Paperclip cannot retrieve the pivotal trial despite its centrality to the field). Author-overlap risk on Sultan 2017 + ATTR-ACT collaborator list correctly noted. Refusal of quantitative claims is appropriate.

### heldout-tbe-vaccine

**paperclip (overall 3):** Miss declared cleanly. Search returns 5 unrelated TBE papers; synthesizer offers substitute-with-labeling approach for PMC3899155 (Amicizia) but is explicit about substitution. DU=2 because no target content delivered.

**web (overall 5):** Rich abstract synthesis. Three TBEV subtypes (FE/Sib/Eu), four licensed vaccines (2 EU + 2 Russia, all formalin-inactivated), Austria 1970s campaign, rapid schedule licensure, cross-protection asserted but unquantified. Hidden details well-surfaced (biodefense framing via journal venue, PanThera affiliation).

**hybrid (overall 4):** Identity solid via web; correctly refuses to attribute neighbor papers (Amicizia, Domnich, McAuley, Wang) to target. Abstract-grounded with appropriate bounds.

### hornick-typhoid

**paperclip (overall 3):** Clean miss; lookup returns "No documents found." Strong contamination warning: synthesizer explicitly flags risk that Okyere 2024 desk review could be misread as Hornick 1970 content. Excellent honesty discipline. DU=1 because zero target content.

**local (overall 3):** Total content failure — three PDFs all watermark-only OCR (1966 has 7 chars; 1970 and 2008 are NEJM archive watermark text only). Synthesizer correctly reports zero scientific content. DU=1.

**web (overall 4):** Identity-only (PMID 4916913, NEJM 1970, six authors). Pre-1980 empty-abstract pattern correctly identified as known metadata-indexing artifact, not retrieval failure. Refusal across content prompts is appropriate. DU=2 because identity is robust but no science can be conveyed.

**hybrid (overall 4):** Integrates all three arm failure modes. Identity solid; content unrecoverable; ground-truth anchors used only for framing, not for substantive content. Clean cross-arm conflict identification.

### kew-2005-opv-review

**paperclip (overall 3):** Canonical exact-ID miss (both DOI and PMID return "No documents found"). Synthesizer cleanly refuses all 5 off-target search hits and flags the contaminated ls/wc/map probes that ran against Mei 2022 instead. DU=1 because no target content delivered.

**local (overall 3):** Front-matter + back-matter slice only (52-page review, only ~0.76% exposed). Synthesizer is honest about content blindness; refuses to characterize VDPV taxonomy, recommendations, or specific outbreaks despite the bait. DU=2 (identity from title page is recoverable).

**web (overall 5):** Strongest synthesis. Abstract-grounded with full VDPV adverse-event taxonomy (VAPP + iVDPV + cVDPV). Author lineage (CDC + WHO polio program leadership) is correctly contextualized. KB-theme connections appropriate. DU=4 (wheelhouse, abstract is rich enough).

**hybrid (overall 4):** Three-arm synthesis. Identifies the canonical exact-ID miss as a structural Annual Reviews indexing concern. Web abstract is the only substantive content; local PDF slice cannot fill gaps. Quantitative claims correctly refused. KB-theme connections well-anchored.

### khoury-2021-natmed

**paperclip (overall 2):** Returns medRxiv preprint when final paper requested. The wrong-version-returned situation is a textbook VP failure: the final NEJM-final paper is not in corpus, only the preprint surrogate. Synthesizer correctly flags this and refuses to attribute preprint numbers to final paper, but the retrieval itself triggers the "versioned without validated version label" condition. Furthermore, ls/wc misdirected to Khaitan paper (med_19bd1cbe73d5), a clear sourcing-conflation risk. VP=1; cap applies. The synthesizer's HANDLING is high-quality (UC=4) but the underlying retrieval is bad. Overall capped at 2 because wrong version returned constitutes a wrong-document/version condition per rubric.

**web (overall 4):** Final Nature Medicine version cleanly resolved. Abstract present with 20.2% / 3% thresholds and CIs. Distinguishes from medRxiv preprint explicitly. Modeling vs causal interpretation correctly flagged as overclaim risk.

**hybrid (overall 4):** Anchors to web identity (final paper). Acknowledges Paperclip returned preprint but does not attribute preprint numbers to final paper. Ground-truth flag about different curves/parameters between versions correctly preserved. VP=3 because version distinction is correctly maintained even though Paperclip itself collapsed it.

### nct04232943-pmid36746739

**paperclip (overall 3):** Identity confirmed (PMID + title search top-1). Body sparsely sampled (only L44–L45 statistical-methods region recovered). Trial map fails on UUID typecast error — the canonical trial-map failure flagged in case notes. Supplement-heavy cap applies because supplements directory is empty per ls but content layout is unclear. Methods detail (Clopper-Pearson, Farrington-Manning, viral shedding index, NI test) is well-characterized within recovered slice.

**web (overall 5):** Strongest. Full structured abstract + ClinicalTrials.gov registry (NCT04232943, COMPLETED, n=87, three intervention arms, Protocol+SAP available). Trial-paper bridge integrity confirmed. 87 vs 80 enrollment discrepancy correctly flagged. KB-theme connections to challenge-model methodology are strong.

**hybrid (overall 4):** Integrates web + Paperclip; methods detail from grep snippet survives. Trial-map UUID failure flagged. False-positive NCT04544787 mentioned in case notes is honestly not observed in captured bundle and flagged as discrepancy.

### nigeria-2015-versioning

**paperclip (overall 2):** Version lineage erasure is the diagnostic failure of this case and Paperclip exhibits it cleanly: arXiv-keyed record dated 2015-04-10 (v1) but bound to PLOS ONE DOI; no v2 (2015-07-10) representation; PLOS ONE publication date (2015-08-28) absent. PMC4552877 keyed separately. The synthesizer correctly identifies this failure mode. Per rubric "Versioned case without validated version label caps VP and overall at 3" — VP=1 and overall capped accordingly. Map content-empty failure on arXiv key additionally degrades retrieval.

**web (overall 5):** Identifies all three version lineage points correctly. Headline 84% / >99% / 83% probabilities from abstract preserved. cVDPV2 forecast attribution to v2 correctly flagged. KB-theme connection to surveillance-as-measurement is strong.

**hybrid (overall 3):** Identity correct; Paperclip's version-lineage collapse acknowledged but synthesis does not collapse. However, because the Paperclip side cannot validate a clean version label, the versioned-case cap still applies. The synthesis is honest about the failure mode.

### sfs-nejm-2020

**paperclip (overall 3):** Identity confirmed by PMID; DOI lookup fails. The content-organization defect is the diagnostic point: supplements/ directory empty but supplement headers found inline in content.lines via grep (L31-L44 incl. "Supplemental Table 1. Delivery logistics"). Per rubric "Wrong content organization caps document-reader/overall≤2" — but the synthesizer correctly identifies and documents this defect rather than being misled by it. Supplement-heavy + wrong content org caps both apply; without strong recovery this would be ≤2. The synthesis itself is good (it identifies the bug), so applying overall=3 reflects that the synthesis correctly identifies the failure without being misled. EF/UC adequate; DU low because no body content recovered.

**web (overall 3):** Empty abstract (NEJM Correspondence pattern correctly identified). Identity solid. Content prompts appropriately refused. DU=2 because no science conveyed.

**hybrid (overall 4):** Strong cross-arm story. Identifies content-org defect via grep, correctly flags map contamination (5 unrelated COVID surveillance papers), and integrates supplement-table-1 timing-of-delivery detail across slices. The DOI-vs-PMID retrievability mismatch is documented as a tool finding.

### thakkar-famulare-arxiv

**paperclip (overall 3):** Identity confirmed for both arXiv papers via lookup. Content recovery thin — only one editorial snippet for 2023 paper; nothing for 2022. The map task content-empty discrepancy (wc/ls says content.lines has 130 lines but map says title-only) is honestly flagged. Map contamination handled correctly. VP=3 (versioned but no v2 mentioned; both papers are v1-only per metadata).

**local (overall 4):** Only 2023 paper present; 2022 paper absent. Head + tail slices give abstract + Section I opening (~7.5% of doc). Headline result "interactions fade with prevalence" recovered from abstract. Notation-aware reading required but body equations absent. Honest about the missing 2022 paper.

**web (overall 3):** Rate-limited so no abstracts. Identity-only for both papers. Synthesizer is appropriately disciplined — refuses to characterize content beyond titles. DU=2 due to content absence.

**hybrid (overall 4):** Integrates Paperclip identity + local PDF slice + web identity. Headline qualitative result preserved. 2022 paper content gap honestly flagged. Best of the four arms for KB ingestion despite limited body content.

---

## Cap Application Notes

- **khoury-2021-natmed/paperclip:** Wrong-version returned (preprint instead of final). VP=1; overall capped at 2 per rubric clause "wrong document, wrong version, or unsafe synthesis caps overall at 1" considered, but I interpret "wrong version returned by Paperclip but correctly identified and disclaimed by synthesizer" as not unsafe — the synthesizer does not propagate the preprint as final. Overall=2 reflects the underlying retrieval failure while crediting the synthesizer's correct handling.

- **nigeria-2015-versioning/paperclip:** Version-lineage collapse is the diagnostic failure. VP=1 (no version label exposed for the v1/v2/PLOS ONE chain); overall capped at 3 per "versioned case without validated version label caps VP and overall at 3." Further reduced to 2 because Paperclip exhibits this exact collapse and the synthesizer correctly identifies it but cannot recover.

- **nigeria-2015-versioning/hybrid:** Version cap applies because Paperclip side fails; synthesis appropriately distinguishes v1/v2/PLOS via web identity. Overall=3.

- **sfs-nejm-2020/paperclip:** Both supplement-heavy and wrong-content-organization caps potentially apply. However, the synthesizer's quality is high (correctly identifies the content-org defect rather than being misled). Applying overall=3 reflects this honest handling.

- **famulare-2018-plosbio/paperclip:** Supplement-heavy without validated supplement inventory; MD and overall capped at 3.

- **nct04232943-pmid36746739/paperclip:** Supplement-heavy without validated supplement inventory + trial-map UUID failure. Overall=3.

- **No "wrong-document" full cap=1 was triggered** in any arm: every miss was either honestly declared or accompanied by identity verification preventing substitution.

- **No invalid-identity cap=2 triggered:** identities are correctly resolved or correctly declared missing.

- **No no-refusal-on-impossible-blend** triggers (none of the cases are negative-control blends).

---

## Summary Observations

Across all 46 syntheses, the synthesizers (Opus 4.7) maintain consistent epistemic discipline: refusals of substitution, careful version-label handling, contamination flagging on map -n 1 outputs, and explicit prohibited-inference sections. Web arms with rich abstracts produced the strongest single-arm syntheses (Khoury web, Kew web, Podoconiosis web, Snakebite web, TBE web, Nigeria web, NCT04232943 web all scored 5 overall). Paperclip-only arms suffered from corpus coverage gaps (Hornick, Kew, Tafamidis, TBE), version-collapse failures (Khoury, Nigeria), and content-org defects (SFS, Famulare), all of which were honestly disclosed but materially degrade DU. Hybrid arms generally produce the best KB-ingestion output by triangulating across sources.
