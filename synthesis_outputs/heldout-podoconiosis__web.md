---
case_id: heldout-podoconiosis
arm: web
synthesizer: Claude Opus 4.7
date: 2026-05-22
---

# Synthesis Output: heldout-podoconiosis | Arm: Live web/API

## Retrieval validity status

Retrieval succeeded. The web/API bundle returned authoritative metadata for the requested identifier PMID 33558538, including PMCID (PMC7870958), DOI (10.1038/s41598-021-81836-x), title ("Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups."), ten named authors with institutional affiliations, journal (Scientific Reports), publication date (2021 Feb 8), and a fair-use abstract snippet. Identifier resolution is consistent across PMID, PMCID, and DOI. No conflicting or duplicate records. Bundle is metadata + abstract only; no full text, figures, supplementary materials, or methods detail beyond the abstract were retrieved.

## Available context

- Bibliographic identity: PMID 33558538 / PMCID PMC7870958 / DOI 10.1038/s41598-021-81836-x.
- Article: Gebresilase T, Finan C, Suveges D, Tessema TS, Aseffa A, Davey G, Hatzikotoulas K, Zeggini E, Newport MJ, Tekola-Ayele F. "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups." Scientific Reports, 2021 Feb 8;11(1):3285.
- Author affiliations span: Armauer Hansen Research Institute (Addis Ababa); Addis Ababa University Institute of Biotechnology; University College London (Institute of Cardiovascular Science); Wellcome Trust Sanger Institute (Hinxton, Cambridge); European Bioinformatics Institute (Hinxton); Brighton and Sussex Medical School (Centre for Global Health Research); Helmholtz Zentrum München (Institute of Translational Genomics); Technical University of Munich (TUM School of Medicine, Klinikum Rechts Der Isar); NIH Eunice Kennedy Shriver National Institute of Child Health and Human Development (Epidemiology Branch, Bethesda).
- Corresponding author tag indicates M.J. Newport (Brighton and Sussex Medical School).
- Disease: podoconiosis, characterized in the abstract as "a debilitating lymphoedema of the leg" resulting from "barefoot exposure to volcanic clay soil in genetically susceptible individuals."
- Study design: second/replication GWAS in a new sample (N = 1892) from three Ethiopian ethnic populations - Wolaita, Amhara, and Oromo - all reported to be affected by podoconiosis.
- Prior context cited in the abstract: a previous GWAS conducted in the Wolaita group from Ethiopia had shown association between SNPs in the HLA class II region and podoconiosis.
- Reported results:
  - 14 SNPs in the HLA class II region reached genome-wide significance (P < 5.0 × 10^-8) in the new-sample GWAS.
  - Lead SNP: rs9270911 (P = 5.51 × 10^-10; OR 1.53; 95% CI 1.34-1.74), located near HLA-DRB1.
  - Combined analysis with the first GWAS (combined N = 2289) identified 47 SNPs in the HLA class II region significantly associated with podoconiosis; lead SNP remained rs9270911 (P = 2.25 × 10^-12).
  - No new loci outside the HLA class II region were identified in the more highly-powered second GWAS.
- Reported interpretation: findings confirm HLA class II association with podoconiosis and suggest HLA-mediated abnormal induction and regulation of immune responses may have a direct role in pathogenesis.
- Statistical framework named in the abstract: GWAS with standard genome-wide significance threshold (P < 5.0 × 10^-8); reported per-SNP odds ratio with 95% confidence interval. No methods detail beyond the abstract is in the bundle (genotyping platform, imputation reference, ancestry/PCA controls, case-control matching, quality-control filters, fine-mapping, conditional analysis, heritability estimation, replication thresholds).

## 8 prompts

### 1. What is the paper's primary topic and scope?

The paper is a replication genome-wide association study (GWAS) of podoconiosis - a non-filarial, non-infectious lower-limb lymphoedema attributed in the abstract to barefoot exposure to volcanic clay soil in genetically susceptible individuals - in three Ethiopian ethnic populations (Wolaita, Amhara, Oromo). Scope is concept-focused: the study tests whether the previously reported HLA class II association observed in a first GWAS conducted in the Wolaita population alone replicates in a larger, multi-ethnic Ethiopian sample, and whether expanded sample size reveals any new loci outside the HLA class II region. The unit of analysis is per-SNP association with case-control status for podoconiosis; the geographic and ancestral scope is restricted to three Ethiopian ethnic groups; no extra-Ethiopian or non-podoconiosis comparison populations are mentioned in the abstract.

### 2. What are the main claims or findings?

From the abstract:
- In the new-sample GWAS (N = 1892), 14 SNPs in the HLA class II region show genome-wide significant association (P < 5.0 × 10^-8) with podoconiosis.
- The lead SNP is rs9270911, located near HLA-DRB1, with P = 5.51 × 10^-10, odds ratio 1.53, and 95% CI 1.34-1.74.
- A combined analysis incorporating the original Wolaita-only GWAS (combined N = 2289) identifies 47 SNPs in the HLA class II region as genome-wide significant, with rs9270911 remaining the lead SNP (P = 2.25 × 10^-12).
- No new loci outside the HLA class II region are identified in the more highly-powered second GWAS.
- The authors conclude that the HLA class II association with podoconiosis is confirmed and that HLA-mediated abnormal induction and regulation of immune responses may have a direct role in pathogenesis.

### 3. What methods were used?

From the abstract:
- Study type: replication genome-wide association study, conducted in a "new sample" distinct from a prior Wolaita-only GWAS, with combined analysis of both samples as a secondary step.
- Sample: N = 1892 in the new-sample GWAS; combined N = 2289 when integrated with the first GWAS.
- Populations: three Ethiopian ethnic groups - Wolaita, Amhara, Oromo - all "affected by podoconiosis."
- Primary statistical test: per-SNP association with case-control status; genome-wide significance threshold P < 5.0 × 10^-8.
- Reported per-SNP effect estimate: odds ratio with 95% confidence interval for the lead SNP.
- The abstract does not specify: case definition criteria (clinical staging of podoconiosis), control selection criteria, genotyping platform, imputation reference panel, ancestry adjustment / principal-components correction, sex/age covariate handling, quality-control filters (call rate, Hardy-Weinberg equilibrium, MAF thresholds), fine-mapping or conditional analysis at the HLA class II locus, classical HLA-allele imputation, heritability or polygenic-risk-score analysis, or how case-control samples were partitioned across the three ethnic groups. These methods details cannot be answered from web/API metadata + abstract only.

### 4. What is the significance or contribution?

The contribution as framed by the abstract is twofold. First, it provides independent replication, in a larger and ethnically broader Ethiopian sample, of the previously reported Wolaita-only HLA class II association with podoconiosis - addressing a standard concern in GWAS for any disease that an initial single-population finding may not generalize. Second, despite the increased sample size and power, no new loci outside HLA class II reach genome-wide significance, which sharpens the genetic-architecture inference toward a predominantly HLA-mediated (and therefore plausibly immune-mediated) susceptibility component for this gene-environment disease. The abstract explicitly draws the mechanistic implication that "HLA-mediated abnormal induction and regulation of immune responses may have a direct role in its pathogenesis," reframing podoconiosis as an immunogenetic disorder triggered by an environmental exposure rather than a purely environmental or purely lymphatic condition. Whether this changes clinical practice, screening, or prevention is not addressed in the abstract.

### 5. What are the limitations or open questions?

The abstract does not enumerate limitations explicitly. From what is reported, the following are apparent constraints, but a fuller limitations discussion cannot be retrieved from web/API metadata + abstract only:
- Geographic/ancestral scope is limited to three Ethiopian ethnic groups; generalizability to podoconiosis-affected populations elsewhere in East Africa, Central America, or other highland volcanic-soil regions is not addressed.
- The negative finding ("no new loci outside HLA class II") at N = 1892 / combined N = 2289 still leaves substantial power gaps for variants of small effect or low frequency; the abstract does not provide a power calculation for what effect sizes would have been detectable.
- The lead SNP rs9270911 lies near HLA-DRB1, but the abstract does not report fine-mapping to a specific causal classical HLA allele or amino-acid residue, nor conditional analysis to assess whether the signal is independent of other class II loci (e.g., HLA-DQB1).
- Gene-environment interaction with the postulated volcanic clay-soil exposure is not directly tested in the analysis described.
- The case-control framework relies on a phenotypic case definition (clinical podoconiosis) whose details and staging are not in the abstract.
- The translation from a population-level OR of 1.53 at a single lead SNP to clinically actionable individual risk prediction is not discussed.
- Replication outside Ethiopian populations and any functional follow-up (HLA peptide binding, immunological assays, in-vitro modeling) are not addressed in the abstract.

### 6. How does this relate to neglected tropical disease genetics and HLA association literature more broadly?

The paper sits at the intersection of (i) podoconiosis epidemiology, a neglected tropical disease (NTD) endemic to barefoot agricultural communities in highland volcanic-soil regions, particularly Ethiopia, and (ii) HLA-disease association genetics, a longstanding subfield in which the class II region has been linked to numerous autoimmune and immune-mediated conditions. The abstract's framing - that podoconiosis arises from soil exposure "in genetically susceptible individuals" with HLA class II involvement - aligns the disease conceptually with immune-mediated processes triggered by an environmental antigen, distinguishing it from filarial lymphoedema (which has an infectious cause) and from purely lymphatic-developmental etiologies. The paper also illustrates a methodological pattern: a first GWAS in a single ethnic group, followed by replication in a multi-ethnic same-region sample, with combined-sample analysis to boost power. Deeper situating within the comparative NTD-genetics literature, comparison to HLA associations in leprosy, schistosomiasis, or filariasis, or the precise relationship between rs9270911 / HLA-DRB1 alleles and other class II disease associations cannot be answered from web/API metadata + abstract only. The author affiliation pattern (Ethiopian field/research institutions paired with European genomic-research centers and a US NIH branch focused on epidemiology) is also consistent with a North-South collaborative model typical of NTD genetics research.

### 7. What is the publication context (journal, date, authorship)?

- Journal: Scientific Reports (Nature Portfolio open-access, multidisciplinary journal).
- Volume/issue/article number: 11(1):3285.
- Publication date: 2021 February 8.
- DOI: 10.1038/s41598-021-81836-x.
- PMID: 33558538; PMCID: PMC7870958 (PMC deposit indicates open-access availability via PubMed Central).
- Authorship: ten named authors - Gebresilase T, Finan C, Suveges D, Tessema TS, Aseffa A, Davey G, Hatzikotoulas K, Zeggini E, Newport MJ, Tekola-Ayele F.
- The author list shows first authorship from an Ethiopian-affiliated researcher (Gebresilase, AHRI / Addis Ababa University) and corresponding authorship (per the email tag) from Newport at Brighton and Sussex Medical School. Affiliations span Ethiopian field/research institutions (AHRI Addis Ababa; Addis Ababa University Institute of Biotechnology), UK academic and genomics centers (UCL Institute of Cardiovascular Science; Wellcome Trust Sanger Institute; EBI; Brighton and Sussex Centre for Global Health Research), German genomics centers (Helmholtz Zentrum München; TUM School of Medicine), and a US public-health-research arm of NIH (Eunice Kennedy Shriver NICHD, Epidemiology Branch). Funding sources, conflict-of-interest disclosures, and contribution statements cannot be determined from the bundle.

### 8. Is this a primary research article or review?

Primary research article. The abstract reports an original genome-wide association study with a defined new sample (N = 1892), specific case-control populations (three Ethiopian ethnic groups), original genotyping and association results (14 genome-wide significant SNPs in the new sample; 47 in the combined analysis), specific statistical results (lead SNP rs9270911 with P-values, odds ratio, and 95% confidence interval), and a conclusion derived from those results. The replication and combined-analysis design is itself original analytical work, not a literature survey. There is no indication of a systematic-review, meta-analytic, or narrative-review structure. MeSH/publication-type fields are not provided in this bundle to confirm formally, but the abstract content is unambiguously that of a primary genetic-epidemiology study.

## Uncertainty

- The bundle is metadata + abstract only. Any prompt requiring methods detail beyond the abstract (genotyping platform, imputation reference, QC filters, ancestry/PCA controls, case-control matching across ethnic groups, classical HLA-allele imputation, fine-mapping or conditional analysis, gene-environment interaction modeling, power calculations) is not answerable from this arm.
- The abstract characterizes podoconiosis as resulting from "barefoot exposure to volcanic clay soil in genetically susceptible individuals." I have not independently verified this etiologic claim from external sources; it is reported as the authors' framing.
- Whether rs9270911 corresponds to a specific HLA-DRB1 classical allele (e.g., DRB1*04 or DRB1*13 lineages) cannot be answered from the abstract. The abstract states only that the SNP is "located near HLA-DRB1."
- The relative contribution of each of the three ethnic groups (Wolaita, Amhara, Oromo) to the overall N = 1892, and whether ethnic-group-stratified results were concordant, are not in the abstract.
- The first/prior GWAS is referenced but not cited within the bundle; its date, sample size, and lead SNP cannot be specified from this material alone.
- Publication-type classification (primary vs review) is inferred from abstract structure; MeSH publication-type tags were not in the bundle.
- Funding sources, ethics-committee approval, informed-consent procedures, and data-sharing arrangements are not in the bundle.
- The abstract reports a per-SNP odds ratio of 1.53 for rs9270911 but does not provide allele frequencies, risk-allele direction, or population-attributable risk estimates.
- The journal's editorial standards, peer-review process specifics, and impact factor are not in the bundle.

## Prohibited inferences

- I have not introduced any external knowledge about HLA biology, HLA-DRB1 allelic structure, podoconiosis epidemiology beyond the abstract, prior GWAS results for podoconiosis, classical HLA-disease association literature, or Ethiopian population genetics beyond what the abstract and metadata state.
- I have not inferred the journal's impact factor, indexing status beyond PubMed/PMC, or the article's citation count.
- I have not inferred peer-review status beyond the fact of PubMed indexing in a Nature Portfolio journal with PMC deposit.
- I have not asserted any specific HLA-DRB1 classical allele as the causal variant tagged by rs9270911; the abstract only states the SNP is "near HLA-DRB1."
- I have not asserted a specific immunological mechanism (e.g., peptide presentation of a soil-derived antigen, autoreactive T-cell activation, Th1/Th2 imbalance, mineral-particle-driven granulomatous response) beyond noting the abstract's framing of "HLA-mediated abnormal induction and regulation of immune responses."
- I have not asserted prevalence figures, mortality, morbidity, or disability burden for podoconiosis beyond the abstract's "debilitating lymphoedema of the leg" description.
- I have not asserted geographic distribution of podoconiosis beyond the Ethiopian populations named in the abstract; in particular, I have not claimed endemicity in other countries, regions, or continents.
- I have not asserted that podoconiosis is or is not a "neglected tropical disease" on the basis of any formal WHO designation; the case-notes framing of "NTD genetics" is acknowledged in prompt 6 as a thematic situating rather than a sourced claim.
- I have not used the scorer-facing "Diagnostic claim anchors" as a source of content; claims in this synthesis are sourced to the abstract text and bibliographic metadata only.
- I have not extrapolated from Ethiopian GWAS results to other populations, to other lymphoedema syndromes (filarial lymphatic filariasis, primary lymphoedema, post-surgical lymphoedema), or to other HLA-mediated diseases.
- I have not assumed any specific clinical case definition or staging system (e.g., Tekola staging) for podoconiosis; the abstract does not specify the case definition used.
- I have not assumed the gene-environment interaction (volcanic clay soil exposure × HLA class II genotype) was formally tested in this study; the abstract describes only the genetic main-effect association.
