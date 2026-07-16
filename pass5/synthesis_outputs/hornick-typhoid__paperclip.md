---
case_id: hornick-typhoid
arm: paperclip
synthesizer: Claude Opus 4.8
---

# Synthesis: hornick-typhoid — Paperclip arm

## Retrieval validity

**The target document was never resolved.** The bundle requested "PMID 4916913 | N Engl J Med 1970" (a "Pre-1980 NEJM + OCR stress case"). The direct identifier lookup failed:

> `# command: lookup pmid 4916913` → `No documents found.`

No other probe in the bundle recovered the target. The `search`, `map`, `ls`, and `wc` outputs all concern **different papers**, none of which is the NEJM 1970 target:

- `search -t --all "Typhoid fever pathogenesis and immunologic control" -n 5` returned 5 hits, the closest by rank being "Risk factors for typhoid fever: A desk review" (`med_1d85b4706e45`, medRxiv, 2024-09-10). The other four are dated 2014–2023 (`PMC6160957` 2018, `arx_2310.09825` 2023, `PMC4209864` 2014, `PMC7549842` 2020). All post-date the 1970 target by decades and none is an NEJM article.
- `ls /papers/med_1d85b4706e45/` and `wc /papers/med_1d85b4706e45/content.lines` (240 lines / 13132 words) describe the 2024 medRxiv desk review, not the target.
- `map --from s_f5c17030 -n 1 "..."` returned **5/5 tasks** despite `-n 1`, confirming the documented behavior that "`map -n 1` does NOT honor the result limit" — the map ran across all 5 unrelated papers.

Consequently the bundle contains **no content, metadata, supplements, figures, tables, or version information for the actual target paper.** Every prompt below is answered against that fact. Per the arm-isolation rule, I do not import outside knowledge of what the 1970 NEJM paper says.

One retrieval-safety observation worth recording up front: the topic search returned 5 plausible-looking typhoid papers **with no flag that none matches the requested identifier and no refusal**, matching the bundle's warning that "Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target." The returned IDs (`med_1d85b4706e45`, `PMC…`, `arx_…`) do not match PMID 4916913.

## Prompt 1 — Central mechanistic claim

Cannot answer from this arm's evidence.

The target paper (PMID 4916913, NEJM 1970) was not retrieved (`lookup pmid 4916913` → "No documents found"), and no bundle probe surfaced its text. The papers that *were* returned are unrelated modern typhoid articles; their claims (e.g., that typhoid transmission "is driven by a multifaceted set of risk factors," or that eradication is "exceptionally challenging due to the emergence of multidrug-resistant (MDR)" strains) are not claims of the target paper. Missing: any content from PMID 4916913.

## Prompt 2 — Evidence supporting the claim

Cannot answer from this arm's evidence.

No data, methods, parameters, or analyses from the target paper are present. The only document with retrievable body statistics is `med_1d85b4706e45` (`wc … 240 13132 79607`), which is the 2024 medRxiv desk review, not the target. Missing: the target's full text, sections, or figures.

## Prompt 3 — Hidden detail (supplement / table / figure / protocol / registry)

Cannot answer from this arm's evidence.

The bundle exposes no target document, hence no supplement, table, figure, appendix, protocol, or registry field for it. The `ls /papers/med_1d85b4706e45/` listing (`meta.json  content.lines  (240 lines)  sections/  figures/`) belongs to the wrong paper and cannot substitute. The bundle also cautions that an "Empty /papers/<id>/supplements/ directory does not mean no supplements," but this is moot here because the target's directory was never located. Missing: any target-paper artifact inventory.

## Prompt 4 — Expert eye

Cannot answer from this arm's evidence about the paper's substance.

What a domain expert *would* notice about the retrieval itself: the target is a pre-1980 NEJM article (flagged as an "OCR stress case"), and Paperclip returned "No documents found" for its PMID while surfacing only post-2014 open-access/preprint typhoid papers. This is consistent with a corpus that does not index this document. But nothing about the target paper's own findings is recoverable here. Missing: the target text.

## Prompt 5 — Overclaim risk

The single most dangerous overclaim from this bundle would be to **treat any returned paper as if it were the target** — i.e., to answer questions about the NEJM 1970 typhoid paper using the 2024 desk review, the 2018 eradication review, the 2023 math-modeling preprint, the 2014 immunity review, or the 2020 eosinopenia study. The bundle's own guardrail applies directly: "Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target." Here the top hit's ID (`med_1d85b4706e45`) does not match PMID 4916913, and the topic query returned candidates with no refusal or mismatch warning.

Beyond that identity-substitution risk, nothing can be said about overclaiming the target paper's content, because none is present. (Cannot answer for the target's own claims.)

## Prompt 6 — Under-supported claims

Cannot answer from this arm's evidence.

No claims from the target paper are present to assess. Evaluating the returned unrelated papers would violate the "this paper" scope. Missing: the target text.

## Prompt 7 — External dependencies

Cannot answer from this arm's evidence.

Without the target document, its dependence on external literature, assumptions, registry context, or expert judgment cannot be determined. Missing: the target text.

## Prompt 8 — KB-theme connection

Cannot answer from this arm's evidence for any theme — the target paper was not retrieved.

- **Mechanistic-over-narrative:** Cannot answer from this arm's evidence.
- **Surveillance-as-measurement:** Cannot answer from this arm's evidence.
- **Multi-scale modeling:** Cannot answer from this arm's evidence.
- **Continuous immunity:** Cannot answer from this arm's evidence.

(Bundle silent on the target on every theme; the unrelated returned papers cannot be used to answer for "THIS paper.")

## Uncertainty

- I could not determine anything about the content, evidence, structure, supplements, version, or claims of the target paper (PMID 4916913, NEJM 1970): the direct lookup returned "No documents found" and no other probe recovered it.
- I cannot tell from the bundle *why* the lookup failed (e.g., not indexed, OCR/pre-1980 gap, or transient error). The case note labels it a "Pre-1980 NEJM + OCR stress case," but the bundle does not itself state a reason.
- The returned papers (`med_1d85b4706e45`, `PMC6160957`, `arx_2310.09825`, `PMC4209864`, `PMC7549842`) are confidently NOT the target based on ID mismatch, publication dates (2014–2024), and venues (medRxiv/PMC/arXiv, not NEJM 1970); I did not analyze their content because that is out of scope for "THIS paper."
- I did not attempt any additional retrieval; per the arm-isolation rule I report only what this bundle contains.
