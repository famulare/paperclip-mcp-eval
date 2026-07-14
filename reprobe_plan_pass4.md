# Re-Probe Plan — Pass 4 (Paperclip v0.6.0)

**Origin:** Claude Opus 4.8. Drafted 2026-07-14 on branch `reprobe-pass4-v0.6.0`.
**Status:** DRAFT PLAN — not yet executed. No retrieval has run; `.paperclip.key` is absent (see Preconditions).
**Prior pass:** Pass 3 (Claude Opus 4.7), captured 2026-05-22 against Paperclip **~v0.4.2**. See [`methodology.md`](methodology.md), [`final_recommendation.md`](final_recommendation.md).

"Pass 4" is a load-bearing self-identifier, same as "pass 3": rules fixed here are predeclared before any pass-4 scoring. Changing them post-hoc invalidates pass-4 results.

---

## 1. Why re-run now

Pass 3 predeclared seven [triggers that would change the recommendation](methodology.md#L112) ("Evidence that would change the recommendation"). Between the pass-3 capture (2026-05-22) and today, several fired — but the vendor **documents changes shallowly**, so the trigger states can only be resolved empirically:

- The [changelog](https://paperclip.gxl.ai/changelog) advanced from ~v0.4.2 to **v0.6.0** (2026-07-09) across ~10 releases, mentioning **none** of the pass-3 defects by name (verified 2026-07-14: `map` appears; `DOI`, `-n`, `supplement`, version, `refuse`, `Annual Review`, `PMC`, `ranking` all absent).
- The public repo [`GXL-ai/paperclip`](https://github.com/GXL-ai/paperclip) is a **stale snapshot**: 5 commits total, 0 PRs, last push `b5571365 "Update to v0.4.2"` on 2026-05-22. All v0.4.3→v0.6.0 source is non-public. **No fix is verifiable in code or commit.**
- The issue tracker shows the maintainer **asserting fixes** for pass-3 findings (we filed #5–#9), with no linked commits.
- The repo description now advertises **"8M+ biomedical papers"** vs. v0.2.0's "3.4M+" — a ~2.3× corpus growth that could move the index-scope boundary independent of any bug fix.

Because both the product *and* (necessarily) the synthesizer/scorer model have changed since pass 3, this plan separates **model-independent probe findings** (mechanical Paperclip behavior — directly comparable pass 3 → pass 4) from **model-confounded synthesis scores** (see §9).

## 2. Change ledger since pass 3 (what we're testing against)

| Pass-3 finding | Artifact | Issue | Vendor claim | Pass-4 expectation to test |
|---|---|---|---|---|
| DOI lookup 15/15 miss | [final_recommendation.md:144](final_recommendation.md) | [#5](https://github.com/GXL-ai/paperclip/issues/5) | Closed COMPLETED — **no comment, no commit** | Claimed-fixed; **verify** |
| `map -n N` ignores N | [final_recommendation.md:149](final_recommendation.md) | [#6](https://github.com/GXL-ai/paperclip/issues/6) | Closed COMPLETED — **no comment, no commit** | Claimed-fixed; **verify** |
| Trial `map` UUID error on `tri_*` | [final_recommendation.md:148](final_recommendation.md) | [#7](https://github.com/GXL-ai/paperclip/issues/7) | "fixed as of **v0.5.4**" | Claimed-fixed; **verify** (and test `fda_`/`oa_` IDs per #4) |
| SFS supplement merged into `content.lines` | [final_recommendation.md:147](final_recommendation.md) | [#8](https://github.com/GXL-ai/paperclip/issues/8) | **OPEN** — "we'll look into it" | Expect still-broken; **confirm** |
| Title search preprint > final | [final_recommendation.md:146](final_recommendation.md) | [#9](https://github.com/GXL-ai/paperclip/issues/9) | Closed as **explanation not fix**: NM final "not in PMC" | Confirms PMC-anchoring; **confirm** |
| Annual Reviews / pre-1980 / paywalled-non-PMC not indexed | [index_scope_findings.md](index_scope_findings.md) | — | Untouched; but corpus grew 3.4M→8M | **Re-probe all classes** |
| Version-lineage collapse | [version_lineage.csv](version_lineage.csv) | — | Untouched | Expect still-broken; **confirm** |
| No-refusal on impossible blends (N=3) | [negative_controls.csv](negative_controls.csv) | — | Untouched | **Confirm + expand to N≥10** |

New limits surfaced by *other* users (add to pass-4 scope):

| New finding | Issue | State | Pass-4 probe |
|---|---|---|---|
| Corpus frozen ~February 2026 ("out-of-date by 4+ months") | [#14](https://github.com/GXL-ai/paperclip/issues/14) | OPEN | **New freshness probe** (§7) |
| `search -s fda,trials` multi-source filter silently ignored | [#13](https://github.com/GXL-ai/paperclip/issues/13) | Closed, "will patch next release" | **New source-filter probe** (§7) |
| Hosted MCP workspace mode not sticky across calls | [#12](https://github.com/GXL-ai/paperclip/issues/12) | OPEN | Out of scope (workflow, not retrieval) — note only |

## 3. Scope

**Full re-run = Pass 4.** Per the user's decision (vendor change-documentation is too shallow to trust a partial check). All 14 cases, all arms, all six roles, plus the expanded probe suite in §7. This regenerates Phases 2–7; Phase 1 (ground truth) is frozen except for newly-added probe targets (§6).

## 4. Preconditions / prechecks (do before any full run)

1. **Restore `.paperclip.key`** — currently absent at repo root (gitignored). Nothing runs without it.
2. **Pin the version.** Record `paperclip --version` (CLI) and the hosted-MCP server behavior at run time into a new `pass4_environment.md`. Pass 3 never recorded a version string; pass 4 must, so the next re-eval has a clean anchor.
3. **Smoke-test the invoker against v0.6.0.** [`tools/Invoke-PaperclipMcp.ps1`](tools/Invoke-PaperclipMcp.ps1) POSTs a `command` string to the hosted `https://paperclip.gxl.ai/mcp` endpoint — version-agnostic in transport, but **command syntax may have drifted**. Run one `lookup pmid 29702638` and one `search -t --all "..."` and confirm the response shape still parses. If the MCP `tools/call` schema changed, patch the invoker first.
4. **Verify command surface.** v0.4.3 "removed retired commands"; v0.5.0 added repo-mode `map`/`reduce`. Confirm these driver commands still exist and behave: `lookup doi|pmid|arxiv`, `search -t --all`, `search -s <source>`, `ls`, `wc`, `grep`, `map --from <sid> -n N`. Any renamed/removed command → patch [`Run-PaperclipRetrieval.ps1`](tools/Run-PaperclipRetrieval.ps1) and note the delta (a retired command is itself a finding).
5. **Decide artifact versioning** (§8) before writing any new rows — the observation CSVs are append-only.

## 5. Load-bearing invariants (unchanged from pass 3 — do not violate)

- **Ground-truth-first.** [`ground_truth/`](ground_truth/) is the answer key, built before retrieval, never patched from downstream findings.
- **Arm isolation.** Each arm's synthesis sees only its own bundle; enforced by [`tools/Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1). No hand-editing bundles.
- **Hard caps trigger on synthesis content, not arm name** ([scoring_rubric.md](scoring_rubric.md)).
- **Hybrid is a real arm**, never the max of single-arm scores.
- **Subagent roles.** Synthesizer and scorer are separate subagent calls, not the main thread (no outside-knowledge leakage).
- **No phase mutates a prior phase's evidence.** Pass-4 evidence is *new* evidence, versioned alongside pass 3 (§8) — it does not overwrite pass-3 packets in place.

## 6. Frozen vs. regenerated

| Phase | Pass-4 action |
|---|---|
| 1. Ground truth (14 cases) | **Frozen.** Re-use [`ground_truth/`](ground_truth/) unless a GT error is found (then fix from authoritative source + note, per invariant). |
| 1b. Ground truth for **new** probe targets | **New.** Freshness probes, expanded negative controls, and any new index-scope probes need GT built first (deterministic PubMed esearch, same as [`Select-HeldOut.ps1`](tools/Select-HeldOut.ps1) / [`Probe-IndexScope.ps1`](tools/Probe-IndexScope.ps1)). |
| 2. Paperclip retrieval | **Regenerate** all 14 cases → pass-4 packets. |
| 3. Local PDF slices | **Frozen** (local archive unchanged) — re-use [`validation_logs/local_pdf_slices/`](validation_logs/). |
| 4. Web/API ground truth | **Frozen** (lives in `ground_truth/`). |
| 5. Evidence bundles | **Regenerate** from pass-4 retrieval + frozen local/web evidence. |
| 6. Synthesis (subagents) | **Regenerate** — Opus 4.8 synthesizers, arm-isolated. |
| 7. Scoring (subagents) | **Regenerate** — two independent scorer calls; **anonymize this time** (§10). |

## 7. New / modified probe tooling

Four additions. Keep each as a standalone idempotent tool mirroring the existing pattern (header + timestamp packets + CSV rows).

### 7a. Freshness probe — `tools/Probe-Freshness.ps1` (NEW) — targets #14
Deterministic PubMed esearch for N papers per month, **March–July 2026** (post-freeze), restricted to PMC-versioned and arXiv-versioned targets (so a miss = freshness gap, not corpus-class gap). Look up each by PMID/PMCID/arXiv; record hit/miss by publication month. Output: `freshness_probes.csv` (`probe_id,pub_month,identifier,title,source,paperclip_cmd,hit_or_miss,notes`). **Locates the corpus freeze boundary** and tests whether #14 still holds.

### 7b. Source-filter probe — fold into `Run-PaperclipRetrieval.ps1` or standalone — targets #13
For each of `{fda, trials, fda,trials, pmc, all}`, run `search -s <spec> "<fixed query>"` and record which sources actually appear in results. Pass = requested sources honored; fail = filter ignored (as #13 reported). Relevant to the trial/paper-bridge and cross-source-query-engine roles.

### 7c. `cat --full` document-reader probe — fold into `Run-PaperclipRetrieval.ps1` — closes a pass-3 methodology gap
Pass 3 read content only via `wc content.lines` + `grep`; it **never used `cat --full`** (introduced v0.3.0). For every resolved paper, additionally capture `cat --full` and compare against `content.lines` for (a) supplement separation (directly re-tests #8 on SFS PMC7206929) and (b) whether full text now exposes `sections/`, `figures/`, supplement boundaries. This makes the document-reader role a fair test of the current command surface.

### 7d. Expanded negative controls — extend `negative_controls.csv` — fixes declared limitation #3
Add ≥7 impossible-blend queries (→ N≥10 total) and ≥2 near-miss, same strict grading (≥1 plausible candidate without refusal = fail). Firms up the system-wide no-refusal cap that pass 3 flagged as thin (N=3).

Existing tools reused unchanged (pending §4 syntax check): [`Run-PaperclipRetrieval.ps1`](tools/Run-PaperclipRetrieval.ps1), [`Probe-IndexScope.ps1`](tools/Probe-IndexScope.ps1), [`Build-EvidenceBundles.ps1`](tools/Build-EvidenceBundles.ps1), [`Compile-Scores.ps1`](tools/Compile-Scores.ps1), [`Test-Artifacts.ps1`](tools/Test-Artifacts.ps1).

## 8. Artifact versioning strategy (decide before running)

The observation CSVs are append-only and re-running a case requires pruning its prior rows. To keep pass-3 evidence intact (invariant: no phase mutates prior evidence) while producing clean pass-4 evidence, **recommended approach**:

- `git mv` the pass-3 observation CSVs and generated dirs into `pass3_archive/` **in a single commit on this branch** (retrieval_packets/, evidence_bundles/, synthesis_outputs/, scorer_packets/output/, and the observation CSVs: retrieval_observations, index_scope_probes, negative_controls, version_lineage, trial_reconciliation, supplement_inventory, synthesis_scores, hybrid_*). `ground_truth/`, `validation_logs/`, `corpus_registry.csv`, and the methodology/rubric docs stay in place (frozen inputs).
- Regenerate pass-4 artifacts in the original paths so all tools run unmodified.
- Pass-3 state also remains in git history at `main`/`62e59f5`, but the explicit `pass3_archive/` makes side-by-side diffing trivial and lets `Compile-Scores.ps1` emit a `pass3_vs_pass4_delta.csv`.

Alternative (lighter, more error-prone): add a `pass` column to each CSV and filter. Rejected — the tools don't emit it and it muddies the append-only contract. Prefer the archive-and-regenerate approach.

## 9. Attribution: what a pass-4 delta actually means

Two things changed since pass 3 (Paperclip version **and** synthesizer/scorer model 4.7→4.8). Attribute carefully:

- **Probe-level findings are model-independent** — DOI resolution, `map -n` honoring, trial-`map` UUID, index-scope hit/miss, freshness boundary, source-filter honoring, and negative-control refusal are mechanical Paperclip behaviors. **These deltas are attributable to Paperclip** and are the primary evidence for "was the bug fixed."
- **Synthesis scores are confounded** by the model change. A pass-3→pass-4 score shift could be Opus 4.8 synthesizing/scoring differently, not Paperclip improving. Report synthesis-score deltas **as confounded**; lean on probe-level deltas for the fix/no-fix verdict. (If Opus 4.7 subagents are still reachable, running one scorer pass on 4.7 would de-confound — treat as optional; see §12.)

## 10. Methodology improvements to fold in (fix pass-3's four declared limitations)

1. **Run the anonymization step this time** (limitation #1). Strip `arm:` from synthesis frontmatter and any arm-identifying rationale before scoring. Pass 3 skipped this; pass 4 makes scoring genuinely blind.
2. **Negative controls N≥10** (limitation #3) — §7d.
3. **Structural scorer independence** (limitation #1) — optionally run one scorer as a different model family (e.g., a non-Claude scorer) so the two passes aren't same-model sampling noise. Optional; flag if not done.
4. **Arm-isolation spot-check audit** (limitation #4) — randomly sample ~5 pass-4 bundles and confirm zero cross-arm leakage before synthesis.
5. **Held-out set** (limitation #2) — the current held-out set is 4/5 adjacent to wheelhouse. Pass 4 may re-run [`Select-HeldOut.ps1`](tools/Select-HeldOut.ps1) with stricter no-overlap MeSH to add ≥2 unambiguously-outside cases. Optional; changes corpus composition, so declare if done.

## 11. Decision rule — what flips the recommendation

Pass 4 updates [`final_recommendation.md`](final_recommendation.md) per these predeclared outcomes:

- **DOI (#5) verified fixed** (DOI resolves to same doc as PMID for in-corpus papers, ≥13/15 of the pass-3 set) → source-resolver role upgrades; drop "DOI lookup is unsafe" from safe-use conditions.
- **`map -n` (#6) verified fixed** (`-n 1` → 1/1 tasks on ≥3 source sets) → retire the Map Contamination Rule; upgrade cross-source-query-engine.
- **Trial `map` (#7) verified fixed** (no UUID error on `tri_*`; test `fda_`/`oa_` too) → trial/paper-bridge role upgrades.
- **Index scope narrowed** (Annual Reviews / pre-1980 / paywalled-non-PMC now hit) → the biggest structural upgrade; re-write the corpus-boundary sections.
- **Freshness (#14): corpus current to within ~1 month** → removes a new fatal limit for KB ingestion.
- **Refusal signal added** (impossible blends refused, ≥8/10) → cross-source-query-engine upgrades.
- **Any of #8 (supplements), #9 (version/PMC), version-lineage still broken** → those role scores and safe-use conditions stand unchanged.

The headline metric to recompute: **strict-A hybrid value count** (pass 3 = 0/14) and **Paperclip-arm mean Domain Usefulness** (pass 3 = 1.9/5). A material move in either is the signal that "adopt as load-bearing" deserves reconsideration.

## 12. Execution order

1. Preconditions §4 (key, version pin, smoke test, syntax check).
2. Archive pass-3 artifacts §8 (one commit).
3. Ground truth for new probe targets §6/§7 (freshness, expanded neg-controls).
4. Phase 2 retrieval: `Run-PaperclipRetrieval.ps1` (14 cases) + `Probe-IndexScope.ps1` + new probes §7a–§7d.
5. Phase 3 local slices: frozen (re-use).
6. Phase 5 bundles: `Build-EvidenceBundles.ps1`; spot-check §10.4.
7. Phase 6 synthesis: Opus 4.8 subagents, arm-isolated.
8. Phase 7 scoring: anonymize §10.1 → two scorer subagents → `Compile-Scores.ps1` → adjudicate.
9. Recompute headline metrics; write `pass4_findings.md` + delta table; revise `final_recommendation.md` and `methodology.md` (add a "Pass 4" section) per §11.
10. `Test-Artifacts.ps1`.

## 13. Open questions for the user (before execution)

1. **Scorer model** — pass 4 uses Opus 4.8 by default. Want the optional non-Claude second scorer for structural independence (§10.3), accepting added complexity?
2. **Held-out set** — keep the pass-3 corpus as-is for clean pass3↔pass4 comparability, or add unambiguously-outside cases (§10.5) and accept that corpus composition changed?
3. **Effort ceiling** — full re-run is the whole 14×~3.3-arm synthesis + 2 scorer passes over ~46 syntheses. Acceptable, or run a **retrieval-only fast pass first** (Phases 2 + probes only — the model-independent §9 findings) to get the fix/no-fix verdict cheaply, and only do full synthesis/scoring if a probe result actually moves?
