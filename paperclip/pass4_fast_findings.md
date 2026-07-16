# Pass 4 — Fast-Pass (retrieval-level) Findings, Paperclip v0.6.0

**Origin:** Claude Opus 4.8. Captured 2026-07-14 on branch `reprobe-pass4-v0.6.0`.
**Scope:** The **model-independent** probe layer from [`reprobe_plan_pass4.md`](reprobe_plan_pass4.md) §9 — mechanical Paperclip behaviors that need no synthesizer/scorer. These deltas are **directly attributable to Paperclip** (vs. pass 3, ~v0.4.2). Synthesis/scoring (Phases 6–7) not yet run.
**Method:** Live hosted MCP endpoint `https://paperclip.gxl.ai/mcp` via a bash mirror of [`../tools/Invoke-PaperclipMcp.ps1`](../tools/Invoke-PaperclipMcp.ps1) (no `pwsh` on this host). Raw verbatim outputs in [`evidence/pass4_probes/`](evidence/pass4_probes/) (40 packets, command + UTC timestamp headers).

---

## Headline

**All four pass-3 "plausibly fixable" product bugs are fixed. Every structural / "likely durable" limit stands, plus a newly-confirmed corpus-freshness limit and a breaking command-surface change.** The core recommendation (don't adopt as load-bearing; hybrid; PMC-anchored; verify externally) is unchanged; the *safe-use box* grows slightly (DOI/`map -n`/trial-`map` now usable) while a *new* unsafe condition appears (anything published after ~March 2026).

## Results

| # | Pass-3 finding | Issue | Pass-3 | Pass-4 (v0.6.0) | Verdict | Packet(s) |
|---|---|---|---|---|---|---|
| 1 | DOI lookup misses on in-corpus papers | [#5](https://github.com/GXL-ai/paperclip/issues/5) | 15/15 miss | Famulare, SFS, Nigeria DOIs all **resolve** to correct PMC/arXiv doc | **FIXED** | `doi_famulare`, `doi_sfs`, `doi_nigeria` |
| 2 | `map -n N` ignores N | [#6](https://github.com/GXL-ai/paperclip/issues/6) | 5/5 tasks on `-n 1` | `-n 1` → **1/1 tasks** (maps top-ranked paper); handles persist across calls | **FIXED** | `map_n_prior_handle`, `map_n_fresh_handle` |
| 3 | Trial `map` UUID cast error on `tri_*` | [#7](https://github.com/GXL-ai/paperclip/issues/7) | `ERR: invalid input syntax for type uuid` | `map` over `tri_7fa7a997858a` → **1/1 succeeded**, no error | **FIXED (v0.5.4 claim holds)** | `trial_nct04232943__map` |
| 4 | `map` also broke on `fda_`/`oa_` IDs | [#4](https://github.com/GXL-ai/paperclip/issues/4) | `fda_`/`oa_` cast error | `map` over `fda_ea84152acbd7` → **1/1 succeeded** | **FIXED (not narrow)** | `fda_pembro__map` |
| 5 | Supplement merged into `content.lines`; `supplements/` empty | [#8](https://github.com/GXL-ai/paperclip/issues/8) | broken | SFS `supplements/` still empty; appendix still at `content.lines` L31–L44 | **STILL BROKEN (open)** | `sfs_ls`, `sfs_ls_supp`, `sfs_grep_supp` |
| 6 | Annual Reviews not indexed | — | 0/3 | Kew (16153180) + Annu Rev Immunol 2023 w/ PMC (36750315) → **miss** | **DURABLE** | `idx_kew`, `idx_annrev_pmc` |
| 7 | Pre-1980 NEJM not indexed | — | 0/3 | Hornick 1970 (4916913) → **miss** | **DURABLE** | `idx_hornick` |
| 8 | Paywalled non-PMC not indexed | — | 0/3 | FLOT4 Lancet 2019 (30982686) → **miss** | **DURABLE** | `idx_lancet_flot4` |
| 9 | Preprint returned / final not in corpus | [#9](https://github.com/GXL-ai/paperclip/issues/9) | preprint at rank 2, final absent | NM final (34002089 / DOI) still **not in corpus**; medRxiv preprint returned with **no version/`supersededBy` flag** | **DURABLE** | `idx_khoury_final`, `khoury_pmc`, `khoury_medrxiv` |
| 10 | Version-lineage collapse | — | collapsed | Nigeria DOI resolves to a **single record** (arXiv v1 date + PLOS DOI) | **DURABLE** | `doi_nigeria` |
| 11 | No refusal on impossible blends | — | 3/3 no refusal | Impossible SFS×dmLT×polio blend → **5 ranked candidates, no refusal/uncertainty** | **DURABLE** | `neg_sfs_dmlt` |
| 12 | Multi-source filter honored? | [#13](https://github.com/GXL-ai/paperclip/issues/13) | (n/a in pass 3) | `search -s fda,trials "..."` → **6 papers, none from FDA or trials** (filter ignored) | **BROKEN** | `srcfilter_multi` |
| 13 | Corpus freshness | [#14](https://github.com/GXL-ai/paperclip/issues/14) | (n/a in pass 3) | arXiv coverage present through **2026-03**, absent **2026-04→07** | **NEW LIMIT CONFIRMED** | `fresh_arxiv_*` |

### Freshness ladder (arXiv, one real ID per month)

| Published | arXiv id | Result |
|---|---|---|
| 2025-09-30 | 2510.00358 | HIT |
| 2025-11-30 | 2512.01148 | HIT |
| 2025-12-31 | 2601.00140 | HIT |
| 2026-01-31 | 2602.00941 | HIT |
| 2026-02-28 | 2603.00841 | HIT |
| **2026-03-31** | 2604.01248 | **HIT** |
| **2026-04-30** | 2605.00298 | **MISS** |
| 2026-05 / 06 / 07 | 2605.31282 / 2606.31782 / 2607.11869 | MISS |

**Freeze boundary ≈ end of March 2026.** As of capture (2026-07-14) the corpus is ~3.5 months stale — corroborating #14 (`bw2`, "out-of-date by 4 months or more"). One paper per month; the clean HIT→MISS transition at March→April is robust.

## Command-surface change (breaks the pass-3 driver)

`search` now **requires** a `-s <source>` flag; the pass-3 form `search -t --all "..."` errors: *"Error: search requires a source flag (-s)."* (`search_famulare`). Sources are now explicit: `pmc, biorxiv, medrxiv, arxiv, abstracts, fda[/jp,/eu], trials[/us,/eu,/jp,/cn], proteins/uniprot`. Implications:

- Any Pass-4 full run must **patch [`Run-PaperclipRetrieval.ps1`](../tools/Run-PaperclipRetrieval.ps1)** (every `search -t --all` and the two `map_n`/`trial_map` re-search steps) before it will run.
- The v0.4.2 "all sources by default" behavior is **reversed** — there is no all-source search; multi-source scoping (`-s a,b`) exists syntactically but is **broken** (#12 in table). This narrows the cross-source-query-engine role rather than widening it.

## What this means for the recommendation

Per [`reprobe_plan_pass4.md`](reprobe_plan_pass4.md) §11 decision rule:

- **Upgrades (safe-use box grows):** source-resolver (DOI now usable alongside PMID); trial/paper-bridge (`map` works on `tri_`); the Map Contamination Rule can be **retired** (`-n` honored). Drop "DOI lookup is unsafe" from safe-use conditions.
- **Unchanged (headline drivers):** index scope (Annual Reviews / pre-1980 / paywalled-non-PMC), version-lineage collapse, no-refusal, and supplement-fidelity (#8) all stand. The corpus grew to a claimed 8M papers but the **class boundaries are identical**.
- **New unsafe condition:** corpus freshness — anything published after ~March 2026 is absent. For a KB-ingestion tool this is a live, first-order limitation that did not exist as a named finding in pass 3.

The pass-3 headline metrics (strict-A hybrid value **0/14**; Paperclip-arm Domain Usefulness **1.9/5**) are driven by the *structural* limits, all of which are unchanged or newly-worse. **The adoption decision does not flip.** A vendor that fixes surfaced product bugs quickly (good signal) but leaves corpus scope, version model, refusal behavior, and freshness untouched — and ships a breaking `search` change undocumented — remains a "thin PMID/DOI-confirmed PMC-skim layer inside a hybrid," not a load-bearing tool.

## Recommendation on the full re-run

The model-independent evidence above already answers the question you asked ("did the fatal limits change?"). A full Phase 6–7 synthesis + scoring re-run (46 syntheses × 2 scorers on Opus 4.8) would **refine role-level scores** (source-resolver, trial-bridge, and the map dimension of cross-source-query-engine all move up) but is **unlikely to move the adoption verdict**, because that verdict rests on the structural limits this fast pass shows are unchanged, plus the new freshness limit.

Suggested: **fold these fixes + the freshness finding into [`final_recommendation.md`](final_recommendation.md) as a dated "Pass 4 update" section**, and run the full synthesis/scoring only if you want refreshed per-role numbers for the record. If we do run it, patch the driver's `search` syntax first (above) and archive pass-3 artifacts per [`reprobe_plan_pass4.md`](reprobe_plan_pass4.md) §8.
