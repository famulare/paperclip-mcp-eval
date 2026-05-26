# Evidence Bundle: heldout-hepc-ns5a | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** PMID 26904396
**Case notes:** Held-out outside-wheelhouse: HCV DAA.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: heldout-hepc-ns5a

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Hepatitis C direct-acting antivirals / NS5A
**Case type:** concept-discovery outside wheelhouse
**Wheelhouse:** no

## PubMed source-of-record

- **PMID:** 26904396
- **PMCID:** PMC4724659
- **DOI:** 10.1016/j.apsb.2015.09.008
- **Title:** Direct anti-HCV agents.
- **Authors (top 6):** Zhang X
- **Journal:** Acta pharmaceutica Sinica. B
- **Pub date:** 2016 Jan

## Abstract (fair-use snippet)

```
1. Acta Pharm Sin B. 2016 Jan;6(1):26-31. doi: 10.1016/j.apsb.2015.09.008. Epub 
2015 Nov 24.

Direct anti-HCV agents.

Zhang X(1).

Author information:
(1)Division of Infectious Diseases, University of California, San Diego School 
of Medicine, La Jolla, CA 92093, USA.

Unlike human immunodeficiency virus (HIV) and hepatitis B virus (HBV), hepatitis 
C virus (HCV) infection is a curable disease. Current direct antiviral agent 
(DAA) targets are focused on HCV NS3/4A protein (protease), NS5B protein 
(polymerase) and NS5A protein. The first generation of DAAs includes boceprevir 
and telaprevir, which are protease inhibitors and were approved for clinical use 
in 2011. The cure rate for genotype 1 patients increased from 45% to 70% when 
boceprevir or telaprevir was added to standard PEG-IFN/ribavirin. More effective 
and less toxic second generation DAAs supplanted these drugs by 2013. The second 
generation of DAAs includes sofosbuvir (Sovaldi), simeprevir (Olysio), and fixed 
combination medicines Harvoni and Viekira Pak. These drugs increase cure rates 
to over 90% without the need for interferon and effectively treat all HCV 
genotypes. With these drugs the "cure HCV" goal has become a reality. Concerns 
remain about drug resistance mutations and the high cost of these drugs. The 
investigation of new HCV drugs is progressing rapidly; fixed dose combination 
medicines in phase III clinical trials include Viekirax, 
asunaprevir+daclatasvir+beclabuvir, grazoprevir+elbasvir and others.
```

## Diagnostic claim anchors (scorer reference)

- Reviews direct-acting antiviral (DAA) agents against hepatitis C virus.
- Covers NS5A, NS3/4A, NS5B inhibitor classes and resistance-associated substitutions.
- Hepatology / virology / pharmacology subject area.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### heldout-hepc-ns5a__lookup_pmid.txt

```
# command: lookup pmid 26904396
# captured: 2026-05-22T00:20:02.1539126-07:00

Found 1 papers

  1. Direct anti-HCV agents
     Xingquan Zhang
     PMC4724659 · Acta Pharmaceutica Sinica. B · 2015
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4724659/


```

### heldout-hepc-ns5a__ls.txt

```
# command: ls /papers/PMC4724659/
# captured: 2026-05-22T00:20:04.3303412-07:00

meta.json  content.lines  (65 lines)  sections/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### heldout-hepc-ns5a__map_n_probe.txt

```
# command: map --from s_97706ecf -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:20:08.8833335-07:00

Map complete: 5/5 tasks succeeded in 1840ms
Results ID: m_47bea0fb
Full results: /.gxl/map_m_47bea0fb.txt

  [success] The Cyclophilin Inhibitor Rencofilstat Decreases HCV-induced Hepatocel  (bio_5c3736076d72)
    The paper claims that the cyclophilin inhibitor rencofilstat decreases HCV-induced hepatocellular carcinoma (HCC) in humanized mice through a mechanis
  [success] New Antiviral Agents for Hepatitis C  (PMC3292288)
    The paper claims that while the recent approval of first-generation NS3-4A protease inhibitors (telaprevir and boceprevir) in combination with pegylat
  [success] In Vitro Evaluation of Cytotoxic and Anti-HCV-4 Properties of Sofosbuv  (arx_2009.06041)
    The provided text consists only of the title; it contains no content regarding the paper's claims, methodology, or results. Therefore, this informatio
  [success] Direct-Acting Antivirals for the Treatment of Chronic Hepatitis C: Ope  (PMC3687480)
    The paper claims that while first-generation direct-acting antivirals (DAAs) like telaprevir and boceprevir have improved treatment for chronic hepati
  [success] Direct anti-HCV agents  (PMC4724659)
    The central claim of this paper is that the development of second-generation direct-acting antiviral agents (DAAs) targeting HCV NS3/4A, NS5A, and NS5

Full results: /.gxl/map_m_47bea0fb.txt

```

### heldout-hepc-ns5a__search_title.txt

```
# command: search -t --all "Direct anti-HCV agents" -n 5
# captured: 2026-05-22T00:20:02.9139090-07:00

Found 5 papers  [s_ebfa8409]

  1. The Cyclophilin Inhibitor Rencofilstat Decreases HCV-induced Hepatocellular Carcinoma Independently of Its Antiviral Activity
     Winston Stauffer, Michael Bobardt, Daren Ure, Robert Foster, Philippe Gallay *
     bio_5c3736076d72 · bioRxiv · 2023-08-19
     https://doi.org/10.1101/2023.08.19.553982
     "Rencofilstat, a cyclophilin inhibitor, was studied for its effect on HCV-induced liver cancer. It significantly reduces HCC progression, independent of its antiviral activity."

  2. New Antiviral Agents for Hepatitis C
     Jean-Michel Pawlotsky
     PMC3292288 · PMC · 2012-03-01
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3292288/
     "This paper reviews direct-acting antivirals and host-targeted agents for hepatitis C. These new treatments, used with or without interferon, are advancing clinical development."

  3. In Vitro Evaluation of Cytotoxic and Anti-HCV-4 Properties of Sofosbuvir   Encapsulated Chitosan Nanoparticles
     Samah A. Loutfy, Hosam G Abdelhady, Mostafa H. Elberry, Ahmed R. Hamed, Hussien Ahmed, M T M Hasanin...
     arx_2009.06041 · arXiv · 2020-09-13
     "Researchers investigated sofosbuvir-loaded chitosan nanoparticles for improved Hepatitis C treatment. These nanoparticles effectively eliminated HCV RNA from infected cells with no observed toxicity."

  4. Direct-Acting Antivirals for the Treatment of Chronic Hepatitis C: Open Issues and Future Perspectives
     Hee Bok Chae, Seon Mee Park, Sei Jin Youn
     PMC3687480 · PMC · 2013-01-01
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3687480/
     "This paper reviews direct-acting antivirals for Hepatitis C treatment, focusing on current drugs and future drug classes. It concludes that oral drug combinations are essential for high cure rates and preventing resistance."

  5. Direct anti-HCV agents
     Xingquan Zhang
     PMC4724659 · PMC · 2015-11-24
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4724659/
     "Direct-acting antiviral agents target HCV proteins like protease, polymerase, and NS5A. Second-generation DAAs achieve over 90% cure rates for all HCV genotypes without interferon."

[289ms, saved to s_ebfa8409]

💡 Extract data across these results with: map --from s_ebfa8409 "your question"

```

### heldout-hepc-ns5a__wc.txt

```
# command: wc /papers/PMC4724659/content.lines
# captured: 2026-05-22T00:20:05.4063121-07:00

65    3852   24665 /papers/PMC4724659/content.lines

```


