# Asta (Ai2) — Stage-2 Scored-Arm Findings (pass 5)

> **Combined verdict (both tools):** [`README.md`](README.md) — why neither Paperclip nor Asta replaces general web search + parsing. Paperclip role-by-role: [`final_recommendation.md`](final_recommendation.md). Asta Stage-1 gate: [`asta_fast_findings.md`](asta_fast_findings.md).

**Origin:** Claude Opus 4.8. 2026-07-16 (overnight run).
**What this is:** the scored, arm-isolated evaluation of Asta as a **standalone 5th arm**, head-to-head against Paperclip, on the same 14 cases, the same 8 prompts ([`synthesis_prompts.md`](synthesis_prompts.md)), the same rubric + hard caps ([`scoring_rubric.md`](scoring_rubric.md)), and the same ground truth. The Stage-1 gate **failed** (0/4 durable-miss classes returned a body snippet, [`asta_fast_findings.md`](asta_fast_findings.md)); Mike authorized running Stage 2 anyway. It is informative precisely because it quantifies *where* Asta helps.
**Method (fairness controls):** 28 syntheses (14 Asta + 14 Paperclip) by arm-isolated **Opus 4.8** subagents, bundle-only + no-outside-knowledge; **blinded** (arm labels + most tool vocabulary stripped) before scoring — this **discharges the pass-3 unblinded-scoring limitation**; two independent Opus 4.8 scorer subagents; disagreements ≥2 on a dimension adjudicated **conservative-lower**. Scores: [`synthesis_scores_pass5.csv`](synthesis_scores_pass5.csv); syntheses in [`pass5/`](pass5/).

---

## Headline

**On a clean, same-model, blinded basis, Asta modestly outscores Paperclip overall — but they tie on 12 of 14 cases, and Asta's entire margin comes from 2 cases where Paperclip misses the paper and Asta returns an abstract.** The advantage is **reach, not depth**: Asta never provides paywalled body text (Stage-1), and where a closed paper's abstract is also elided (kew, hornick) the two tie low. This confirms the Stage-1 read — Asta is a strong **metadata/discovery + open-access-full-text** layer, not a paywalled-full-text source.

- **Mean overall: Asta 3.29 vs Paperclip 3.00** (n=14 each).
- **Per-case: Asta wins 2 (both Paperclip-miss cases), ties 12, loses 0.**

## Per-dimension means (Opus 4.8, blinded; NA excluded)

| Arm | EF | MD | UC | VP | SP | TR | DU | TF | **overall** |
|---|---|---|---|---|---|---|---|---|---|
| **Asta** | 4.64 | 3.71 | 4.00 | 3.25 | 2.70 | 4.57 | 3.64 | **3.07** | **3.29** |
| **Paperclip** | 4.00 | 4.00 | 3.29 | 3.50 | 2.67 | 4.00 | 2.86 | **1.71** | **3.00** |

- **Asta leads:** EF (fidelity), UC (unsupported-claim control), TR (traceability), DU (domain usefulness), and **TF/friction by a wide margin** (3.07 vs 1.71 — clean one-call retrieval vs Paperclip's multi-step/`map`-contaminated workflow).
- **Paperclip leads (slightly):** MD (missing-detail control) and VP (version/provenance).
- **Tie, both weak:** SP (supplement/table/figure) — Asta has no supplement surface; Paperclip's filesystem supplement surface didn't convert to much scored advantage on these cases.

## Per-case overall (Asta vs Paperclip)

| Case | Asta | Paperclip | Δ | note |
|---|---|---|---|---|
| heldout-tafamidis-attr | **4** | 2 | **+2** | Paperclip-miss (non-PMC NEJM) → invalid-identity cap; Asta resolves + full abstract |
| heldout-tbe-vaccine | **4** | 2 | **+2** | Paperclip concept-miss → invalid-identity cap; Asta resolves + abstract |
| kew-2005-opv-review | 2 | 2 | 0 | both low: Paperclip miss; Asta resolves but **publisher elided the abstract**, no body |
| hornick-typhoid | 2 | 2 | 0 | both low: Paperclip miss; Asta resolves metadata but no abstract/body |
| cheslock-1960-ocr | 2 | 2 | 0 | both invalid-identity (1960 local-only scan; neither resolves it) |
| heldout-hepc-ns5a / podoconiosis / snakebite | 4 | 4 | 0 | open-access bio; both strong (Asta from abstract+body) |
| nct04232943 | 4 | 4 | 0 | Asta reads the paper; Paperclip has the trial surface (Asta has none) |
| thakkar-famulare-arxiv | 4 | 4 | 0 | open arXiv; both strong |
| famulare / nigeria / khoury / sfs | 3 | 3 | 0 | supplement-heavy / versioned caps hit both |

## Interpretation

1. **Asta's overall edge (+0.29) is 100% attributable to reach on Paperclip-miss cases with available abstracts** (tafamidis, tbe: +2 each). Remove those and the arms are identical in the aggregate.
2. **That reach advantage is real but largely duplicative of the existing web/API (PubMed) arm** — which also supplies identity + abstract. Asta adds a citation/author graph and one-call ergonomics (the TF win), not a new *content* capability for paywalled papers.
3. **Where Asta genuinely reads full text (open-access/preprint), it matches Paperclip's best** (the 4s), with lower friction. Where a paper is truly closed (elided abstract), Asta's reach delivers nothing scorable (kew/hornick tie at 2).
4. **Paperclip retains a structural edge on SP/supplement and the trial-registry surface** — modalities Asta lacks entirely.

**Net:** the scored run is consistent with the gate. Asta is a **better default discovery/abstract layer than Paperclip** (broader reach, cleaner, higher DU/TF) but is **not** the paywalled-full-text capability the KB actually needs, and its scored advantage over Paperclip is small and reach-driven.

## Fairness caveats (declared)

- **Paperclip evidence is frozen pass-3 (v0.4.2)** re-synthesized on 4.8. Pass-4 showed v0.6.0 fixed `map`-contamination, DOI lookup, and trial-`map` — which would raise Paperclip's MD/VP/friction on a few non-miss cases and **narrow the 0.29 gap**. But the +2 wins (tafamidis, tbe) are **corpus-scope** misses v0.6.0 did *not* fix, so Asta's reach advantage is durable. A fully clean run would re-retrieve Paperclip on v0.6.0.
- **Blinding is improved but imperfect:** explicit arm names + most tool vocabulary were stripped, but ~7 syntheses retained the token "snippet" (in quoted field names). A residual arm-inference channel remains; both scorers are the same model (sampling-noise, not structural, independence).
- **Scorer divergence:** 14/28 rows needed conservative-lower adjudication (mostly on UC, unsupported-claim detection) — a real inter-scorer spread; the conservative rule was applied per contract.
- **web/local arms not re-scored on 4.8** here (Asta's abstract edge overlaps the web arm; a future run could add them for a full standalone table).
- Scope: **no hybrid arm** (per the standalone-only decision); this does not test "does adding Asta improve the hybrid workflow."

## Bottom line

Quantified, blinded, same-model: **Asta 3.29 vs Paperclip 3.00 — a modest, reach-driven edge, tying on 12/14 cases.** Combined with Stage-1 (0 body snippets for paywalled papers), the recommendation is unchanged and now sharper: **Asta is the better lightweight discovery/abstract + open-full-text-snippet layer, but not a provenance-grade paywalled-full-text source.** For the Fermi-KB's paywalled clinical/review targets, full text still requires publisher access / local PDFs.
