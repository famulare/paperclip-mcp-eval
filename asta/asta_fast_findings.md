# Asta (Ai2) — Stage-1 Fast-Pass Findings (clean rerun)

**Origin:** Claude Opus 4.8. Captured 2026-07-16 (UTC). This is a **from-scratch clean rerun** — all probes were regenerated in one coherent pass with the correct method; it supersedes the earlier exploratory pass.
**Scope:** The **model-independent** retrieval layer of the Asta evaluation (coverage + capability; no synthesizer/scorer). Answers the originating question — *"can Asta return snippets from the full text of paywalled papers?"* — and the predeclared **gate** for whether a scored Stage-2 arm is warranted.
**Method:** Live Asta **native MCP** (`https://asta-tools.allen.ai/mcp/v1`), paced ≥1 req/s with backoff. **`get_paper`/`search_*` are keyless; `snippet_search` requires an `x-api-key`** (it accepts the Semantic Scholar key; keyless calls fail with a misleading `ConnectionRefusedError`). Snippets were confirmed identical via S2-direct and the native MCP path. Verbatim packets in [`evidence/asta_probes/`](evidence/asta_probes/); data in [`data/asta_coverage.csv`](data/asta_coverage.csv), [`data/asta_corpus_effect.csv`](data/asta_corpus_effect.csv), [`data/asta_negative_controls.csv`](data/asta_negative_controls.csv), [`data/asta_version_resolver.csv`](data/asta_version_resolver.csv), [`data/asta_closed_robustness.csv`](data/asta_closed_robustness.csv). (`pwsh` unavailable on this host → executed via Python/bash mirrors of the canonical [`../tools/`](../tools/) scripts.)

---

## Headline

**Two findings, opposite directions:**

1. **Metadata reach: Asta decisively beats Paperclip.** Asta resolves essentially every class Paperclip is silent on — Annual Reviews, pre-1980 NEJM, paywalled-non-PMC Lancet RCTs, Nature Medicine finals — **including genuinely closed-access papers** (`isOpenAccess:false`), returning full bibliographic identity (and the abstract, where the publisher hasn't elided it).
2. **Body-text snippets from paywalled papers: Asta does *not* deliver.** Every closed-access paper returns **zero** snippets — they are absent from the full-text snippet index (robust across two distinct queries each). By contrast, **open-access / preprint full text returns body snippets richly** (CS/arXiv **7/7**, open-access bio papers return body for 5/8 tested). The capability is real and good — it just **excludes paywalled papers' bodies**.

So Asta's snippet index is an **open-access full-text index**: genuine body-text excerpts when a paper's full text is licensed/open (CS/arXiv, most open bio), and **nothing for paywalled papers**. Asta reaches paywalled papers at the **catalog + abstract** level (a real win over Paperclip), not the **full-text** level.

## Gate verdict: **FAIL** — Stage-2 scored arm run anyway (see below)

Predeclared gate: *proceed iff Asta returns a correctly-identified **body** snippet for ≥3 of the 4 durable Paperclip-miss classes (Annual Reviews / pre-1980 NEJM / Nat Med final / paywalled-non-PMC).*

| Durable-miss class | Case | Resolved? | Body snippet? |
|---|---|---|---|
| Annual Reviews | kew-2005-opv-review | hit (abstract elided by publisher) | **no** |
| pre-1980 NEJM | hornick-typhoid | hit | **no** |
| Nat Med final | khoury-2021-natmed | hit (Nature Medicine 2021) | **no** |
| paywalled non-PMC | heldout-tafamidis-attr | hit | **no** |

**Result: 0/4 → FAIL.** (Mike authorized running Stage 2 anyway, given the overnight window — see [`asta_stage2_findings.md`](asta_stage2_findings.md). It's informative because the scored Asta arm is expected to split sharply: strong on open-access cases with body snippets, weak on closed/paywalled cases.)

## Per-role comparison (Asta vs Paperclip)

| Role | Paperclip (pass 3/4) | Asta | Who wins |
|---|---|---|---|
| **Source resolver** | PMC-anchored; misses Annual Reviews / pre-1980 / paywalled-non-PMC | Resolves **all 14 corpus cases** (cheslock 1960 the lone identity miss) and **P01–P12 except P08** (`PMID:111125`, a genuine 404); multi-scheme IDs | **Asta**, decisively |
| **Document reader** (body) | Full `content.lines` for **in-corpus PMC** papers; nothing for non-PMC | **0 body for closed/paywalled** (not in snippet index); **rich body for open/preprint full text** (CS 7/7; open-bio 5/8) | Paperclip for PMC; **Asta for open full text**; **neither** for paywalled bodies |
| **Version resolver** | Version lineage collapsed | **Mixed**: khoury preprint(medRxiv)/final(Nature Medicine) **distinct + correct**; famulare final `PMID` resolves to a **bioRxiv-labeled 2017 record** (mislabel); nigeria arXiv+PMID **collapse** to one record ([`data/asta_version_resolver.csv`](data/asta_version_resolver.csv)) | tie / both imperfect |
| **Supplement resolver** | Filesystem `supplements/` (buggy) but a real surface | **No supplement surface**; snippets exclude figure captions + bibliography by design | **Paperclip** |
| **Trial/paper bridge** | Resolves trial docs; ClinicalTrials linkage | Resolves the trial's **paper** (`PMID:36746739`); **no trial-registry surface** | **Paperclip** |
| **Cross-source engine** (refusal) | No refusal on impossible blends | **No refusal** — all 5 negative-control queries returned candidates, none flagged ([`data/asta_negative_controls.csv`](data/asta_negative_controls.csv)) | tie (both fail) |

## Snippet-coverage detail (the crux) — [`data/asta_coverage.csv`](data/asta_coverage.csv), [`data/asta_corpus_effect.csv`](data/asta_corpus_effect.csv)

Body-snippet availability tracks **full-text/snippet-index membership**, which tracks open access (but `isOpenAccess:true` is necessary, not sufficient):

| Group | n | Returned a **body** snippet |
|---|---|---|
| **Paywalled / closed-access** (kew, hornick, caspian, p04-cart, p07, tafamidis) | 6 | **0/6** — zero snippets at all; robust across 2 queries each ([`data/asta_closed_robustness.csv`](data/asta_closed_robustness.csv)) |
| **CS / arXiv** (attention, BERT, ResNet, GPT-3, Adam, BatchNorm, GAN) | 7 | **7/7** |
| Open-access **bio** corpus cases (nigeria, nct, tbe, hepC, podoconiosis, thakkar) | 6 | body present |
| Open-access papers *not* in the full-text index (famulare, sfs, snakebite; + P01–P12 mostly) | — | title/abstract only — being open-access does **not** guarantee body indexing |

When a paper's full text *is* indexed, the body snippets are genuine and substantive (e.g., Nigeria's introduction section; the Transformer's "Applications of Attention in our Model" section — verbatim in [`evidence/asta_probes/`](evidence/asta_probes/)). Body-snippet return is also query-sensitive (abstract snippets can outrank body for a given query).

## What this means for the KB

- **Asta is a strong catalog/discovery + abstract layer** (broader than Paperclip; adds citation/author graph and closed-access abstracts) **and a good open-access full-text snippet source** — but **not** a paywalled-full-text source. For quotable body text from paywalled papers, neither Asta nor Paperclip helps; that still needs publisher access / local PDFs.
- **Corpus effect (documented, tested):** the "no body snippets" result is scoped to this KB's **paywalled clinical/review** literature — under-represented in S2ORC. For a CS/arXiv-heavy corpus, body coverage is ~complete (7/7 here). The negative finding is corpus-specific, not a global capability ceiling.

## Operational findings
- **`snippet_search` is key-gated**; `get_paper`/`search_*` are keyless. Keyless snippet calls fail with `ConnectionRefusedError` (the server wraps the refused upstream call as a *successful* JSON-RPC result whose content is the error string). The S2 key works as the Asta `x-api-key` (1 req/s).
- Native Asta MCP snippet == S2-direct snippet (same index; both cite 12M full-text / 285M passages).

## Caveats
- Body-snippet coverage reflects this biomedical/clinical corpus (see Corpus effect).
- Version-resolver observations are from record identity/labels, not a full lineage audit.
- `cheslock-1960-ocr` has no reliable Asta identity (title search returned unrelated papers; snippet unscoped) — its Asta arm is effectively "not found", handled as such downstream.
