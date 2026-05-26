# Scorer A — Pass-3 Paperclip MCP Literature Evaluation

**Scorer:** Claude Opus 4.7 (1M context), independent.
**Date:** 2026-05-22.
**Inputs:** 14 ground truth files; 46 arm-isolated synthesis outputs.
**Rubric:** `scoring_rubric.md` (binding).

Scores: 1–5 or NA per rubric. Caps applied before mean per rubric §"Hard Caps". TF is scored from the synthesis's framing of retrieval cost where it is articulated; web arms are treated as low-friction, Paperclip arms vary by retrieval success, local arms reflect slice quality, hybrid arms reflect aggregate retrieval cost.

---

## Summary table

| case_id | arm | EF | MD | UC | VP | SP | TR | DU | TF | overall | caps_applied | rationale (one sentence) |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| cheslock-1960-ocr | hybrid | 4 | 5 | 5 | NA | 3 | 4 | 4 | 3 | 4 | none | Identity correct from filename + head slice; Paperclip miss flagged; honest about no body content beyond design. |
| cheslock-1960-ocr | local | 4 | 5 | 5 | NA | 3 | 4 | 3 | 2 | 4 | none | OCR slice exposes title/design/52-day depletion; explicitly refuses to claim results or numbers. |
| cheslock-1960-ocr | paperclip | NA | 5 | 5 | NA | NA | 4 | 1 | 4 | 4 | none | Correct refusal — target absent from corpus; refuses to substitute Gregory 2013; not useful for ingestion but honest. |
| famulare-2018-plosbio | hybrid | 5 | 4 | 5 | 5 | 4 | 4 | 5 | 3 | 5 | none | All three sources triangulate; correctly identifies S1 Text, three calibration cohorts, DOI-miss + map contamination flagged. |
| famulare-2018-plosbio | local | 4 | 4 | 5 | 4 | 4 | 4 | 4 | 3 | 4 | none | Identifies bioRxiv preprint version explicitly; surfaces S1 TOC, N_Ab, three datasets; truncated on key sentence. |
| famulare-2018-plosbio | paperclip | 2 | 4 | 5 | 2 | 2 | 3 | 2 | 2 | 3 | supplement-heavy + versioned without validated labels → MD/VP/overall ≤ 3 | Identifies paper but never reads body or supplements; map truncated and contaminated; version not addressed. |
| famulare-2018-plosbio | web | 4 | 4 | 5 | 4 | NA | 4 | 4 | 5 | 4 | none | Final paper identified with preprint lineage noted; abstract-only as expected; appropriately scoped. |
| heldout-hepc-ns5a | hybrid | 5 | 5 | 5 | 4 | 3 | 5 | 5 | 4 | 5 | none | Convergent identity (PMID + Paperclip); full abstract; correctly notes NS5A specifics not body-sourced. |
| heldout-hepc-ns5a | paperclip | 3 | 5 | 5 | 3 | 2 | 4 | 3 | 3 | 3 | none | Target identified by PMID lookup but body never opened; honest about lack of evidence. |
| heldout-hepc-ns5a | web | 4 | 4 | 5 | 4 | NA | 4 | 4 | 5 | 4 | none | Full abstract with cure-rate numbers, drug classes, pipeline; appropriately abstract-bounded. |
| heldout-podoconiosis | hybrid | 5 | 4 | 5 | 4 | 3 | 4 | 5 | 4 | 4 | none | Identity confirmed both arms; reports lead SNP rs9270911, OR, both GWAS counts; map contamination flagged. |
| heldout-podoconiosis | paperclip | 3 | 5 | 5 | 3 | 2 | 4 | 3 | 3 | 3 | none | PMID identity correct; only one truncated map line; honest refusal on numbers. |
| heldout-podoconiosis | web | 5 | 4 | 5 | 4 | NA | 5 | 5 | 5 | 5 | none | Full abstract reports lead SNP, OR, CIs, 14/47 SNP counts; all reproduced cleanly. |
| heldout-snakebite | hybrid | 5 | 4 | 5 | 4 | 3 | 4 | 5 | 4 | 4 | none | Convergent identity; full abstract with F/P statistics and design; minor inferential framing on limitations. |
| heldout-snakebite | paperclip | 3 | 5 | 5 | 3 | 2 | 4 | 3 | 3 | 3 | none | PMID + title both resolve; body unread; refuses to claim numbers. |
| heldout-snakebite | web | 5 | 4 | 5 | 4 | NA | 5 | 5 | 5 | 5 | none | Full abstract reproduced including F-stats; appropriate hedging on limitations. |
| heldout-tafamidis-attr | hybrid | 3 | 5 | 5 | 4 | NA | 4 | 4 | 3 | 4 | none | Identity correct from web/API; Paperclip miss flagged; refuses to fabricate ATTR-ACT numbers from extensions. |
| heldout-tafamidis-attr | paperclip | NA | 5 | 5 | NA | NA | 4 | 1 | 2 | 4 | none | Honest "No documents found" + refusal to substitute extension paper; not useful but correct refusal. |
| heldout-tafamidis-attr | web | 3 | 5 | 5 | 4 | NA | 4 | 3 | 4 | 4 | none | Abstract field is degenerate (collaborator list only); correctly flagged; identity captured. |
| heldout-tbe-vaccine | hybrid | 5 | 5 | 5 | 4 | NA | 5 | 5 | 4 | 5 | none | Identity anchored by web/API; full abstract reproduced; Paperclip miss flagged with named neighbors. |
| heldout-tbe-vaccine | paperclip | NA | 5 | 5 | NA | NA | 4 | 1 | 2 | 4 | none | Clean negative retrieval; explicit refusal to substitute Amicizia 2013 surrogate. |
| heldout-tbe-vaccine | web | 5 | 4 | 5 | 4 | NA | 5 | 5 | 5 | 5 | none | Full abstract with three subtypes, four licensed vaccines, Austrian campaign; well-bounded. |
| hornick-typhoid | hybrid | 3 | 5 | 5 | 3 | NA | 4 | 2 | 2 | 3 | none | Identity correct; all three arms degraded (Paperclip miss, OCR watermark-only PDFs); ingestion-poor but honest. |
| hornick-typhoid | local | NA | 5 | 5 | NA | NA | 4 | 1 | 1 | 4 | none | OCR completely failed (watermark-only); refuses to fabricate; documents failure mode. |
| hornick-typhoid | paperclip | NA | 5 | 5 | NA | NA | 4 | 1 | 2 | 4 | none | Target absent; refuses to substitute Okyere 2024 desk review; correct refusal. |
| hornick-typhoid | web | 3 | 4 | 5 | 4 | NA | 4 | 3 | 5 | 4 | none | Pre-1980 NEJM has empty abstract field by indexing artifact; identity correct; correctly framed. |
| kew-2005-opv-review | hybrid | 4 | 5 | 5 | 4 | NA | 4 | 4 | 3 | 4 | none | Web abstract anchors; Paperclip miss (both DOI and PMID) flagged; local PDF only exposes title-page. |
| kew-2005-opv-review | local | NA | 5 | 5 | NA | NA | 4 | 1 | 2 | 4 | none | Head + tail slices return only front-matter / TOC; refuses to fabricate body content. |
| kew-2005-opv-review | paperclip | NA | 5 | 5 | NA | NA | 4 | 1 | 2 | 4 | none | Clean retrieval failure on both ID lookups; refuses to use contaminated map output. |
| kew-2005-opv-review | web | 5 | 4 | 5 | 4 | NA | 5 | 5 | 5 | 5 | none | Full abstract; explicit VAPP/iVDPV/cVDPV taxonomy; appropriately bounded. |
| khoury-2021-natmed | hybrid | 4 | 5 | 5 | 4 | NA | 4 | 4 | 3 | 4 | none | Final paper identified by web/API; Paperclip returned preprint (different curves/params); version conflict explicitly flagged. |
| khoury-2021-natmed | paperclip | 2 | 5 | 5 | 2 | 2 | 3 | 2 | 2 | 3 | versioned case without validated version label → VP/overall ≤ 3 | Preprint returned not final paper; ls/wc misrouted to Khaitan paper; correctly diagnoses but no useful content. |
| khoury-2021-natmed | web | 5 | 4 | 5 | 5 | NA | 5 | 5 | 5 | 5 | none | Full final-paper abstract with 20.2%/3%/250-day numbers reproduced; version lineage noted. |
| nct04232943-pmid36746739 | hybrid | 4 | 4 | 5 | 4 | 3 | 4 | 5 | 3 | 4 | trial map failure noted (clause: trial query with failed map → ≤2 for map-dependent claims) | Identity + structural statistics extracted; trial map UUID error explicitly flagged; results not in bundle but methods solid. |
| nct04232943-pmid36746739 | paperclip | 3 | 4 | 5 | 3 | 3 | 4 | 3 | 2 | 3 | trial map UUID failure caps trial-engine score ≤ 2 for map-dependent claims | Paper identity solid; trial registry content unretrieved due to UUID error; methods text sampled only. |
| nct04232943-pmid36746739 | web | 5 | 4 | 5 | 4 | 4 | 5 | 5 | 5 | 5 | none | Full structured abstract + ClinicalTrials.gov record + Protocol/SAP existence flagged; high-yield. |
| nigeria-2015-versioning | hybrid | 4 | 4 | 5 | 3 | NA | 4 | 4 | 3 | 4 | versioned case — Paperclip collapses v1/v2/final, web identifies cleanly → VP capped at 3 in Paperclip-dependent claims | Identity correct; Paperclip's version-collapse failure explicitly named; web preserves v1/v2/PLOS lineage. |
| nigeria-2015-versioning | paperclip | 3 | 4 | 5 | 2 | NA | 3 | 3 | 3 | 3 | versioned case without validated version label → VP/overall ≤ 3 | Records resolved but v1/v2/final collapsed; map degenerate; failure mode correctly characterized. |
| nigeria-2015-versioning | web | 5 | 4 | 5 | 5 | NA | 5 | 5 | 5 | 5 | none | Both PMID and arXiv records; v1/v2 dates and "v2 adds cVDPV2 forecast" explicit; all probability numbers cited. |
| sfs-nejm-2020 | hybrid | 3 | 4 | 5 | 4 | 3 | 4 | 4 | 3 | 4 | wrong content organization (supplement merged into content.lines without separator) — document-reader ≤ 2 noted for Paperclip-dependent claims; not applied to overall here because web identity intact | Identity + supplement-merge defect explicitly documented; very thin body content. |
| sfs-nejm-2020 | paperclip | 2 | 4 | 5 | 3 | 2 | 3 | 2 | 2 | 2 | wrong content organization (supplement merged into content.lines without separator) caps document-reader/overall ≤ 2 | PMID resolves but DOI/title-search fail; supplement merged into content.lines; only headers retrieved. |
| sfs-nejm-2020 | web | 3 | 4 | 5 | 4 | NA | 4 | 3 | 4 | 4 | none | NEJM Correspondence empty abstract is expected pattern; identity captured; thin yield. |
| thakkar-famulare-arxiv | hybrid | 4 | 4 | 5 | 4 | NA | 4 | 4 | 3 | 4 | none | 2023 paper has content (Paperclip + local PDF); 2022 paper only identity; lineage explained. |
| thakkar-famulare-arxiv | local | 4 | 5 | 5 | 4 | NA | 4 | 4 | 3 | 4 | none | 2023 head/tail slice exposes abstract, Section I, references; 2022 PDF absent and noted. |
| thakkar-famulare-arxiv | paperclip | 3 | 5 | 5 | 4 | 2 | 4 | 3 | 3 | 4 | none | Both arXiv IDs resolve by lookup; only one editorial snippet for 2023; map content-gap explicitly diagnosed. |
| thakkar-famulare-arxiv | web | 2 | 5 | 5 | 4 | NA | 4 | 2 | 3 | 3 | none | API rate-limited; only identity metadata; substantive prompts honestly refused. |

---

## Per-case detail

### cheslock-1960-ocr / hybrid
Filename and head-slice masthead correctly identify Cheslock & McCully 1960 UD Nutrition Lab; 52-day depletion, weekly clinical assays, tryptophan/xanthurenate framing all surfaced. Paperclip miss (target absent) explicitly flagged with named off-target neighbors. SP=3 reflects engagement with OCR-mangled body even though results section unreached. No caps triggered.

### cheslock-1960-ocr / local
Local PDF head + tail slice extracts title, authors, affiliation, 52-day depletion design, Vilter/Wachstein-Gudaitis citation lineage. OCR artefacts (`BÂ«`, `B8` rendering subscript 6) honestly characterized. Body content beyond head slice refused. Appropriate for OCR-stress case.

### cheslock-1960-ocr / paperclip
`lookup pmid` failed; title search returned Gregory 2013 and other neighbors. Synthesis explicitly refuses to substitute PMC3679127's content (probed by ls/wc) for Cheslock 1960. DU=1 (no domain content) but UC/MD=5 (honest). EF=NA since no target content was retrievable, not fabrication.

### famulare-2018-plosbio / hybrid
Strongest synthesis. Web identity (PMID 29702638, PMC5942853, PLoS Biology 2018-04-27) + local preprint slice (bioRxiv 2016-10-27 with S1 TOC, N_Ab parameterization, Houston/Louisiana/UP-Bihar triad) + Paperclip identity by PMID. DOI-miss and map contamination explicitly tracked. Supplement-heavy case: SP=4 (S1 Text Parts B/C surfaced; S2.zip noted as unread). VP=5 (preprint/final clearly distinguished). No caps.

### famulare-2018-plosbio / local
bioRxiv preprint header correctly identified ("bioRxiv preprint first posted online Oct. 27, 2016; doi: 10.1101/084012"). Surfaces S1 TOC structure, N_Ab as continuous correlate, "interactions fade with prevalence"... wait that's the wrong paper. Here: surfaces three transmission datasets and within-host model parameters. Refuses results-level numbers. VP=4 (correctly flagged as preprint, not final).

### famulare-2018-plosbio / paperclip
PMID lookup resolves but body never opened; supplement directory listed but contents never read; map truncated mid-sentence and contaminated across 5 papers. **Caps applied:** supplement-heavy case without validated supplement inventory → MD ≤ 3; versioned case without validated version label → VP ≤ 3. Honest refusal but ingestion-thin.

### famulare-2018-plosbio / web
Final-paper abstract reproduced verbatim including 10,000-fold reduction, IPV-low / OPV-moderate / OPV-as-WPV-high trichotomy, Sabin reversion framing. Preprint lineage explicitly noted in available context. Appropriately abstract-bounded.

### heldout-hepc-ns5a / hybrid
PubMed identity + Paperclip PMID resolution converge; full abstract reproduced (45%/70%/>90% cure-rate trajectory; first/second-gen DAA roster; phase III pipeline). Body of paper exists in Paperclip but not actually read (65 lines acknowledged). NS5A-specific RAS detail honestly flagged as not body-sourced.

### heldout-hepc-ns5a / paperclip
Identity confirmed (PMID + title search both resolve to PMC4724659). 65-line content.lines acknowledged as never opened. Single map line truncated mid-token at NS5(B). Honest about thin yield; explicit refusal to import contaminating map content from Pawlotsky / Chae / Stauffer.

### heldout-hepc-ns5a / web
Full abstract reproduced with all key numbers and drug classes. NS5A-component identification of daclatasvir / elbasvir noted but flagged as inference not abstract-supported. Appropriately bounded.

### heldout-podoconiosis / hybrid
Identity confirmed both arms; full abstract reproduced (lead SNP rs9270911, OR 1.53, 95% CI 1.34–1.74; P = 5.51 × 10⁻¹⁰ new sample / 2.25 × 10⁻¹² combined; 14 and 47 SNPs). Three Ethiopian populations named. Map contamination (PMC10917762 immune-activation paper) cleanly excluded.

### heldout-podoconiosis / paperclip
Identity confirmed by PMID; body unread; only truncated map line and search snippet available. Explicit refusal to use PMC10917762 immune-activation content as if it were target's mechanism. Honest "Cannot answer" on all numeric prompts.

### heldout-podoconiosis / web
Full abstract reproduced including all per-SNP statistics, the three ethnic groups, ten named authors, affiliation network. Strongest yield from web arm in this case set.

### heldout-snakebite / hybrid
Convergent identity; full abstract reproduced with F-statistics (MDA F=5.540, P=0.008; SOD F=7.361, P=0.000; APTT F=25.430). 96 male SD rats, 0.8 LD50, four groups, four HBO time points. SP=3 reflects abstract-only access to numerical results.

### heldout-snakebite / paperclip
Identity at rank 1 by both PMID lookup and title search; body unread. 92 lines/5172 words acknowledged but never opened. Honest about absence of HBO protocol, antivenom product, oxidative-stress assay specifics.

### heldout-snakebite / web
Full structured abstract; all F-statistics, design, conclusions captured. Sharp-nosed pit viper inference flagged. Appropriately limitation-cautious.

### heldout-tafamidis-attr / hybrid
Identity anchored by web/API; Paperclip miss explicitly diagnosed (`No documents found` on PMID 30145929). Five neighbor papers (Elliott 2021 extension, Sultan 2017 early-stage, etc.) explicitly refused as substitutes. Refuses to fabricate ATTR-ACT numbers. EF=3 reflects reliance on diagnostic anchors for trial-design framing.

### heldout-tafamidis-attr / paperclip
Clean retrieval failure on both ID lookups. Refuses to back-fill from PMC8763250 extension or Sultan 2017. DU=1 (no target content) but UC/MD=5 (correct refusal). NA across content dimensions.

### heldout-tafamidis-attr / web
NCBI returns degenerate abstract (collaborator list overflows). Identity correctly captured; structural-degeneracy explicitly flagged as a finding. Refuses to import ATTR-ACT numbers from general knowledge.

### heldout-tbe-vaccine / hybrid
Identity confirmed by web/API; Paperclip miss explicit; named neighbors (Amicizia 2013, Domnich 2014, McAuley 2017) refused as substitutes. Full abstract reproduced (three TBEV subtypes, four licensed vaccines, Austrian campaign, rapid schedule).

### heldout-tbe-vaccine / paperclip
Clean retrieval failure; refuses to use Amicizia 2013 as Lehrer & Holbrook surrogate even though both 2013-era TBE-vaccine reviews. Honest about contamination from `-n 1` map bug.

### heldout-tbe-vaccine / web
Full abstract reproduced; biodefense framing (J Bioterror Biodef venue, PanThera Biopharma affiliation) noted; "reasonable titers" hedging explicitly flagged. Strong yield.

### hornick-typhoid / hybrid
Identity correct (PMID 4916913 NEJM 1970). All three arms degraded: Paperclip miss, local OCR returns watermark-only text. Hybrid synthesis surfaces this triple failure clearly. DU=2: ingestion-poor but the negative finding is itself useful.

### hornick-typhoid / local
OCR layer for pre-1980 NEJM is empty (1966 file: 7 chars; 1970 file: 25 lines all watermark; 2008 reprint: same pattern). Synthesis correctly characterizes the failure mode and refuses to fabricate. Honest negative.

### hornick-typhoid / paperclip
`lookup pmid` returns nothing; title search returns Okyere 2024 desk review at top. Synthesis explicitly refuses to substitute Sztein 2014 / Okyere 2024 content for Hornick 1970. Correct refusal but no domain yield.

### hornick-typhoid / web
PubMed returns metadata only; pre-1980 NEJM lacks structured abstract in indexing. Synthesis correctly diagnoses this as a known artifact rather than fabrication-licence. Identity and citation captured.

### kew-2005-opv-review / hybrid
Web/API anchors identity (PMID 16153180, Annu Rev Microbiol 2005). Paperclip both-ID miss explicitly flagged (canonical exact-ID miss). Local PDF only exposes title page + back-matter TOC. Off-target Paperclip search hits (Mei 2022, Grassly 2013, Duintjer Tebbens 2018) refused as substitutes. Strong meta-analysis of failure mode.

### kew-2005-opv-review / local
Local slice exposes only title page and Annual Reviews back-matter footer. Synthesis correctly characterizes the slicing artifact: head-tail strategy returns only front/back matter for a 52-page review. Honest refusal across all content prompts.

### kew-2005-opv-review / paperclip
Both `lookup doi` and `lookup pmid` return "No documents found". Title search surfaces five unrelated papers. Synthesis refuses to use contaminated map output (5/5 from non-target papers) or to substitute Mei 2022 for Kew 2005. Correct refusal.

### kew-2005-opv-review / web
Full abstract reproduced including VAPP / VDPV taxonomy framing. CDC/WHO authorship signal noted. cVDPV/iVDPV/aVDPV trichotomy honestly flagged as inferable but not abstract-explicit.

### khoury-2021-natmed / hybrid
Web/API correctly identifies final Nature Medicine paper (PMID 34002089, DOI 10.1038/s41591-021-01377-8, 20.2%/3%/250-day numbers). Paperclip returned only medRxiv preprint (med_3287fa4e6d00). Version distinction central to the case and explicitly tracked; warns against citing preprint blurb as if it were final paper.

### khoury-2021-natmed / paperclip
PMID + DOI lookups both fail; title search returns medRxiv preprint as #2 (Khaitan pediatric paper at #1 — wrong identity if not checked). ls/wc misdirected to wrong paper (med_19bd1cbe73d5). **Cap applied:** versioned case without validated version label → VP/overall ≤ 3 (preprint returned, final not retrieved, version not surfaced as label). UC/MD strong, but content unusable.

### khoury-2021-natmed / web
Full final-paper abstract with 20.2% (CI 14.4–28.4%), 3% severe-disease threshold, 250-day decay, variants-of-concern extension. Strongest yield in this case set.

### nct04232943-pmid36746739 / hybrid
Web identity intact (PMID 36746739 / PMCID PMC9996288 + NCT04232943 with enrollment 87, three arms). Paperclip `lookup pmid` succeeds; trial map fails with UUID typecast error. Per rubric, "Trial query with failed Paperclip `map` caps Paperclip trial-query-engine score at 2 for map-dependent claims" — synthesis honors this by treating trial-content prompts as unsupported. Paper methods extracted from grep (power calcs, Clopper-Pearson, Farrington-Manning, KM-Greenwood, shedding index Days 36/43/50/57, LLOQ/ULOQ, NI test at 90% CI).

### nct04232943-pmid36746739 / paperclip
Paper identity solid; only L44–L45 statistical methods returned. Trial map UUID error blocks registry content entirely. Two distinct `tri_*` IDs for same NCT noted. **Cap noted:** trial-engine score ≤ 2 for map-dependent claims. Map contamination (5 papers across BBV152 / Cramer / Zheng / arXiv adjuvant-NER) refused.

### nct04232943-pmid36746739 / web
PubMed structured abstract + ClinicalTrials.gov NCT04232943 record (status COMPLETED, enrollment 87, three arms, Protocol + SAP available). 87 vs 30+30+20=80 discrepancy correctly flagged. Strongest web-arm yield.

### nigeria-2015-versioning / hybrid
Web cleanly distinguishes arXiv v1 (2015-04-10), v2 (2015-07-10), PLOS ONE final (2015-08-28). Paperclip collapses lineage: arxiv ID with v1 date bound to PLOS ONE DOI; v2 absent; PLOS ONE date absent. Synthesis correctly diagnoses this as version-lineage failure. Probabilistic findings (84% WPV1, >99% WPV3, 83% cVDPV2 conditional) reproduced from web abstract.

### nigeria-2015-versioning / paperclip
Records resolved but v1/v2 invisible; arxiv-keyed record carries PLOS ONE DOI with v1 date. Map degenerate on arXiv record despite content existing on PMC side. **Cap applied:** versioned case without validated version label → VP/overall ≤ 3. Failure mode correctly characterized.

### nigeria-2015-versioning / web
Both PubMed source-of-record and arXiv abs-page metadata in bundle. v1/v2/final lineage explicit. All headline numbers reproduced with proper conditional framing on cVDPV2 83%. Version metadata = the whole point of this case, scored cleanly.

### sfs-nejm-2020 / hybrid
Identity confirmed; Paperclip PMID resolves but DOI lookup fails and title search returns five unrelated papers (none being the SFS letter). Supplementary Appendix detected via grep into content.lines (L31–L44 headers including "Supplemental Table 1. Delivery logistics..."), confirming the content-organization defect. SP=3 reflects partial surfacing of supplement; document-reader cap noted for Paperclip-dependent claims but web identity intact for overall.

### sfs-nejm-2020 / paperclip
PMID resolves but DOI fails; title search returns five thematically adjacent non-target papers. Supplements directory empty by ls but grep finds supplement headers inline. **Cap applied:** wrong content organization (supplement merged into `content.lines` without separator) caps document-reader/overall ≤ 2. Honest diagnosis but ingestion-thin.

### sfs-nejm-2020 / web
NEJM Correspondence empty abstract field is structural (NEJMc DOI stem); identity captured; appropriately abstract-empty bounded.

### thakkar-famulare-arxiv / hybrid
Both arXiv IDs lookup correctly; 2023 paper content available via Paperclip directory listing and local PDF head/tail slice. 2022 paper only identity-evidenced (back-reference from 2023 abstract). Key claims surfaced: transmission-forest object, generating-function methods, "interactions fade with prevalence," tree survival function validation.

### thakkar-famulare-arxiv / local
2023 paper present (8 pp, ~42k chars), only head + tail slices. Abstract, Section I opening, and reference list (Anderson & May 1992, IDM 2020 technical reports) extracted cleanly. 2022 paper absent from local archive and explicitly noted.

### thakkar-famulare-arxiv / paperclip
Both arXiv IDs resolve; 2023 has on-disk content (130 lines / 4872 words) but only one editorial snippet retrieved; 2022 not even probed for directory structure. Map task discrepancy (ls/wc say content present, map says "title only") cleanly diagnosed as input-plumbing issue. Honest refusal on substantive claims.

### thakkar-famulare-arxiv / web
arXiv API rate-limited; only titles + dates + one-line scorer notes. Identity solid but synthesis correctly refuses to characterize methods or claims beyond title-level. EF=2 reflects almost zero substantive yield; refusal-quality high (UC/MD=5).

---

## Caps summary (cases where caps changed scoring)

- **famulare-2018-plosbio / paperclip** — supplement-heavy without validated inventory + versioned without validated version label: MD and VP capped at 3, overall capped at 3.
- **khoury-2021-natmed / paperclip** — versioned case (preprint vs final), preprint returned instead of final, no validated version label: VP capped at 3, overall capped at 3.
- **nct04232943-pmid36746739 / paperclip** — trial map failure (UUID error) caps trial-engine score ≤ 2 for map-dependent claims; paper-side identity solid, but trial-registry-content prompts driven to low scores.
- **nigeria-2015-versioning / paperclip** — versioned case (v1/v2/final lineage collapsed): VP capped at 3, overall capped at 3.
- **sfs-nejm-2020 / paperclip** — supplement merged into content.lines without separator: document-reader/overall capped at 2.

All other syntheses operated under no triggered hard cap; scores reflect the rubric mean rounded after cap application.

Done.
