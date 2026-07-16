---
case_id: heldout-podoconiosis
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: heldout-podoconiosis | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `heldout-podoconiosis__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:33558538"}
# status: OK

{
  "paperId": "3b479d10759b3751314ffc688ba752c1eb62f94c",
  "externalIds": {
    "PubMedCentral": "7870958",
    "DOI": "10.1038/s41598-021-81836-x",
    "CorpusId": 231872740,
    "PubMed": "33558538"
  },
  "url": "https://www.semanticscholar.org/paper/3b479d10759b3751314ffc688ba752c1eb62f94c",
  "title": "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups",
  "venue": "Scientific Reports",
  "year": 2021,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://www.nature.com/articles/s41598-021-81836-x.pdf",
    "status": "GOLD",
    "license": "CCBY",
    "disclaimer": "Notice: Paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7870958, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2021-02-08",
  "journal": {
    "name": "Scientific Reports",
    "volume": "11"
  },
  "authors": [
    {
      "authorId": "114251359",
      "name": "T. Gebresilase"
    },
    {
      "authorId": "2328949083",
      "name": "Chris Finan"
    },
    {
      "authorId": "32002458",
      "name": "D. Suveges"
    },
    {
      "authorId": "8092028",
      "name": "Tesfaye Sisay Tessema"
    },
    {
      "authorId": "3525042",
      "name": "A. Aseffa"
    },
    {
      "authorId": "145139555",
      "name": "G. Davey"
    },
    {
      "authorId": "6478851",
      "name": "K. Hatzikotoulas"
    },
    {
      "authorId": "1924695",
      "name": "E. Zeggini"
    },
    {
      "authorId": "2200215",
      "name": "M. Newport"
    },
    {
      "authorId": "1398789008",
      "name": "F. Tekola-Ayele"
    }
  ],
  "abstract": "Podoconiosis, a debilitating lymphoedema of the leg, results from barefoot exposure to volcanic clay soil in genetically susceptible individuals. A previous genome-wide association study (GWAS) conducted in the Wolaita ethnic group from Ethiopia showed association between single nucleotide polymorphisms (SNPs) in the HLA class II region and podoconiosis. We aimed to conduct a second GWAS in a new sample (N = 1892) collected from the Wolaita and two other Ethiopian populations, the Amhara and the Oromo, also affected by podoconiosis. Fourteen SNPs in the HLA class II region showed significant genome-wide association (P < 5.0 × 10−8) with podoconiosis. The lead SNP was rs9270911 (P = 5.51 × 10−10; OR 1.53; 95% CI 1.34–1.74), located near HLA-DRB1. Inclusion of data from the first GWAS (combined N = 2289) identified 47 SNPs in the class II HLA region that were significantly associated with podoconiosis (lead SNP also rs9270911 (P = 2.25 × 10−12). No new loci outside of the HLA class II region were identified in this more highly-powered second GWAS. Our findings confirm the HLA class II association with podoconiosis suggesting HLA-mediated abnormal induction and regulation of immune responses may have a direct role in its pathogenesis."
}
```

### `heldout-podoconiosis__snippet.txt`

```
# tool: snippet_search
# args: {"query": "HLA class II locus podoconiosis susceptibility Ethiopian ethnic groups", "paper_ids": "PMID:33558538"}
# status: OK

{
  "data": [
    {
      "score": 1.3012834747681619,
      "paper": {
        "corpusId": "231872740",
        "title": "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups",
        "authors": [
          "T. Gebresilase",
          "Chris Finan",
          "D. Suveges",
          "Tesfaye Sisay Tessema",
          "A. Aseffa",
          "G. Davey",
          "K. Hatzikotoulas",
          "E. Zeggini",
          "M. Newport",
          "F. Tekola-Ayele"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7870958, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups",
        "snippetKind": "title",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 114
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.738148931949152,
      "paper": {
        "corpusId": "231872740",
        "title": "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups",
        "authors": [
          "T. Gebresilase",
          "Chris Finan",
          "D. Suveges",
          "Tesfaye Sisay Tessema",
          "A. Aseffa",
          "G. Davey",
          "K. Hatzikotoulas",
          "E. Zeggini",
          "M. Newport",
          "F. Tekola-Ayele"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7870958, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Using a genome-wide approach, we have confirmed the reported association between HLA class II variants and podoconiosis in an independent study that included 1892 new samples from three ethnic groups from Ethiopia, where podoconiosis is endemic. We found significant genome-wide association with 14 common variants in the HLA class II region on chromosome 6p21.3. The strongest association was with rs9270911, a regulatory variant located near HLA-DRB1. Other strongly associated variants were located near HLA-DQA1 and HLA-DQB1 which are contiguous and in LD with HLA-DRB1. The association was confirmed independently in the Oromia and Amhara groups, which have not previously been studied. The significance of the association was strengthened when the original Wolaita samples were included in the analysis (making a total of 2289 samples) with 47 common variants in the HLA class II region showing significant association with podoconiosis. This sample size was almost six times larger than that of the first podoconiosis GWAS (397 individuals) yet no variants outside the HLA class II region were found to be associated with podoconiosis suggesting a single major locus is predominantly responsible for genetic susceptibility to podoconiosis. This is consistent with a segregation analysis undertaken on multicase Wolaita families 15 , but even larger association studies would be required to identify loci with minor effects. \n\nGenes within the HLA class II region encode numerous molecules that have critical functions in the adaptive immune system. The polymorphic HLA-DRB1 encodes the β chain of the HLA class II glycoprotein HLA-DR, which together with the α chain (encoded by HLA-DRA which is not polymorphic) forms a functional Association between HLA gene alleles and haplotypes and immune-mediated disorders is well established. These include autoimmune diseases such as type I diabetes mellitus (T1D), type 1 narcolepsy (T1N), coeliac disease and multiple sclerosis; infectious diseases such as leprosy and malaria; and aberrant reactions to molecules including beryllium and the anti-retroviral drug abacavir.",
        "snippetKind": "body",
        "section": "Discussion",
        "snippetOffset": {
          "start": 11523,
          "end": 13647
        },
        "annotations": {
          "refMentions": [
            {
              "start": 1335,
              "end": 1337,
              "matchedPaperCorpusId": "42687586"
            }
          ],
          "sentences": [
            {
              "start": 0,
              "end": 245
            },
            {
              "start": 246,
              "end": 363
            },
            {
              "start": 364,
              "end": 453
            },
            {
              "start": 454,
              "end": 574
            },
            {
              "start": 575,
              "end": 691
            },
            {
              "start": 692,
              "end": 943
            },
            {
              "start": 944,
              "end": 1246
            },
            {
              "start": 1247,
              "end": 1430
            },
            {
              "start": 1433,
              "end": 1555
            },
            {
              "start": 1556,
              "end": 1841
            },
            {
              "start": 1842,
              "end": 2124
            }
          ]
        }
      }
    },
    {
      "score": 0.6144385596678819,
      "paper": {
        "corpusId": "231872740",
        "title": "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups",
        "authors": [
          "T. Gebresilase",
          "Chris Finan",
          "D. Suveges",
          "Tesfaye Sisay Tessema",
          "A. Aseffa",
          "G. Davey",
          "K. Hatzikotoulas",
          "E. Zeggini",
          "M. Newport",
          "F. Tekola-Ayele"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7870958, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Podoconiosis, a debilitating lymphoedema of the leg, results from barefoot exposure to volcanic clay soil in genetically susceptible individuals. A previous genome-wide association study (GWAS) conducted in the Wolaita ethnic group from Ethiopia showed association between single nucleotide polymorphisms (SNPs) in the HLA class II region and podoconiosis. We aimed to conduct a second GWAS in a new sample (N = 1892) collected from the Wolaita and two other Ethiopian populations, the Amhara and the Oromo, also affected by podoconiosis. Fourteen SNPs in the HLA class II region showed significant genome-wide association (P < 5.0 × 10−8) with podoconiosis. The lead SNP was rs9270911 (P = 5.51 × 10−10; OR 1.53; 95% CI 1.34–1.74), located near HLA-DRB1. Inclusion of data from the first GWAS (combined N = 2289) identified 47 SNPs in the class II HLA region that were significantly associated with podoconiosis (lead SNP also rs9270911 (P = 2.25 × 10−12). No new loci outside of the HLA class II region were identified in this more highly-powered second GWAS. Our findings confirm the HLA class II association with podoconiosis suggesting HLA-mediated abnormal induction and regulation of immune responses may have a direct role in its pathogenesis.",
        "snippetKind": "abstract",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 1251
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    }
  ],
  "retrievalVersion": "pa1-v1"
}
```
