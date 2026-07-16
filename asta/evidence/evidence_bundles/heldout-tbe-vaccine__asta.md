---
case_id: heldout-tbe-vaccine
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: heldout-tbe-vaccine | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `heldout-tbe-vaccine__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:23997980"}
# status: OK

{
  "paperId": "6d9aeec2fb26eeea09efec7048de13fc40f38f57",
  "externalIds": {
    "MAG": "2054747926",
    "PubMedCentral": "3755374",
    "DOI": "10.4172/2157-2526.S1-003",
    "CorpusId": 13665109,
    "PubMed": "23997980"
  },
  "url": "https://www.semanticscholar.org/paper/6d9aeec2fb26eeea09efec7048de13fc40f38f57",
  "title": "Tick-borne Encephalitis Vaccines",
  "venue": "Journal of Bioterrorism & Biodefense",
  "year": 2011,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://doi.org/10.4172/2157-2526.s1-003",
    "status": "HYBRID",
    "license": "CCBY",
    "disclaimer": "Notice: Paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC3755374, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2011-09-25",
  "journal": {
    "name": "Journal of bioterrorism & biodefense",
    "volume": "2011"
  },
  "authors": [
    {
      "authorId": "38054197",
      "name": "A. Lehrer"
    },
    {
      "authorId": "3052530",
      "name": "M. Holbrook"
    }
  ],
  "abstract": "Tick-borne encephalitis (TBE) is a disease that is found from western Europe across Asia and into Japan. In recent years the incidence rate has been increasing as has the endemic range of the virus. Tick-borne encephalitis is caused by three genetically distinct sutypes of viruses within a single TBE virus (TBEV) serocomplex. These three subtypes consist of Far-eastern subtype TBEV (TBEV-FE), Siberian subtype (TBEV-Sib) and European subtype (TBEV-Eu). Each of these subtypes cause clinically distinct diseases with varying degrees of severity. Development of the first vaccines for TBEV began in the late 1930s shortly after the first isolation of TBEV-FE in Russia. In the 1970s Austria began large scale vaccine production and a nationalized vaccine campaign that significantly reduced the incidence rate of TBE. Currently there are four licensed TBE vaccines, two in Europe and two in Russia. These vaccines are all quite similar formalin-inactivated virus vaccines but the each use a different virus strain for production. Published studies have shown that European vaccines are cross-protective in rodent studies and elicit cross-reactive neutralizing antibody responses in human vaccines. European vaccines have been licensed for a rapid vaccine schedule that could be used in response to a significant outbreak and reasonable neutralizing antibody titers can be achieved after a single dose although a second dose provides nearly complete and long-lasting protection. This review focuses on the current status of licensed TBE vaccines and provides a brief summary of technology currently being developed for new vaccines."
}
```

### `heldout-tbe-vaccine__snippet.txt`

```
# tool: snippet_search
# args: {"query": "tick-borne encephalitis vaccine schedule immunogenicity", "paper_ids": "PMID:23997980"}
# status: OK

{
  "data": [
    {
      "score": 0.5205843302241141,
      "paper": {
        "corpusId": "13665109",
        "title": "Tick-borne Encephalitis Vaccines",
        "authors": [
          "A. Lehrer",
          "M. Holbrook"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "HYBRID",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC3755374, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Tick-borne Encephalitis Vaccines",
        "snippetKind": "title",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 32
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.40596010942934,
      "paper": {
        "corpusId": "13665109",
        "title": "Tick-borne Encephalitis Vaccines",
        "authors": [
          "A. Lehrer",
          "M. Holbrook"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "HYBRID",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC3755374, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Tick-borne encephalitis (TBE) is a disease that is found from western Europe across Asia and into Japan. In recent years the incidence rate has been increasing as has the endemic range of the virus. Tick-borne encephalitis is caused by three genetically distinct sutypes of viruses within a single TBE virus (TBEV) serocomplex. These three subtypes consist of Far-eastern subtype TBEV (TBEV-FE), Siberian subtype (TBEV-Sib) and European subtype (TBEV-Eu). Each of these subtypes cause clinically distinct diseases with varying degrees of severity. Development of the first vaccines for TBEV began in the late 1930s shortly after the first isolation of TBEV-FE in Russia. In the 1970s Austria began large scale vaccine production and a nationalized vaccine campaign that significantly reduced the incidence rate of TBE. Currently there are four licensed TBE vaccines, two in Europe and two in Russia. These vaccines are all quite similar formalin-inactivated virus vaccines but the each use a different virus strain for production. Published studies have shown that European vaccines are cross-protective in rodent studies and elicit cross-reactive neutralizing antibody responses in human vaccines. European vaccines have been licensed for a rapid vaccine schedule that could be used in response to a significant outbreak and reasonable neutralizing antibody titers can be achieved after a single dose although a second dose provides nearly complete and long-lasting protection. This review focuses on the current status of licensed TBE vaccines and provides a brief summary of technology currently being developed for new vaccines.",
        "snippetKind": "abstract",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 1632
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.3297064263712801,
      "paper": {
        "corpusId": "13665109",
        "title": "Tick-borne Encephalitis Vaccines",
        "authors": [
          "A. Lehrer",
          "M. Holbrook"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "HYBRID",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC3755374, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "and Hyalomma spp. Soft ticks from the genus Ornithodoros have also been associated with transmission of some tick-borne flaviviruses including ALKV [14,15]. There has been some suggestion that tick-borne flaviviruses are transmitted by mosquitoes, but this has not been conclusively proven. \n\nThe flaviviruses are a family of small, single-stranded RNA viruses with a positive-sense genome and a host-derived lipid envelope. The viral genome encodes a single polyprotein that is co-and posttranslationally cleaved into ten individual proteins, three structural and seven non-structural. The three structural proteins (C-capsid, prM/M-premembrane/membrane and E-envelope) organize to produce the viral particle. The non-structural proteins are principally associated with viral replication, polyprotein cleavage and may have additional roles in regulating the host immune response [16,17]. The viral E protein is the major surface antigen for the flaviviruses and contains the receptor-binding domain and fusion peptide. The viral prM/M protein functions as a chaperone for the E protein and also blocks the fusion peptide during virus assembly to prevent fusion with exocytic vesicles. The prM protein is cleaved by furin following particle assembly to produce the mature fusogenic virus. Co-expression of the prM and E genes in cell culture systems have been used to produce subviral particles which were used in early characterization of the membrane fusion process of flavivirus entry and have also have been tested as potential vaccine candidates. Vaccine candidates for several flaviviruses, including West Nile and dengue viruses utilize a purified recombinant E protein that has been produced in insect cell cultures [18][19][20][21][22]. Tick-borne encephalitis was first described in 1936 as a neurologic disease in far eastern Russia (then the Soviet Union) that had been recognized in 1932. In 1937 a large expedition supported by the Soviet government identified Ix. persulcatus ticks as the likely vector for the contagion.",
        "snippetKind": "body",
        "section": "Introduction",
        "snippetOffset": {
          "start": 3683,
          "end": 5719
        },
        "annotations": {
          "refMentions": [
            {
              "start": 148,
              "end": 152,
              "matchedPaperCorpusId": "14993298"
            },
            {
              "start": 152,
              "end": 155,
              "matchedPaperCorpusId": "10528374"
            },
            {
              "start": 880,
              "end": 884,
              "matchedPaperCorpusId": "22985560"
            },
            {
              "start": 884,
              "end": 887,
              "matchedPaperCorpusId": "4232236"
            },
            {
              "start": 1724,
              "end": 1728,
              "matchedPaperCorpusId": "37330280"
            },
            {
              "start": 1728,
              "end": 1732,
              "matchedPaperCorpusId": "6501045"
            },
            {
              "start": 1732,
              "end": 1736,
              "matchedPaperCorpusId": "13370236"
            },
            {
              "start": 1736,
              "end": 1740,
              "matchedPaperCorpusId": "11614700"
            },
            {
              "start": 1740,
              "end": 1744,
              "matchedPaperCorpusId": "41828055"
            }
          ],
          "sentences": [
            {
              "start": 0,
              "end": 17
            },
            {
              "start": 18,
              "end": 156
            },
            {
              "start": 157,
              "end": 290
            },
            {
              "start": 293,
              "end": 424
            },
            {
              "start": 425,
              "end": 586
            },
            {
              "start": 587,
              "end": 710
            },
            {
              "start": 711,
              "end": 888
            },
            {
              "start": 889,
              "end": 1019
            },
            {
              "start": 1020,
              "end": 1185
            },
            {
              "start": 1186,
              "end": 1288
            },
            {
              "start": 1289,
              "end": 1551
            },
            {
              "start": 1552,
              "end": 1901
            },
            {
              "start": 1902,
              "end": 2036
            }
          ]
        }
      }
    }
  ],
  "retrievalVersion": "pa1-v1"
}
```
