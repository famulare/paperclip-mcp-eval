---
case_id: kew-2005-opv-review
arm: hybrid
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: kew-2005-opv-review | Arm: Hybrid

## Retrieval validity status

Hybrid retrieval is **heavily skewed toward web/API identity**; both other arms degrade.

- **Web/API arm (identity truth):** Clean. PubMed resolves PMID 16153180 / DOI 10.1146/annurev.micro.58.030603.123625 to Kew OM, Sutter RW, de Gourville EM, Dowdle WR, Pallansch MA. *Annual Review of Microbiology* 2005;59:587-635. Title: "Vaccine-derived polioviruses and the endgame strategy for global polio eradication." Full abstract available. Case classification: review article, wheelhouse: yes.
- **Paperclip arm (canonical exact-ID miss):** Both `lookup doi 10.1146/annurev.micro.58.030603.123625` and `lookup pmid 16153180` return "No documents found." This is the **canonical exact-ID miss case** flagged in the case notes. Critically, this is a stronger failure than the SFS or Famulare cases: in those cases PMID lookup succeeded even when DOI failed. Here, **both** primary identifiers fail. The paper appears to be absent from the corpus under both canonical identifiers.
- **Paperclip title search (contaminated):** `search -t --all "Vaccine-derived polioviruses and the endgame strategy for global polio eradication" -n 5` returns 5 papers, **none of which is the Kew 2005 target**. The returned papers are: Mei et al. 2022 Western Pacific review (med_ef5c8f1f6c08); Grassly 2013 final-stages review (PMC3720038); Leung et al. 2023 opinion-dynamics arXiv (arx_2304.12516); Duintjer Tebbens & Thompson 2018 OPV restart (PMC6168953); Thompson & Kalkowska 2020 modeling reflections (PMC7983882). All five are off-target.
- **Paperclip ls/wc probe contaminated:** `ls /papers/med_ef5c8f1f6c08/` and `wc /papers/med_ef5c8f1f6c08/content.lines` were run against the **first off-target paper** (Mei et al. Western Pacific review), not Kew 2005. The 270-line content.lines and the directory contents belong to Mei et al., not Kew 2005.
- **Paperclip map probe contaminated:** `map --from s_33cd8f0d -n 1` returned 5/5 successes from the off-target search substrate. None of the five claim summaries is about Kew 2005. All five are excluded from synthesis evidence.
- **Local PDF arm (degraded but identity-confirming):** The PDF file is present (52 pages, 423,036 chars, 3,115 lines) and the head slice (first 2,500 chars) confirms title, all five authors (Kew, Sutter, de Gourville, Dowdle, Pallansch), CDC/WHO affiliations, *Annu. Rev. Microbiol.* 2005;59:587-635 citation, and stamp markers from Indiana University Bloomington (06/09/10 download). **However, no abstract or body-text content is in either the head slice or the tail slice** — the head slice cuts off mid-affiliation block, and the tail slice shows only a back-matter "Contents ix" Annual Reviews TOC fragment. The 423k-char body is present in the file but not surfaced in this bundle's slices.

Net: identity is solid; **the only content-bearing source is the web/API abstract**. Paperclip provides zero on-target content. Local PDF confirms title/author identity but no scientific content.

## Available context

- **Web/API:** Full title, author list with affiliations (CDC Atlanta + WHO Geneva), journal/volume/pages/date, full abstract (the abstract is the only substantive scientific content in the entire bundle), three diagnostic claim anchors from the ground-truth file (VDPV emergence and endgame strategy review; classifies VDPVs as cVDPV/iVDPV/aVDPV; review article not primary data).
- **Paperclip:** No on-target content. The five off-target papers retrieved by title search are **excluded** from evidence.
- **Local PDF:** Title-page header, full author list, affiliations, ANRV253-MI59-23 manuscript ID, 4 August 2005 19:48 ARI date stamp, journal citation, page range 587-635, 52-page length, ~423k characters of unseen body text. No abstract text and no body text in the slices.

## Cross-arm conflicts

- **Exact-ID-miss conflict (severe):** Web/API and local PDF both confirm the paper exists and is the named target. Paperclip's both DOI and PMID lookups return "No documents found." This is a **clean Paperclip-absent vs web-and-local-present conflict** — unlike the SFS and Famulare cases (where PMID lookup succeeded as a backstop for DOI failure), Kew 2005 appears genuinely absent from the Paperclip corpus under both canonical identifiers. Cannot rule out from this bundle whether the paper is in the corpus under some non-canonical identifier (e.g., a PMC ID or internal ID), but neither web/API nor the bundle exposes such an alternative.
- **Title-search false-positive conflict:** Paperclip's title search returns 5 papers, all confidently labeled as relevant, none of which is the target. A naive consumer of the title-search output could mistake any of those for the Kew 2005 review. This is a **silent retrieval failure** — no error is raised, the failure is only detectable by checking returned identifiers against expected ones.
- **Probe-substrate conflict:** The `ls`, `wc`, and `map` probes were threaded off the contaminated search results, so all their outputs describe off-target papers. The bundle does correctly attribute these to `med_ef5c8f1f6c08` (Mei et al.), but a consumer who skims the probe outputs without tracing identifiers could attribute them to Kew 2005.
- **No content-level conflict between web abstract and local PDF** can be checked, because the local PDF slices contain no abstract or body text.

## Prompt 1 — Central mechanistic claim

From the web/API abstract (the only substantive content in the bundle):

The paper is a **review** that frames the post-eradication polio endgame around a central mechanistic problem: **the live attenuated oral poliovirus vaccine (OPV) is genetically unstable**, and the small number of attenuating substitutions revert frequently during OPV replication in humans. This reversion is the underlying cause of vaccine-associated paralytic poliomyelitis (VAPP) in recipients and contacts, and — more recently identified — two additional adverse events: (a) **long-term excretion of highly evolved vaccine-derived polioviruses (VDPVs) in persons with primary immunodeficiencies** (iVDPVs), and (b) **polio outbreaks associated with circulating VDPVs in areas with low rates of OPV coverage** (cVDPVs). The mechanistic claim is therefore not a single empirical finding but a **synthesis claim**: that OPV's genetic instability creates a structurally inevitable set of post-eradication risks (VAPP + iVDPV + cVDPV) that any endgame strategy must address. The diagnostic claim anchors confirm the paper also introduces the VDPV classification scheme (cVDPV / iVDPV / aVDPV) by epidemiologic context.

## Prompt 2 — Evidence supporting it

The bundle contains **no in-paper evidence** beyond the abstract assertions. The 423k-char body of the local PDF is not surfaced. The Paperclip corpus has no retrievable content for this paper. From web/API anchors only:

- Reversion of attenuating substitutions during OPV replication is asserted as a frequent event.
- VAPP cases are characterized as "rare" but long-recognized.
- iVDPVs are characterized as occurring in persons with primary immunodeficiencies (rare, long-term shedders).
- cVDPVs are characterized as emerging in low-OPV-coverage areas.

These are abstract-level assertions, not bundle-level evidence. The reviewed primary literature (case series of immunodeficient shedders, named cVDPV outbreaks, sequencing studies showing reversion patterns) is **not visible in the bundle**. A reader cannot, from this bundle alone, evaluate the strength of any specific evidentiary claim — only the abstract-level taxonomy is recoverable.

## Prompt 3 — Hidden detail in supplement/table/figure/appendix/protocol/SAP/registry

Cannot answer from this bundle. The local PDF has 52 pages and ~423k characters of body text not surfaced in the slices. The Annual Reviews format typically embeds figures and tables inline rather than as separate supplements, but the bundle does not expose them. Paperclip returned no content. **No hidden detail is recoverable.** The case demonstrates an arm-coverage gap: when both Paperclip and local PDF slices fail to surface body content, the hybrid arm has no more reach than a web-abstract reader for hidden-detail questions.

## Prompt 4 — What would a domain expert notice that a generic summary might miss

From web/API anchors + identity:

- **Author lineage:** Olen Kew (CDC Atlanta, omk1@cdc.gov) was the lead poliovirus molecular epidemiologist at CDC; Mark Pallansch was head of the CDC polio lab; Roland Sutter and Esther de Gourville are WHO polio leads; Walter Dowdle was a former CDC deputy director with deep eradication-program history. This is **the canonical CDC+WHO polio-endgame author cluster of the era**, which signals the paper as a programmatic synthesis carrying institutional weight — not an academic outsider view.
- **Date positioning:** August 2005 publication places the paper at a specific epoch — after the Hispaniola 2000 cVDPV outbreak (first recognized cVDPV), after the discovery of long-term iVDPV shedders in the 1990s–2000s, but **before** the 2005-2006 Nigeria cVDPV2 outbreak became fully characterized and well before the 2016 globally synchronized OPV2 cessation. The endgame framing is therefore pre-cessation strategy-formation, not retrospective analysis.
- **VDPV taxonomy as a coined classification:** The cVDPV / iVDPV / aVDPV (ambiguous VDPV) trichotomy is itself a **terminological infrastructure decision** that the paper formalizes for the field. A generic summary that simply reports "the paper reviews VDPVs" would miss that this paper is one of the canonical sources of the classification scheme.
- **OPV "vaccine of choice for developing countries":** The abstract's specific phrasing flags the equity dimension — OPV is used in high-burden settings precisely because of cost, cold-chain tolerance, and intestinal-immunity advantages, which is what makes the endgame problem hard. A generic summary that conflates OPV/IPV would miss the structural reason OPV cannot simply be replaced everywhere.
- **The "endgame" framing itself:** A domain reader would recognize this as one of the early canonical articulations of the polio endgame as a distinct policy-and-science problem, predating much of the OPV-cessation modeling literature (e.g., Thompson, Duintjer Tebbens, Pons-Salort, Famulare). This is metadata about the paper's role in the field, not its content.

## Prompt 5 — What would be dangerous to overclaim

- **Treating Paperclip's "No documents found" as evidence the paper is not influential or not in the standard corpus.** Web/API and local PDF both prove the paper exists; Paperclip's retrieval failure is an indexing artifact, not a corpus-curation signal.
- **Attributing any of the five off-target Paperclip search results to Kew 2005.** The Mei 2022, Grassly 2013, Leung 2023, Duintjer Tebbens & Thompson 2018, and Thompson & Kalkowska 2020 papers are all post-Kew analyses with different scopes, methods, and claims; conflating any of them with Kew 2005 inverts the historical lineage (Kew 2005 is canonical antecedent literature, not derivative work).
- **Claiming Kew 2005 predicts or evaluates specific post-2016 OPV2-cessation outcomes** — the paper predates synchronized OPV2 cessation by 11 years and the nOPV2 program by ~15 years.
- **Stating specific case counts, outbreak sizes, sequencing distances, or coverage thresholds** — none of these are in the bundle.
- **Claiming the paper proposes a specific endgame strategy** beyond noting the strategy is "an urgent WHO priority" — the abstract states the problem and the priority but does not (in the bundle) commit to a specific recommended endgame pathway. The body of the paper may well do so, but that content is not recoverable from this bundle.
- **Treating the VDPV taxonomy as exhaustive or static** — subsequent literature has refined classifications (e.g., the operational distinction between cVDPV1, cVDPV2, cVDPV3 in modern surveillance), and the paper's 2005 framing should not be read as the current operational definition.

## Prompt 6 — Which author claims are not well-supported by the data presented

From bundle evidence alone, this prompt is **mostly unanswerable** because the bundle contains only the abstract. The abstract claims are:

- "Reversion ... frequently occurs during OPV replication" — not auditable from the bundle; primary sequencing evidence is in the unseen body.
- "Rare cases of VAPP" — not auditable; the supporting epidemiologic data are not in the bundle.
- "Long-term excretion of highly evolved VDPVs in persons with primary immunodeficiencies" — characterized as a recent identification; the case-series support is not in the bundle.
- "Polio outbreaks associated with circulating VDPVs in areas with low rates of OPV coverage" — characterized as recent; the outbreak documentation (e.g., Hispaniola 2000) is not visible.
- "Developing a posteradication strategy ... has become an urgent WHO priority" — this is a programmatic statement, not a claim that can be supported or unsupported by data within the paper.

None of these can be flagged as "not well-supported" without seeing the body. The most that can be said is that the abstract makes **categorical** claims ("frequently," "rare," "more recently identified") that any conscientious reader should want to see quantified in the body — and the body is not in the bundle.

## Prompt 7 — Which claims depend on external literature/assumptions/registry/expert judgment

Almost entirely. This is a review article. Per the abstract, the paper reviews:

- The molecular genetics of OPV attenuation and reversion (external sequencing literature, 1980s–2000s).
- VAPP case identification and surveillance (external CDC/WHO surveillance literature spanning four decades of OPV use).
- iVDPV case series in primary-immunodeficiency patients (external clinical/case-series literature).
- cVDPV outbreak documentation (external outbreak-investigation literature, e.g., Hispaniola 2000 and subsequent).
- The WHO endgame strategy framing (external programmatic documents).

A review article by definition depends on external literature; the bundle does not expose any of the specific cited sources, so the dependence is total but unitemizable from the bundle alone.

## Prompt 8 — Connection to KB themes

- **Mechanistic over narrative:** The abstract makes a genuinely mechanistic move — it grounds the endgame problem in OPV's genetic instability and the reversion of a "small number of substitutions conferring the attenuated phenotype." This is the mechanistic substrate downstream KB-tracked work (e.g., Famulare 2018 within-host modeling, the nOPV2 stability story) builds on.
- **Surveillance as measurement:** The cVDPV/iVDPV/aVDPV classification is itself a surveillance-infrastructure decision — it specifies what surveillance must distinguish to be operationally meaningful. The KB theme that "surveillance categories shape what is measurable" is exemplified here.
- **Antecedent literature for the polio endgame thread:** Kew 2005 is a canonical antecedent for the entire OPV-cessation modeling line (Thompson, Duintjer Tebbens, Famulare, Pons-Salort, Grassly). The KB's polio-endgame thread should treat this as a foundational citation, not a derivative one.
- **Wheelhouse case:** Marked wheelhouse: yes. Kew, Pallansch, Sutter, de Gourville are all in the evaluator's polio-orbit author network.
- **Retrieval failure mode as KB evidence:** This case itself is evidence for a KB theme about tool reliability — Paperclip's exact-ID miss on a canonical, widely-cited review article is a structural finding about the corpus/index, not just an incidental gap. The KB's literature-tooling evaluation thread should note that **Annual Reviews articles may be systematically under-indexed** (Kew 2005 fails on both DOI and PMID lookup), as a hypothesis to test against other Annual Reviews entries.

## Uncertainty

- **What is in the 423k-char body of the local PDF** — unknown. The slices show only the title-page header and a back-matter TOC fragment.
- **Whether the paper appears in the Paperclip corpus under any non-canonical identifier** — unknown; no fallback identifiers were probed in the bundle.
- **Whether the systematic Annual Reviews under-indexing hypothesis holds** — only one Annual Reviews case is in this bundle; cannot generalize.
- **Specific quantitative claims in the body** (reversion rates, VAPP incidence, iVDPV shedding durations, cVDPV outbreak sizes) — not in the bundle.
- **The paper's specific endgame recommendations** — characterized as "an urgent WHO priority" in the abstract but the specific recommended pathway (timing of cessation, role of IPV, surveillance posture) is not in the bundle.
- **Whether the abstract's "small number of substitutions" refers to the canonical Sabin attenuation sites** (typically discussed as e.g., 480/481/472 for Sabin 1/2/3 in the 5' UTR + capsid sites) — likely, but the specific sites are not stated in the bundle.

## Prohibited inferences

- **Do not import content from the five off-target Paperclip search results** (Mei 2022 Western Pacific review, Grassly 2013, Leung et al. 2023 opinion-dynamics, Duintjer Tebbens & Thompson 2018 OPV restart, Thompson & Kalkowska 2020 modeling reflections) as evidence about Kew 2005. Their identifiers (med_ef5c8f1f6c08, PMC3720038, arx_2304.12516, PMC6168953, PMC7983882) must be treated as **excluded** from the evidence set.
- **Do not attribute the Mei et al. content.lines or ls output to Kew 2005** — the 270-line content.lines belongs to the contaminated probe substrate, not the target.
- **Do not claim Paperclip's "No documents found" means the paper is unimportant, retracted, missing from the literature, or unavailable** — the web/API and local PDF arms both confirm presence.
- **Do not invent specific quantitative claims** (reversion rates, VAPP/iVDPV/cVDPV incidence figures, OPV coverage thresholds, sequencing distances) — none are in the bundle.
- **Do not assume the paper's endgame recommendation aligns with the eventually-implemented 2016 OPV2 cessation strategy** — the paper predates that strategy's finalization and the bundle does not expose the paper's specific recommendation.
- **Do not generalize the Annual Reviews under-indexing hypothesis** from this single case without further evidence.
- **Do not equate the 2005 VDPV classification with current operational definitions** — the scheme has been refined in subsequent literature not visible in the bundle.
