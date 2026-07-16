---
case_id: nigeria-2015-versioning
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: nigeria-2015-versioning | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `nigeria-2015-versioning__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:26317401"}
# status: OK

{
  "paperId": "e5004b10cc2d111c4a2187d7263525c6b2733237",
  "externalIds": {
    "PubMedCentral": "4552877",
    "MAG": "1783287906",
    "ArXiv": "1504.02751",
    "DOI": "10.1371/journal.pone.0135765",
    "CorpusId": 17862645,
    "PubMed": "26317401"
  },
  "url": "https://www.semanticscholar.org/paper/e5004b10cc2d111c4a2187d7263525c6b2733237",
  "title": "Has Wild Poliovirus Been Eliminated from Nigeria?",
  "venue": "PLoS ONE",
  "year": 2015,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0135765&type=printable",
    "status": "GOLD",
    "license": "CCBY",
    "disclaimer": "Notice: Paper or abstract available at https://arxiv.org/abs/1504.02751, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2015-04-10",
  "journal": {
    "name": "PLoS ONE",
    "volume": "10"
  },
  "authors": [
    {
      "authorId": "3059487",
      "name": "M. Famulare"
    }
  ],
  "abstract": "Wild poliovirus type 3 (WPV3) has not been seen anywhere since the last case of WPV3-associated paralysis in Nigeria in November 2012. At the time of writing, the most recent case of wild poliovirus type 1 (WPV1) in Nigeria occurred in July 2014, and WPV1 has not been seen in Africa since a case in Somalia in August 2014. No cases associated with circulating vaccine-derived type 2 poliovirus (cVDPV2) have been detected in Nigeria since November 2014. Has WPV1 been eliminated from Africa? Has WPV3 been eradicated globally? Has Nigeria interrupted cVDPV2 transmission? These questions are difficult because polio surveillance is based on paralysis and paralysis only occurs in a small fraction of infections. This report provides estimates for the probabilities of poliovirus elimination in Nigeria given available data as of March 31, 2015. It is based on a model of disease transmission that is built from historical polio incidence rates and is designed to represent the uncertainties in transmission dynamics and poliovirus detection that are fundamental to interpreting long time periods without cases. The model estimates that, as of March 31, 2015, the probability of WPV1 elimination in Nigeria is 84%, and that if WPV1 has not been eliminated, a new case will be detected with 99% probability by the end of 2015. The probability of WPV3 elimination (and thus global eradication) is > 99%. However, it is unlikely that the ongoing transmission of cVDPV2 has been interrupted; the probability of cVDPV2 elimination rises to 83% if no new cases are detected by April 2016."
}
```

### `nigeria-2015-versioning__snippet.txt`

```
# tool: snippet_search
# args: {"query": "wild poliovirus elimination Nigeria surveillance acute flaccid paralysis", "paper_ids": "PMID:26317401"}
# status: OK

{
  "data": [
    {
      "score": 0.6093427829512916,
      "paper": {
        "corpusId": "17862645",
        "title": "Has Wild Poliovirus Been Eliminated from Nigeria?",
        "authors": [
          "M. Famulare"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://arxiv.org/abs/1504.02751, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Has Wild Poliovirus Been Eliminated from Nigeria?",
        "snippetKind": "title",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 49
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.6030697896886628,
      "paper": {
        "corpusId": "17862645",
        "title": "Has Wild Poliovirus Been Eliminated from Nigeria?",
        "authors": [
          "M. Famulare"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://arxiv.org/abs/1504.02751, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Wild poliovirus type 3 (WPV3) has not been seen anywhere since the last case of WPV3-associated paralysis in Nigeria in November 2012. At the time of writing, the most recent case of wild poliovirus type 1 (WPV1) in Nigeria occurred in July 2014, and WPV1 has not been seen in Africa since a case in Somalia in August 2014. No cases associated with circulating vaccine-derived type 2 poliovirus (cVDPV2) have been detected in Nigeria since November 2014. Has WPV1 been eliminated from Africa? Has WPV3 been eradicated globally? Has Nigeria interrupted cVDPV2 transmission? These questions are difficult because polio surveillance is based on paralysis and paralysis only occurs in a small fraction of infections. This report provides estimates for the probabilities of poliovirus elimination in Nigeria given available data as of March 31, 2015. It is based on a model of disease transmission that is built from historical polio incidence rates and is designed to represent the uncertainties in transmission dynamics and poliovirus detection that are fundamental to interpreting long time periods without cases. The model estimates that, as of March 31, 2015, the probability of WPV1 elimination in Nigeria is 84%, and that if WPV1 has not been eliminated, a new case will be detected with 99% probability by the end of 2015. The probability of WPV3 elimination (and thus global eradication) is > 99%. However, it is unlikely that the ongoing transmission of cVDPV2 has been interrupted; the probability of cVDPV2 elimination rises to 83% if no new cases are detected by April 2016.",
        "snippetKind": "abstract",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 1582
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.5068647739429764,
      "paper": {
        "corpusId": "17862645",
        "title": "Has Wild Poliovirus Been Eliminated from Nigeria?",
        "authors": [
          "M. Famulare"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://arxiv.org/abs/1504.02751, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Since the World Health Assembly announced the intention to eradicate polio worldwide in 1988, all countries except Pakistan, Afghanistan, and Nigeria have certified elimination of all three wild poliovirus (WPV) serotypes at least once [1]. Nigeria may be the next country to achieve wild-type polio elimination. The most recent case of wild-type 1 (WPV1) in Nigeria occurred in July 2014 [2]. The most recent case of wild-type 3 (WPV3) seen globally occurred in Nigeria in November 2012 [1]. Is Nigeria wild-polio-free? Is WPV3 eradicated globally? Furthermore, the last case of WPV1 in Africa occurred in Somalia at the tail end of the Horn of Africa Outbreak in August 2014. Is Africa wild-polio-free? \n\nThe primary mechanism for detecting poliovirus in a population is surveillance for paralytic poliomyelitis. The incidence of poliomyelitis is tracked by the acute flaccid paralysis (AFP) surveillance and global polio laboratory network [3,4]. The certification period to declare that a polio serotype has been eliminated from a previously endemic region with certification-standard surveillance is three or more years without a polio case [5]. This criterion is based on experience with regional elimination [6] and is necessarily long because paralysis due to polio is uncommon. Estimated case-to-infection ratios are 1:200 for wild type 1, 1:1900 for wild type 2, and 1:1150 for wild type 3 [7]. \n\nPrevious modeling work has supported that the three year rule of thumb is reasonable, but that more precise estimates of the elimination time depend on the case-to-infection ratio for each serotype and the local conditions leading up to elimination [8,9]. \n\nPolio elimination in the most challenging settings has been driven by supplemental immunization activities that require extensive resources and prolonged community engagement to be successful [2,10,11]. Operational capacity and community engagement can be difficult to maintain for years in the presence of political instability, humanitarian crises, and substantial health care needs unrelated to polio [2,12].",
        "snippetKind": "body",
        "section": "Introduction",
        "snippetOffset": {
          "start": 15,
          "end": 2091
        },
        "annotations": {
          "refMentions": [
            {
              "start": 236,
              "end": 239,
              "matchedPaperCorpusId": "3735453"
            },
            {
              "start": 389,
              "end": 392,
              "matchedPaperCorpusId": null
            },
            {
              "start": 488,
              "end": 491,
              "matchedPaperCorpusId": "3735453"
            },
            {
              "start": 943,
              "end": 946,
              "matchedPaperCorpusId": null
            },
            {
              "start": 946,
              "end": 948,
              "matchedPaperCorpusId": null
            },
            {
              "start": 1146,
              "end": 1149,
              "matchedPaperCorpusId": "19426413"
            },
            {
              "start": 1215,
              "end": 1218,
              "matchedPaperCorpusId": "6877527"
            },
            {
              "start": 1400,
              "end": 1403,
              "matchedPaperCorpusId": null
            },
            {
              "start": 1656,
              "end": 1659,
              "matchedPaperCorpusId": null
            },
            {
              "start": 1659,
              "end": 1661,
              "matchedPaperCorpusId": "41406511"
            },
            {
              "start": 1857,
              "end": 1860,
              "matchedPaperCorpusId": null
            },
            {
              "start": 1860,
              "end": 1863,
              "matchedPaperCorpusId": null
            },
            {
              "start": 1863,
              "end": 1866,
              "matchedPaperCorpusId": "263412301"
            }
          ],
          "sentences": [
            {
              "start": 0,
              "end": 240
            },
            {
              "start": 241,
              "end": 312
            },
            {
              "start": 313,
              "end": 393
            },
            {
              "start": 394,
              "end": 492
            },
            {
              "start": 493,
              "end": 520
            },
            {
              "start": 521,
              "end": 549
            },
            {
              "start": 550,
              "end": 677
            },
            {
              "start": 678,
              "end": 704
            },
            {
              "start": 707,
              "end": 814
            },
            {
              "start": 815,
              "end": 949
            },
            {
              "start": 950,
              "end": 1150
            },
            {
              "start": 1151,
              "end": 1286
            },
            {
              "start": 1287,
              "end": 1404
            },
            {
              "start": 1407,
              "end": 1662
            },
            {
              "start": 1665,
              "end": 1867
            },
            {
              "start": 1868,
              "end": 2076
            }
          ]
        }
      }
    }
  ],
  "retrievalVersion": "pa1-v1"
}
```
