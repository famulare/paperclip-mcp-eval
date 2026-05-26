# Evidence Bundle: heldout-podoconiosis | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** PMID 33558538
**Case notes:** Held-out outside-wheelhouse: NTD genetics.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: heldout-podoconiosis

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Podoconiosis HLA genetic association
**Case type:** concept-discovery outside wheelhouse
**Wheelhouse:** no

## PubMed source-of-record

- **PMID:** 33558538
- **PMCID:** PMC7870958
- **DOI:** 10.1038/s41598-021-81836-x
- **Title:** Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups.
- **Authors (top 6):** Gebresilase T; Finan C; Suveges D; Tessema TS; Aseffa A; Davey G; et al.
- **Journal:** Scientific reports
- **Pub date:** 2021 Feb 8

## Abstract (fair-use snippet)

```
1. Sci Rep. 2021 Feb 8;11(1):3285. doi: 10.1038/s41598-021-81836-x.

Replication of HLA class II locus association with susceptibility to 
podoconiosis in three Ethiopian ethnic groups.

Gebresilase T(1)(2), Finan C(3), Suveges D(4)(5), Tessema TS(2), Aseffa A(1), 
Davey G(6), Hatzikotoulas K(4)(7)(8), Zeggini E(4)(7)(8), Newport MJ(9), 
Tekola-Ayele F(10).

Author information:
(1)Armauer Hansen Research Institute (AHRI), Addis Ababa, Ethiopia.
(2)Unit of Health Biotechnology, Institute of Biotechnology, College of Natural 
and Computational Sciences, Addis Ababa University, Addis Ababa, Ethiopia.
(3)Institute of Cardiovascular Science, Faculty of Population Health, University 
College London, London, UK.
(4)Wellcome Trust Sanger Institute, Hinxton, Cambridge, UK.
(5)European Bioinformatics Institute, Hinxton, Cambridge, UK.
(6)Brighton and Sussex Centre for Global Health Research, Brighton and Sussex 
Medical School, Brighton, UK.
(7)Institute of Translational Genomics, Helmholtz Zentrum München - German 
Research Center for Environmental Health, Neuherberg, Germany.
(8)TUM School of Medicine, Technical University of Munich and Klinikum Rechts 
Der Isar, Munich, Germany.
(9)Brighton and Sussex Centre for Global Health Research, Brighton and Sussex 
Medical School, Brighton, UK. m.j.newport@bsms.ac.uk.
(10)Epidemiology Branch, Division of Intramural Population Health Research, 
Eunice Kennedy Shriver National Institute of Child Health and Human Development, 
National Institutes of Health, Bethesda, MD, USA.

Podoconiosis, a debilitating lymphoedema of the leg, results from barefoot 
exposure to volcanic clay soil in genetically susceptible individuals. A 
previous genome-wide association study (GWAS) conducted in the Wolaita ethnic 
group from Ethiopia showed association between single nucleotide polymorphisms 
(SNPs) in the HLA class II region and podoconiosis. We aimed to conduct a second 
GWAS in a new sample (N = 1892) collected from the Wolaita and two other 
Ethiopian populations, the Amhara and the Oromo, also affected by podoconiosis. 
Fourteen SNPs in the HLA class II region showed significant genome-wide 
association (P < 5.0 × 10-8) with podoconiosis. The lead SNP was rs9270911 
(P = 5.51 × 10-10; OR 1.53; 95% CI 1.34-1.74), located near HLA-DRB1. Inclusion 
of data from the first GWAS (combined N = 2289) identified 47 SNPs in the class 
II HLA region that were significantly associated with podoconiosis (lead SNP 
also rs9270911 (P = 2.25 × 10-12). No new loci outside of the HLA class II 
region were identified in this more highly-powered second GWAS. Our findings 
confirm the HLA class II association with podoconiosis suggesting HLA-mediated 
abnormal induction and regulation of immune responses may have a direct role in 
its pathogenesis.
```

## Diagnostic claim anchors (scorer reference)

- Replicates HLA class II locus association with podoconiosis susceptibility across three Ethiopian ethnic groups.
- Genetic / NTD (neglected tropical disease) subject area.
- Tests Paperclip's coverage of African genetic epidemiology and NTD literature.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### heldout-podoconiosis__lookup_pmid.txt

```
# command: lookup pmid 33558538
# captured: 2026-05-22T00:20:23.9831547-07:00

Found 1 papers

  1. Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups
     Tewodros Gebresilase, Chris Finan, Daniel Suveges, Tesfaye Sisay Tessema, Abraham Aseffa, Gail Davey...
     PMC7870958 · Scientific Reports · 2021
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7870958/


```

### heldout-podoconiosis__ls.txt

```
# command: ls /papers/PMC7870958/
# captured: 2026-05-22T00:20:26.3141125-07:00

meta.json  content.lines  (134 lines)  sections/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### heldout-podoconiosis__map_n_probe.txt

```
# command: map --from s_004d5954 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:20:31.3794426-07:00

Map complete: 5/5 tasks succeeded in 2084ms
Results ID: m_96c0ef1e
Full results: /.gxl/map_m_96c0ef1e.txt

  [success] Replication of HLA class II locus association with susceptibility to p  (PMC7870958)
    The central empirical claim of this paper is that the association between HLA class II variants and susceptibility to podoconiosis is confirmed across
  [success] Confirmation of HLA-II associations with TB susceptibility in admixed   (med_6470252a6d97)
    The paper claims that the "local ancestry allelic adjusted association" (LAAA) model successfully identifies a near-genome-wide significant associatio
  [success] The class of the bielliptic locus in genus 3  (arx_1206.4301)
    The provided text contains only the title of the paper ("The class of the bielliptic locus in genus 3") and lacks the body content. Therefore, the cen
  [success] Evidence for immune activation in pathogenesis of the HLA class II ass  (PMC10917762)
    The central claim of this paper is that podoconiosis is a soil particle-driven, HLA-associated disease characterized by a state of persistent immune a
  [success] Prediction of HLA Class II Alleles Using SNPs in an African Population  (PMC3386230)
    The central claim of this paper is that HLA class II alleles (HLA-DRB1 and HLA-DQB1) can be predicted from SNP genotype data with a high level of accu

Full results: /.gxl/map_m_96c0ef1e.txt

```

### heldout-podoconiosis__search_title.txt

```
# command: search -t --all "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups" -n 5
# captured: 2026-05-22T00:20:25.3244186-07:00

Found 3 papers  [s_1cfc1d10]

  1. Confirmation of HLA-II associations with TB susceptibility in admixed African samples
     Dayna Croock, Yolandi Swart, Haiko Schurz, Desiree C. Petersen, Marlo Möller, Caitlin Uren *
     med_6470252a6d97 · medRxiv · 2024-05-30
     https://doi.org/10.1101/2024.05.30.24308060
     "This study investigated TB susceptibility in an admixed South African cohort using a local ancestry adjusted model. A significant association was found in the HLA-DPB1 gene, confirming its role in TB susceptibility in this population."

  2. The class of the bielliptic locus in genus 3
     Carel Faber and Nicola Pagani
     arx_1206.4301 · arXiv · 2012-06-19
     "Researchers calculated the bielliptic locus class in the moduli space of genus 3 curves. This class was determined by intersecting the locus with specific surfaces."

  3. Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups
     Tewodros Gebresilase, Chris Finan, Daniel Suveges, Tesfaye Sisay Tessema, Abraham Aseffa, Gail Davey...
     PMC7870958 · PMC · 2021-02-08
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7870958/
     "This study replicated a genome-wide association study for podoconiosis susceptibility in three Ethiopian ethnic groups. The HLA class II region was confirmed to be significantly associated with the disease, suggesting a role for immune responses in its pathogenesis."

[802ms, saved to s_1cfc1d10]

💡 Extract data across these results with: map --from s_1cfc1d10 "your question"

```

### heldout-podoconiosis__wc.txt

```
# command: wc /papers/PMC7870958/content.lines
# captured: 2026-05-22T00:20:27.0416370-07:00

134    8412   55364 /papers/PMC7870958/content.lines

```


