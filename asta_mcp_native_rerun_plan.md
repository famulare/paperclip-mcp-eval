# Deferred plan — Asta MCP-native snippet re-run

**Status:** ✅ EXECUTED 2026-07-16 — steps 1 & 2 done; verdict unchanged. Origin: Claude Opus 4.8, 2026-07-15.
**RESOLUTION (2026-07-16):** The original premise ("native snippet backend down") was **wrong** — `snippet_search` is **key-gated**: keyless → `ConnectionRefusedError`; with an `x-api-key` (the S2 key works) it succeeds. **Step 1 (equivalence): done** — closed-access = 0 snippets via Asta's own MCP too ([`asta_native_snippet_check.csv`](asta_native_snippet_check.csv)); the native path adds no licensed full-text beyond public S2, so the decision rule does **not** flip the verdict. **Step 2 (corpus-effect): done** — CS/arXiv 7/7, open-bio 4/4, paywalled 0/6 ([`asta_corpus_effect.csv`](asta_corpus_effect.csv)). The rest of this doc is retained as the original plan of record.

**Why this existed:** Stage-1 ([`asta_fast_findings.md`](asta_fast_findings.md)) first tested snippets via **Semantic Scholar direct** because Asta's native MCP `snippet_search` appeared down (`ConnectionRefusedError`) — later shown to be the missing key, not an outage. Asta's docs state its snippet tool *is* the S2 snippet index (both cite 12M full-text / 285M passages), and the native-path re-run confirmed equivalence.

## Precondition
- Asta MCP `snippet_search` responds (currently `ConnectionRefusedError`). Quick health check:
  `mcp__asta__snippet_search(query="poliovirus", paper_ids="PMID:26317401", limit=1)` — or via [`tools/Invoke-AstaMcp.ps1`](tools/Invoke-AstaMcp.ps1) `-Tool snippet_search`. If it returns a snippet (not a wrapped `ConnectionRefusedError`), proceed.
- Optional: an Asta API key in gitignored `.asta.key` (the tooling is already key-aware) in case the recovered backend rate-limits.

## What to run (≈30–40 calls, pace ≥1 req/s)
1. **Equivalence check (the core question).** Re-run the exact [`asta_snippet_coverage.csv`](asta_snippet_coverage.csv) probe (same 12 papers, same scoped queries) through **Asta's native `snippet_search`**. Compare snippet count + `kind` per paper against the S2-direct results.
   - **If equivalent** (closed-access still 0; body only for the same open papers) → the Stage-1 verdict stands unchanged; record confirmation and close.
   - **If Asta returns body snippets for closed-access papers that S2-direct did not** (i.e., Asta adds a full-text layer beyond the public S2 index) → this **could flip the gate**; escalate to reconsider the Stage-2 scored arm per the approved plan.
2. **Corpus-effect falsification probe** (bounds the negative finding; see [`asta_fast_findings.md`](asta_fast_findings.md) "Corpus effect"). Same probe over two out-of-corpus samples:
   - ~10–15 arXiv **cs.LG / cs.CL** papers (S2ORC-dense; expect high body-snippet hit rate).
   - ~10–15 recent **open-access bio** papers (PLOS / eLife / BMC).
   - Expectation to confirm: high body-snippet hit rate here vs ~0 for paywalled clinical/review papers ⇒ coverage is corpus-dependent, not a global ceiling.
3. Re-probe **P08 `PMID:111125`** via the native path (S2-direct returned HTTP 404 — a genuine miss; confirm consistency).

## Tooling (ready)
- Canonical: [`tools/Invoke-AstaMcp.ps1`](tools/Invoke-AstaMcp.ps1), [`tools/Run-AstaRetrieval.ps1`](tools/Run-AstaRetrieval.ps1), [`tools/Probe-AstaIndexScope.ps1`](tools/Probe-AstaIndexScope.ps1) (keyless graph; `-ApiKey`/`.asta.key`-aware; backoff+pacing built in).
- Execution mirrors (this host has no `pwsh`): `asta_call.py`, `s2_snippet.py`, `snippet_coverage.py`, `run_stage1.sh` in the session scratchpad — copy into `tools/` (or re-derive) for a persistent re-run.

## Decision rule
The adoption conclusion only changes if step 1 shows Asta's native snippet path materially out-covers S2-direct on **closed-access body text**. Absent that, [`asta_fast_findings.md`](asta_fast_findings.md) stands: Asta is a broad metadata/discovery layer, not a paywalled-full-text source for this KB, and no Stage-2 body-snippet arm is warranted.
