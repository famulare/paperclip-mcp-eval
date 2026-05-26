---
case_id: famulare-2018-plosbio
arm: hybrid
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: famulare-2018-plosbio | Arm: Hybrid (web + Paperclip + local)

## Retrieval validity status

Hybrid retrieval succeeded with mixed-arm reliability. The web/API identity arm cleanly anchors the target paper (PMID 29702638, PMCID PMC5942853, DOI 10.1371/journal.pbio.2002468, PLoS Biology 2018-04-27). The Paperclip arm exhibits the predicted "canonical DOI-miss" pathology: `lookup doi 10.1371/journal.pbio.2002468` returns "No documents found," while `lookup pmid 29702638` and the title search both correctly resolve PMC5942853. The supplements directory listing shows two attached supplements (`pbio.2002468.s001.pdf`, `pbio.2002468.s002.zip`), yet `grep -i "supplement|appendix"` on content.lines returned no matches — so supplement references are not surfaced in the content stream even though the files exist. The `map -n 1` probe processed 5 papers, not 1, confirming contamination: only result 1 (PMC5942853) is on-target; results 2–5 are unrelated polio/epidemic papers that must be excluded as evidence. The local PDF slices provide the bioRxiv preprint version of the main paper (71 pages, matches author list, abstract scope) and S1 Text (17 pages, supplement Parts A–C). These align with the web identity. Net: enough trustworthy signal to answer all 8 prompts.

## Available context

- Web/API: full abstract, author list, journal, dates, preprint lineage (bioRxiv 10.1101/084012, 2016).
- Paperclip: confirmed PMID/title lookup; supplements present as files but invisible to content.lines grep; map probe contaminated.
- Local PDF main: bioRxiv preprint head slice (abstract through "cross-immunity against type 2 produced by bivalent types 1 and 3 OPV is insufficient to block..."); tail slice (references 20–21, Lancet Infectious Diseases 2015 phase-4 study and Asturias et al. 2016 bOPV+IPV trial).
- Local PDF S1 Text: table of contents reveals Parts A (Parameter table), B.1–B.5 (within-host: shedding sources, duration after OPV challenge vs WPV, stool concentration, oral susceptibility from OPV challenge, waning immunity), C.1–C.4 (transmission model: Houston 1960, Louisiana 1953–1955, Uttar Pradesh & Bihar 2003–2008, model fit); Part A begins with Table A parameter listing (OPV-equivalent antibody titer N_Ab, parameter µ_S truncated); references include Linking seroresponse to within-host heterogeneity (Epidemics 2016) and Gelfand et al. 1957 Louisiana natural immunity study.

## Cross-arm conflicts observed

- DOI-miss conflict: Paperclip `lookup doi` finds nothing; web identity and Paperclip `lookup pmid` both confirm the paper exists in the index. This is an indexing/retrieval bug in Paperclip on this DOI, not a paper-identity conflict.
- Supplement-visibility conflict: ls shows supplements exist; grep on content.lines finds no "supplement"/"appendix" mentions. Suggests supplement text is either not indexed into content.lines or is referenced by alternate terms (e.g., "S1 Text," "Table A"). Local PDF confirms S1 Text exists and uses "S1 Text" / "Part" terminology rather than "supplement"/"appendix."
- Map contamination: map -n 1 returned 5 results (Western Pacific polio review, opinion-dynamics epidemic paper, bOPV cessation paper, VDPV2 emergence paper). Only the first is the target. Results 2–5 are excluded from synthesis evidence.
- No content conflict between web abstract and local PDF abstract on substantive claims; preprint abstract phrasing is slightly different from final PLoS Biology abstract but conveys the same multi-scale OPV-cessation model and setting-dependent risk framing.

## Prompt 1 — Central mechanistic claim

The paper builds a multi-scale model coupling within-host immunity (shedding duration, stool viral concentration, oral susceptibility to infection, waning of antibody-mediated protection) to between-host transmission (contact patterns, sanitation) to assess whether and when reintroduction of OPV after cessation poses transmission risks comparable to wild poliovirus. The central mechanistic claim, per the web abstract and consistent with the bioRxiv preprint abstract head slice and S1 Text structure, is that **setting-dependent transmission rate is the controlling variable**: in low-transmission settings IPV suffices, in moderate settings OPV can be used reversibly, but in high-transmission settings absent population immunity, Sabin-strain OPV is nearly as capable of causing outbreaks as WPV. The contributing within-host mechanism is that immunity reduces shedding and oral susceptibility, and waning of these protections — not just antibody titer — is what governs population-level transmissibility post-cessation.

## Prompt 2 — Evidence supporting it

Per the bundle: the model is calibrated to clinical-trial and field-epidemiology data ("summarized data spanning 75 years of polio literature," preprint head slice). S1 Text Part B.1 documents sources for shedding and oral-susceptibility data; B.2 fits shedding duration after OPV challenge versus WPV infection; B.3 fits stool concentration; B.4 fits oral susceptibility to OPV challenge; B.5 fits waning immunity. Transmission model parts C.1–C.3 are calibrated to three named outbreak/contact datasets: **Houston 1960, Louisiana 1953–1955, and Uttar Pradesh & Bihar 2003–2008**; Part C.4 reports model fit. Parameter table (Part A, Table A) consolidates calibrated values with ranges. The preprint head additionally cites use of "close-contact transmission data from the USA and India" — consistent with Houston/Louisiana and UP/Bihar. Reference list visible in slices includes the Asturias et al. 2016 bOPV + IPV Latin America trial and a 2015 Lancet ID phase-4 non-inferiority study, supporting the IPV-sufficiency claim in low-transmission settings.

## Prompt 3 — Hidden detail in supplement/table/figure/appendix/protocol/SAP/registry

- S1 Text exists despite Paperclip's grep returning "no matches" — it is named "S1 Text," not "Supplement" or "Appendix," which explains the grep miss. This is itself a finding: the case demonstrates that "supplement-blind" retrieval is a function of vocabulary mismatch, not absence.
- Part A (Table A) defines OPV-equivalent antibody titer N_Ab as the individual correlate of immunity, and parameterizes a quantity beginning with µ_S (truncated in slice — likely shedding-related mean parameter).
- Three distinct historical cohorts anchor the transmission calibration: Houston 1960, Louisiana 1953–1955, Uttar Pradesh & Bihar 2003–2008. Domain readers should note these span very different sanitation/transmission regimes — explicitly the structural basis for the "low/moderate/high transmission setting" trichotomy in the headline result.
- A second supplement file (`pbio.2002468.s002.zip`) exists but its contents are not in the bundle. Cannot answer what is inside.
- Reference to Gelfand et al. 1957 (American Journal of Hygiene) and to Selinger/Kretzschmar 2016 (Epidemics) — indicates within-host model architecture borrows from prior antibody-dynamics work; this lineage is not visible in the abstract.

## Prompt 4 — What would a domain expert notice that a generic summary might miss

- The use of **OPV-equivalent antibody titer** (N_Ab) as a unifying correlate across OPV/IPV/WPV exposure histories — a non-trivial modeling choice that lets heterogeneous immunity sources be placed on one axis. A generic summary would not flag this.
- The Houston 1960 / Louisiana 1953–1955 / UP-Bihar 2003–2008 triad implies the model is fit to **WPV-era close-contact transmission data** in the USA and to OPV-era data in India. Extrapolating WPV-era US transmission rates to post-cessation reintroduction scenarios is the substantive inferential move and the controlling assumption.
- The preprint head explicitly says "cross-immunity against type 2 produced by bivalent types 1 and 3 OPV is insufficient to block [transmission]" — this is the operational claim driving the type-2 cessation risk framing, and it sits inside the cross-serotype immunity literature, not the headline IPV-vs-OPV story.
- Map-arm contamination matters for citation hygiene: the Pons-Salort et al. PMC4934862 paper and the Duintjer Tebbens et al. PMC5892013 paper that Paperclip returned alongside this one are independent contemporaneous OPV-endgame analyses, not extensions of Famulare 2018 — a domain reader would recognize them as parallel work and not confuse claims.

## Prompt 5 — What would be dangerous to overclaim

- That "OPV is as dangerous as WPV" — the paper's actual claim is conditional on (a) high-transmission settings AND (b) absent population immunity. Stripping the conditionals inverts the policy implication.
- That the model is empirically validated against post-cessation outbreaks — calibration data are from WPV-era and pre-cessation OPV-era epidemiology (Houston 1960, Louisiana 1950s, UP/Bihar pre-2010); the post-2016 OPV2 cessation epoch the paper addresses is *predicted*, not fit.
- That IPV "prevents outbreaks" universally — the bundle supports IPV sufficiency only in low-transmission settings.
- That all immunity mechanisms are captured — bundle shows the model explicitly parameterizes shedding, stool concentration, oral susceptibility, and waning; it does not show modeling of cellular immunity, mucosal IgA dynamics independent of N_Ab, or strain-specific reversion timing within the within-host module. Claiming mechanistic completeness would overreach.
- That the supplement coverage is exhaustive — `s002.zip` is unread in the bundle. Inferences from "supplement contents" should be limited to S1 Text Parts A–C.

## Prompt 6 — Which author claims are not well-supported by the data presented

From bundle evidence alone:
- The strong setting-dependent quantitative thresholds ("low/moderate/high transmission rate settings") implied as a clean trichotomy are not visible in the bundle with their cutoffs or calibration uncertainty. The preprint head and abstract assert the regimes; the slices do not show the R0 ranges or sensitivity analyses that would justify them. Cannot evaluate the threshold sharpness from this arm's evidence.
- The claim that "OPV can be reintroduced and withdrawn as needed in moderate transmission rate settings" implies a reversible policy lever; the bundle does not expose the dynamic/timing analysis that would underwrite reversibility (e.g., how fast population susceptibility rebounds; what the outbreak-response decision rule is). Cannot answer from this arm.
- The historical reduction figure "by a factor of 10,000 or more" in the abstract is cited but its source is not in the bundle slices.

## Prompt 7 — Which claims depend on external literature/assumptions/registry/expert judgment

- Calibration to "75 years of polio literature" (preprint head) — the within-host shedding/oral-susceptibility/waning fits depend on heterogeneous prior trial and field data, summarized rather than re-collected. S1 Part B.1 explicitly is a sources-of-data section.
- The Asturias et al. 2016 bOPV+IPV Latin American RCT and the 2015 Lancet ID phase-4 non-inferiority study (visible in tail-slice references) are leaned on for IPV/bOPV interaction effects.
- The Gelfand et al. 1957 Louisiana study underwrites the Louisiana 1953–1955 transmission calibration.
- Selinger & Kretzschmar 2016 underwrites the antibody-titer-to-seroresponse within-host structure.
- Cross-immunity between bOPV (types 1 & 3) and type 2 — the claim that it is "insufficient" is anchored in external trial literature not reproduced in the slices.
- Generalization from Houston 1960 / Louisiana 1950s / UP-Bihar contact-transmission datasets to global post-cessation settings requires expert judgment about which contemporary settings map onto which historical regime.

## Prompt 8 — Connection to KB themes

- **Mechanistic over narrative:** the paper is paradigmatic — it builds an explicit within-host → between-host coupling with named parameters (N_Ab, shedding duration, oral susceptibility, waning) rather than a phenomenological risk story. The S1 Text Parts B and C make the mechanism legible and parameter-by-parameter auditable.
- **Surveillance as measurement:** the setting-dependent risk conclusion is implicitly a statement about what surveillance must measure (local transmission rate, population immunity composition) to be decision-relevant for OPV reintroduction. The bundle does not show explicit surveillance-design recommendations, but the policy conclusion is conditioned on measurable population-level quantities.
- **Multi-scale modeling:** central. The paper is explicitly multi-scale (within-host immunity, between-host transmission, setting-level sanitation/contact). The structure in S1 Text mirrors this: Part B = within-host, Part C = between-host, with shared parameters.
- **Continuous immunity:** N_Ab as an OPV-equivalent antibody titer that varies continuously across exposure histories, governs shedding/susceptibility/waning, and is the unifying within-host correlate. This is a continuous-immunity construction in operation — antibody titer is treated as the underlying continuous state, and binary "protected/susceptible" categories are recovered as functions of it rather than as primitives.

## Uncertainty

- Quantitative thresholds defining low/moderate/high transmission settings are not visible in the bundle; only the qualitative trichotomy is.
- Contents of `pbio.2002468.s002.zip` are unknown.
- Full Table A parameter values are truncated in the slice (only N_Ab and the start of µ_S are visible).
- Whether the within-host model includes mucosal immunity beyond the N_Ab construct cannot be determined from the bundle.
- The exact form of the waning function (Part B.5) and the fit diagnostics (Part C.4) are not in the slices.
- Whether Paperclip's DOI-lookup failure is reproducible across other PLoS Biology DOIs vs. specific to this paper cannot be determined from one case.

## Prohibited inferences

- Do not import any content from the four off-target map results (PMC5892013 Duintjer Tebbens et al., PMC4934862 Pons-Salort et al., med_ef5c8f1f6c08 Western Pacific review, arx_2304.12516 opinion-dynamics epidemics paper) as evidence about Famulare 2018.
- Do not claim post-2016 OPV2-cessation empirical validation; calibration data predate the cessation epoch the paper addresses.
- Do not assert specific numerical R0 cutoffs, vaccine-coverage thresholds, or outbreak-probability values — none are in the bundle.
- Do not infer supplement contents beyond S1 Text Parts A–C; s002.zip is unread.
- Do not equate the Sabin-as-dangerous-as-WPV conclusion with an unconditional claim; the conditions (high transmission + absent population immunity) are load-bearing.
- Do not treat Paperclip's "No documents found" DOI response as evidence that the paper is absent from the corpus — the PMID and title lookups confirm it is indexed; this is a DOI-resolution failure.
