# Asta (Ai2) snippet-search — scoping notes vs. the Paperclip eval

**Status: EXPLORATORY. Not part of the Paperclip evaluation evidence chain.** No live Asta/Semantic Scholar API calls have been made. Numbers below are vendor claims (Ai2 marketing + MCP docs) recorded for later verification, not measured findings. Author: Claude Opus 4.8, 2026-07-15, under Mike's direction. Trigger: a colleague's question — *"what do you think of Asta from AllenAI and their ability to return snippets from the full text of the paywalled papers?"*

Scope of this pass (as instructed): (1) install the tooling, (2) write these thoughts. **No evaluation run yet.**

---

## 1. What "Asta" is, and which piece the question is about

Asta is Ai2's agentic-science ecosystem with three pillars: **Asta agents** (assistant that finds papers / summarizes literature / does limited data analysis), **AstaBench** (2,400+ problems / 11 benchmarks), and **Asta Resources** (developer toolkit). ([blog](https://allenai.org/blog/asta), [resources](https://allenai.org/asta/resources))

The colleague's question is about one specific Resources component: the **Asta Scientific Corpus Tool**, an **MCP wrapper over Ai2's Semantic Scholar Academic Graph (S2AG) infrastructure**. The graph is ~**225M+ papers / 80M+ authors / 2.4B+ citation edges**. ([resources](https://allenai.org/asta/resources), [MCP tool](https://allenai.org/asta/resources/mcp))

The capability being asked about is the `snippet_search` MCP tool (`search_snippet` in the S2 API / python client).

## 2. The paywalled-full-text claim — is it true? Mostly yes, with two caveats

**What the snippet endpoint does:** returns ~**500-word excerpts drawn from a paper's title, abstract, AND body text** (explicitly excludes figure captions and bibliography). Each result carries a relevance score, paper metadata (corpusId, title, authors), the snippet text, its `kind` (title/abstract/body), `section`, `offset`, and annotations. ([MCP tool](https://allenai.org/asta/resources/mcp))

**Coverage claim:** the snippet endpoint indexes **12M+ full-text publications, totaling 285M+ passages**. ([resources](https://allenai.org/asta/resources))

**Why it can reach paywalled papers:** S2 has **full-text licensing partnerships** with publishers, aggregators, and depositories (e.g. BioOne), on top of the open-access S2ORC corpus (10M+ OA full texts). Licensed full text is indexed for **search/snippet** even where Ai2 cannot redistribute the PDF. ([S2 about](https://www.semanticscholar.org/about), [BioOne partnership](https://medium.com/ai2-blog/semantic-scholars-partnership-with-non-profit-publisher-bioone-98220c8ae9da))

So the colleague is essentially right — **but two caveats matter for our use case:**

- **Caveat A — it's an excerpt, not the paper.** The generic S2 FAQ line "Semantic Scholar cannot access paywalled full texts / cannot unlock paywalled papers" is about *not handing you the full PDF*. Both things are true at once: you can get a **quotable ~500-word body-text passage** from a paywalled paper, but not the whole text, and not the tables/figures/supplements. For provenance-grade ingestion this is a **quote source, not a full-text source**.
- **Caveat B — coverage is a subset, ~12M of 225M (~5%).** Full-text snippet coverage is far smaller than the metadata graph. So "can it snippet *this specific* paywalled paper?" is **not answerable a priori** — it depends whether that title is in the 12M full-text index. This is the same *silent-coverage-boundary* UX problem we flagged for Paperclip (`../paperclip/index_scope_findings.md:38`), just at a different boundary.

## 3. Why this is directly relevant to what we cared about for Paperclip

The single biggest structural limitation in our Paperclip verdict is **corpus scope: PMC-anchored, silent outside PMC** — Annual Reviews 0/3, pre-1980 NEJM 0/3, paywalled-non-PMC (Lancet 2019 RCTs, NEJM 2018 ATTR-ACT) 0/3, all durable through v0.6.0 ([`../paperclip/index_scope_findings.md`](../paperclip/index_scope_findings.md), [`../paperclip/pass4_fast_findings.md:22`](../paperclip/pass4_fast_findings.md)). That is exactly the gap the colleague's question targets. Mapping Asta's snippet capability onto our rubric dimensions ([`../common/scoring_rubric.md`](../common/scoring_rubric.md)):

| Eval dimension (Paperclip) | Paperclip result | Asta snippet — expectation (UNVERIFIED) |
|---|---|---|
| **Index scope / paywalled non-PMC** | PMC-anchored; paywalled-non-PMC 0/3 miss | Plausibly the real differentiator — 12M full-text incl. licensed non-OA. **Must probe the exact Paperclip-miss classes.** |
| **Content you can quote** (`give me content I can quote`) | Full `content.lines` when in corpus | Only ~500-word excerpt + `section`/`offset`. Good *quote provenance*, but not full text. |
| **Supplement / table / figure fidelity (SP)** | Filesystem `supplements/`; #8 merge bug open | Snippets **exclude figure captions + bibliography**; no supplement model. Likely *weaker* than Paperclip here. |
| **Version/provenance fidelity (VP)** | Version lineage collapsed (durable) | S2 has per-record corpusId + externalIds (DOI/PMID/arXiv); preprint-vs-final handling **unverified**. |
| **Refusal on impossible blends** | No refusal (durable) | Relevance-ranked retrieval → almost certainly also returns ranked candidates without refusal, BUT the returned *passage + score* gives a downstream agent more to discriminate on. **Probe negative controls.** |
| **Identifier resolution** | PMID reliable; DOI fixed in v0.6.0 | S2 resolves DOI/PMID/arXiv/corpusId/ACL/MAG — multi-ID resolution is a strength. |
| **Freshness** | Frozen ≈ end of March 2026 (durable) | S2 refreshes regularly; `inserted_before` filter exists. Likely fresher; **unverified**. |
| **Integration / friction (TF)** | Hosted MCP | Hosted MCP too (`asta-tools.allen.ai`) + a mature python client. Comparable ergonomics. |

**Bottom line for the KB use case:** Asta's snippet search looks like it could plug the *exact* hole that made Paperclip a "thin PMC-skim layer" — **quotable evidence from paywalled, non-PMC literature**. But it's a **quote/passage tool, not a full-text/supplement tool**, so it complements rather than replaces the local-PDF arm. The interesting hypothesis to test: **does adding an Asta snippet arm turn some of our Paperclip-miss cases (Annual Reviews, Lancet RCTs, NEJM ATTR-ACT) from "silent miss" into "quotable hit"?** If yes, that's a material argument for adding it to the hybrid workflow.

## 4. Tooling installed (this pass)

- **`semanticscholar` 0.12.0** — installed/cached via uv. This is the community python client for the same S2AG endpoints Asta's Corpus Tool wraps, including the snippet endpoint. Reusable, no repo pollution, no venv to manage:
  ```bash
  uv run --with semanticscholar --python 3.12 python -c "..."
  ```
  Verified `SemanticScholar().search_snippet(...)` exists with signature:
  `search_snippet(query, paper_ids=None, authors=None, min_citation_count=None, year=None, venue=None, fields_of_study=None, fields=None, publication_date_or_year=None, limit=10)`.
- **Not installed (noted for later):** `astabench` 0.5.4 (PyPI) — the full benchmark harness; heavy, not needed for a targeted snippet-coverage probe. Repos: [`allenai/asta-bench`](https://github.com/allenai/asta-bench), [`allenai/agent-baselines`](https://github.com/allenai/agent-baselines).

## 5. Connecting to the live Asta MCP (VERIFIED 2026-07-15)

Correcting an earlier assumption: the docs imply an API key is mandatory, but **the endpoint works keyless for `initialize` and `tools/list`.**

- **Correct endpoint:** `https://asta-tools.allen.ai/mcp/v1` (Streamable-HTTP MCP; POST + JSON-RPC, `Accept: application/json, text/event-stream`). The **bare host `https://asta-tools.allen.ai/` 404s** — it's a server, not a webpage; don't try to open it in a browser.
- **Live + keyless:** direct `curl` handshake returned HTTP 200, `serverInfo: "Asta Scientific Corpus Tools" v1.12.3`, and a full `tools/list` **without any `x-api-key`**. Wire into Claude Code with:
  ```bash
  claude mcp add --transport http asta https://asta-tools.allen.ai/mcp/v1
  ```
- **8 tools exposed:** `get_paper`, `get_paper_batch`, `get_citations`, `search_authors_by_name`, `get_author_papers`, `search_papers_by_relevance`, `search_paper_by_title`, `snippet_search`. IDs accepted across tools: `sha`, `CorpusId:`, `DOI:`, `ARXIV:`, `MAG:`, `ACL:`, `PMID:`, `PMCID:`, `URL:` — multi-scheme resolution, a clear edge over Paperclip's PMID-first reliability.
- **`snippet_search` schema** confirms the capability verbatim: *"excerpts of approximately 500 words, drawn from a paper's title, abstract, and body text, but excluding figure captions and the bibliography."* Args: `query`, `limit` (default 20), `venues`, `paper_ids` (up to 100, any ID scheme above), `inserted_before`.
- **Still unverified:** whether *tool calls* (esp. `snippet_search`) enforce a key or a stricter rate limit than the handshake; the form-gated key (`https://share.hsforms.com/1L4hUh20oT3mu8iXJQMV77w3ioxm`) is presumably for quota/rate. Not tested — no snippet call has been made.

## 6. Deferred — the probe to run next (NOT run yet, per instructions)

Mirror [`index_scope_probes.csv`](../paperclip/data/index_scope_probes.csv): take the exact PMIDs/DOIs Paperclip **missed** (P01–P12 in [`index_scope_findings.md`](../paperclip/index_scope_findings.md) — Annual Reviews, pre-1980 NEJM, Lancet 2019 RCTs) plus the Khoury Nat Med final and NEJM ATTR-ACT, and for each ask Asta `snippet_search` whether it returns a body-text snippet. Record hit/miss + snippet `kind`/`section` per class. That single table would answer the colleague's question empirically and slot cleanly into the existing eval as a candidate fifth arm.

Estimated effort if greenlit: ~1–2 hrs (client already installed; ground-truth IDs already in the repo).

## 7. Stage-1 interim results (2026-07-15, partial — snippet backend down)

Plan approved (staged: gate → clean full run; Asta scored as a standalone 5th arm). Stage 1 started via the live keyless MCP. **The source-resolver / index-scope half is done and decisive; the snippet (document-reader) crux is BLOCKED by an Asta-side outage.** Verbatim evidence: `asta_probes/coverage__get_paper_batch.txt` (exploratory packet, superseded by the clean rerun).

### Coverage vs Paperclip on the exact classes Paperclip is silent on (`get_paper_batch`, model-independent)

| Class | Paperclip (pass 3/4) | Asta `get_paper` | Notes |
|---|---|---|---|
| Annual Reviews | 0/all (durable miss) | **4/4 resolve** (Kew 2005 `isOpenAccess:false`; P01 2024; P02 2020; P03 2022) | full identity returned |
| Pre-1980 NEJM | 0/all (durable miss) | **≥3/4 resolve** (Hornick 1970 `false`; P07 1979 `false`; P09 1979 `false`; **P08 `PMID:111125` absent** from batch — reprobe pending) | closed-access, still resolved |
| Paywalled non-PMC Lancet 2019 | 0/3 (durable miss) | **3/3 resolve** (FLOT4; CASPIAN `isOpenAccess:false`; KEYNOTE-048) | closed-access, still resolved |
| Nat Med final / recent | Khoury preprint returned, final absent; P04 miss | Khoury `PMID:34002089` → **Nature Medicine final**; P04 CAR-T `isOpenAccess:false` resolves | better identity than Paperclip |
| Tafamidis NEJM 2018 (held-out) | miss (no PMC) | resolves + **full abstract** returned | — |

**Verdict on this half:** Asta's source-resolver + metadata coverage **massively exceeds** Paperclip — it reaches every class Paperclip is silent on, including genuinely closed-access papers (`isOpenAccess:false`).

### Fairness nuances (Asta is NOT uniformly better)
- **Version collapse, same as Paperclip.** Nigeria `ARXIV:1504.02751` and `PMID:26317401` resolve to the *same* PLoS ONE record (`e5004b10…`). Famulare `PMID:29702638` (PLOS Biology 2018 final) resolves to a record labeled **venue "bioRxiv", year 2017** — the preprint identity, not the final. So Asta does not cleanly win the version-resolver role.
- `get_paper_batch` **silently drops not-found IDs** (26 returned for 27 sent) — a caller can't tell a miss from an omission without individual reprobe. UX gap analogous to Paperclip's silent misses.

### Operational finding (material for the eval, and a live blocker)
- **`snippet_search` failed on every attempt this session** — 2× in-session MCP (`ConnectionRefusedError`) + 1× curl (SSE keepalive pings only, no payload in 150 s). It failed on its **very first call** (before any burst), so this is not merely rate-limiting — the snippet microservice appears **down / refusing upstream connections** right now.
- **The keyless endpoint also rate-limits `get_paper` under burst** — it worked when paced but returned `ConnectionRefusedError` immediately after the 27-ID batch. A real ~50-call retrieval run needs backoff+retry pacing, and possibly the form-requested API key for reliability.
- **Gate status: UNDECIDABLE yet.** The gate ("≥3/4 durable-miss classes return a correctly-identified *body snippet*") tests `snippet_search`, which is down. Source-resolver coverage alone already argues Asta clears the coverage bar, but the *snippet body-text-from-closed-access* claim — the colleague's actual question — is unverified pending backend recovery.

### Managed-rate auto-retry outcome (2026-07-15 ~20:00–20:45 UTC) — EXHAUSTED, still blocked
Per Mike's instruction (tooling + auto-retry with managed request rate), built backoff/pacing callers and retried patiently. Both snippet paths remain blocked:
- **Asta MCP `snippet_search`:** `ConnectionRefusedError` on every attempt across ~1 hr (incl. a patient background retry with 8 backoffs, and a fresh retry at 20:45). The MCP server wraps the upstream failure as a *successful* JSON-RPC result whose content is the error string — so a naive caller misreads it as OK (`asta_probes/tafamidis__snippet_body.txt`, exploratory). Backend is **down**, not throttled.
- **S2-direct `/graph/v1/snippet/search`** (bypasses Asta): **HTTP 429 on all 12 backed-off attempts** over ~10 min (`asta_probes/kew__s2_snippet_closedaccess.txt`, exploratory). The shared anonymous pool is saturated; pacing can't clear it.
- **Cause (resolved) + unblocks:** the shared-egress-IP/WARP hypothesis was **tested and DISPROVEN** — with Cloudflare WARP toggled **off** (`warp=off`, real IP `66.17.185.32`), a single S2-direct snippet call **still returned 429**. So the anonymous `/graph/v1/snippet/search` endpoint **effectively requires an API key** (a known S2 restriction on the snippet endpoint specifically; not an IP/quota-window issue and not fixable by pacing). Unblocks: **(a) an S2 API key** (the only path to test the capability via S2-direct — key requested 2026-07-15) → drop in gitignored `.s2.key`; **(b)** Asta's own MCP snippet backend must recover from its ConnectionRefused outage for the canonical Asta path (out of our control; `.asta.key` wired for when it does).
- **`get_paper`/graph endpoints are unaffected** throughout — they work anonymously without a key (source-resolver coverage above stands). Only the **snippet endpoint** is key-gated.

### RESOLVED with S2 key (2026-07-15 ~21:50 UTC) — full findings in [`asta_fast_findings.md`](asta_fast_findings.md)
Mike supplied a Semantic Scholar API key (1 req/s; in gitignored `.s2.key`). Snippet capability tested via S2-direct (Asta's own MCP snippet backend stayed down all session; same underlying index). **Decisive, and it reverses the premise:**
- **Closed-access papers: 0 snippets** (Kew, Hornick, CASPIAN, P04-CART, P07, bronze-OA tafamidis) — robust across queries. Absent from the snippet index. → **The "body snippets from paywalled full text" capability is NOT delivered for the paywalled papers this KB cares about.**
- **Open-access papers:** snippets exist but are mostly title+abstract; a genuine `body` snippet appeared for **1/12** papers tested (Nigeria PLoS ONE). Not a `limit` artifact (SFS/FLOT4 return no body even at limit 10 with body-targeted queries).
- **Snippet coverage ≠ metadata coverage.** Asta reaches paywalled papers at the **catalog/abstract** level (real win over Paperclip) but **not** the full-text level.
- **GATE (≥3/4 durable-miss classes return a body snippet): FAIL — 0/4.** Stage-2 scored body-snippet arm **not warranted**; a scored Asta arm would duplicate the web/API abstract arm. Asta's genuine role is a broad **metadata/discovery + citation-graph** layer, not a paywalled-full-text source. Evidence: [`asta_coverage.csv`](data/asta_coverage.csv), [`asta_probes/`](evidence/asta_probes/).

### Correction (2026-07-16): snippet was KEY-GATED, not "down"; body coverage richer than first reported
Prompted by Mike ("are you sure we're not using the mcp wrong?"). Two fixes, both confirmed — **verdict unchanged**:
- **`snippet_search` requires an `x-api-key`.** The "backend down all session" narrative above was a **misdiagnosis of a missing-auth failure**: keyless → `ConnectionRefusedError`; with the S2 key as `x-api-key` → snippets. Back-to-back control on Nigeria settled causation. `get_paper` is keyless; `snippet_search` is not.
- **"Open papers body 1/12" was a sampling artifact.** Targeted probe: body-snippet hit rate CS/arXiv **7/7**, open-bio **4/4**, paywalled-clinical **0/6** ([`asta_corpus_effect.csv`](data/asta_corpus_effect.csv)). Body coverage is strong for full-text-indexed (open/preprint) papers.
- **Native-MCP equivalence confirmed:** closed-access = 0 via Asta's own `snippet_search` too ([`asta_coverage.csv`](data/asta_coverage.csv)); the native path adds nothing beyond public S2. Full corrected writeup: [`asta_fast_findings.md`](asta_fast_findings.md).

---

### Sources
- [Asta blog](https://allenai.org/blog/asta) · [Asta Resources](https://allenai.org/asta/resources) · [Asta Scientific Corpus Tool (MCP)](https://allenai.org/asta/resources/mcp)
- [Semantic Scholar — About](https://www.semanticscholar.org/about) · [S2 API](https://www.semanticscholar.org/product/api) · [BioOne full-text partnership](https://medium.com/ai2-blog/semantic-scholars-partnership-with-non-profit-publisher-bioone-98220c8ae9da)
- Repo cross-refs: [`index_scope_findings.md`](../paperclip/index_scope_findings.md), [`pass4_fast_findings.md`](../paperclip/pass4_fast_findings.md), [`scoring_rubric.md`](../common/scoring_rubric.md)
