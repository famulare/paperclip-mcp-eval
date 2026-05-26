# Error Taxonomy (Pass 3)

**Origin:** Claude Opus 4.7 (1M context).

## Categories

- Exact identifier miss (DOI/PMID/PMCID/NCT/arXiv).
- Title search drift.
- Recency bias in semantic search.
- Wrong version returned.
- Preprint returned when final article was requested.
- Empty supplement directory when source-of-record supplements exist.
- Supplement content merged into main text without clear labeling.
- `content.lines` too large or too small for expected source.
- Trial `map` failure on `tri_*` IDs.
- False positive trial result.
- Figure/table missing from text synthesis.
- Old scanned article unavailable or OCR-poor.
- Review article treated as primary data.
- Unsupported claim converted into a confident mechanistic statement.
- `map -n N` does not honor the result limit (pass-3 confirmation).
- No refusal behavior on impossible-blend queries (pass-3 confirmation).
- Index scope: target class not indexed (pass-3 finding from probes).

## Observed Errors

| Error ID | Category | Case | Source Arm | Artifact Link | Severity | Notes |
|---|---|---|---|---|---|---|
| E01 | Exact identifier miss | famulare-2018-plosbio | Paperclip MCP | `retrieval_packets/famulare-2018-plosbio__lookup_doi.txt` | Medium | DOI lookup miss; PMID lookup hit. Pass-3 new finding: PMID-fallback works. |
| E02 | Exact identifier miss | kew-2005-opv-review | Paperclip MCP | `retrieval_packets/kew-2005-opv-review__lookup_doi.txt`; `lookup_pmid.txt` | High | Both DOI and PMID miss. Confirmed at miss-class level by index_scope_probes Annual Reviews 0/3. |
| E03 | Title search drift | kew-2005-opv-review | Paperclip MCP | `retrieval_packets/kew-2005-opv-review__search_title.txt` | High | Top 5 are polio-adjacent neighbors, none is Kew 2005. |
| E04 | Preprint returned when final requested | khoury-2021-natmed | Paperclip MCP | `retrieval_packets/khoury-2021-natmed__lookup_doi.txt`; `search_title.txt` | High | Final Nature Medicine DOI miss; title search returned medRxiv preprint at rank 2 (no flag indicating preprint vs final). |
| E05 | Empty supplement dir while merged-content present | sfs-nejm-2020 | Paperclip MCP | `retrieval_packets/sfs-nejm-2020__ls_supplements.txt`; `grep_supplement.txt` | High | supplements/ empty; content.lines contains '# Supplementary Appendix' header and 'Supplemental Table 1/2' references. Wrong-content-organization defect — triggers ≤2 cap on document-reader. |
| E06 | content.lines size suspicious for short paper | sfs-nejm-2020 | Paperclip MCP | `retrieval_packets/sfs-nejm-2020__wc.txt` | Medium | 249,687 chars / 3,475 lines for a 3-page NEJM correspondence — explained by E05 (supplement merged into content). |
| E07 | Trial map failure on tri_* IDs | nct04232943-pmid36746739 | Paperclip MCP | `retrieval_packets/nct04232943-pmid36746739__trial_map.txt` | High | `ERR: map: invalid input syntax for type uuid: "tri_7fa7a997858a"`. Triggers ≤2 cap on trial-engine. |
| E08 | Wrong version / version label missing | nigeria-2015-versioning | Paperclip MCP | `retrieval_packets/nigeria-2015-versioning__lookup_arxiv_1504_02751.txt` | High | Paperclip collapses arXiv v1, v2, and PLOS ONE final into a single record without version distinction. |
| E09 | Old scanned OCR-poor | hornick-typhoid | local PDF | `validation_logs/local_pdf_metrics.md` | High | 1966 PDF: 7 chars total; 1970 PDF: 1,926 chars (NEJM watermark only); 2008 PDF: 1,944 chars. No usable body content. |
| E10 | map -n N does not honor limit | (all cases tested) | Paperclip MCP | `retrieval_packets/famulare-2018-plosbio__map_n_probe.txt`; `nigeria-2015-versioning__map_n_probe.txt`; `heldout-*__map_n_probe.txt` | High | Pass-3 confirmation: `-n 1` consistently processes 5/5 or however many search results exist. Map outputs are contaminated by default. |
| E11 | No refusal behavior on impossible blends | neg-sfs-dmlt; neg-khoury-polio; neg-famulare-covasim-hornick | Paperclip MCP | `retrieval_packets/neg-*__probe.txt` | High | All 3 impossible-blend negative controls returned 4-6 plausible candidates with no refusal/uncertainty signal. Triggers system-wide ≤2 cap on cross-source-query-engine and trial-query-engine roles. |
| E12 | Index scope: Annual Reviews not indexed | kew-2005-opv-review (case); P01-P03 (probes) | Paperclip MCP | `index_scope_probes.csv` rows P01-P03 | High | 0/3 Annual Reviews papers (Microbiology, Immunology, Virology) resolved by DOI OR PMID, including PMC-versioned ones. |
| E13 | Index scope: Nature Medicine DOI-by-DOI miss | khoury-2021-natmed; P04-P06 (probes) | Paperclip MCP | `index_scope_probes.csv` rows P04-P06 | Medium | DOI lookup misses; PMID lookup hits when PMC version exists. 2/3 probed Nat Med papers resolved by PMID (P05, P06); P04 missed entirely. |
| E14 | Index scope: pre-1980 NEJM not indexed | hornick-typhoid; P07-P09 (probes) | Paperclip MCP | `index_scope_probes.csv` rows P07-P09 | High | 0/3 pre-1980 NEJM articles resolved. |
| E15 | Index scope: Lancet paywalled non-PMC not indexed | heldout-tafamidis (NEJM 2018 non-PMC); P10-P12 (probes) | Paperclip MCP | `index_scope_probes.csv` rows P10-P12 | High | 0/3 Lancet 2019 randomized trials (FLOT4 gastric, CASPIAN, KEYNOTE-048) resolved. ATTR-ACT NEJM 2018 (PMID 30145929) also missed. Confirmed paywalled-non-PMC miss class. |
