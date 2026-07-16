---
case_id: sfs-nejm-2020
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: sfs-nejm-2020 | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `sfs-nejm-2020__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:32356944"}
# status: OK

{
  "paperId": "f7cf09d88f0278910c3b4aec8f62c867edc7ede0",
  "externalIds": {
    "PubMedCentral": "7206929",
    "MAG": "3023059761",
    "DOI": "10.1056/NEJMc2008646",
    "CorpusId": 218469866,
    "PubMed": "32356944"
  },
  "url": "https://www.semanticscholar.org/paper/f7cf09d88f0278910c3b4aec8f62c867edc7ede0",
  "title": "Early Detection of Covid-19 through a Citywide Pandemic Surveillance Platform",
  "venue": "New England Journal of Medicine",
  "year": 2020,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://europepmc.org/articles/pmc7206929?pdf=render",
    "status": "GREEN",
    "license": "unspecified-oa",
    "disclaimer": "Notice: Paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7206929, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2020-05-01",
  "journal": {
    "name": "The New England Journal of Medicine"
  },
  "authors": [
    {
      "authorId": "40003336",
      "name": "H. Chu"
    },
    {
      "authorId": "5247744",
      "name": "J. Englund"
    },
    {
      "authorId": "4384274",
      "name": "L. Starita"
    },
    {
      "authorId": "3059487",
      "name": "M. Famulare"
    },
    {
      "authorId": "84071261",
      "name": "E. Brandstetter"
    },
    {
      "authorId": "2800599",
      "name": "D. Nickerson"
    },
    {
      "authorId": "11192458",
      "name": "M. Rieder"
    },
    {
      "authorId": "6734937",
      "name": "A. Adler"
    },
    {
      "authorId": "14423239",
      "name": "K. Lacombe"
    },
    {
      "authorId": "1388667733",
      "name": "Ashley E. Kim"
    },
    {
      "authorId": "143934079",
      "name": "Chelsey Graham"
    },
    {
      "authorId": "1390007370",
      "name": "J. Logue"
    },
    {
      "authorId": "1388673840",
      "name": "C. Wolf"
    },
    {
      "authorId": "1624659715",
      "name": "Jessica Heimonen"
    },
    {
      "authorId": "1403972892",
      "name": "Denise J. McCulloch"
    },
    {
      "authorId": "1664888442",
      "name": "P. Han"
    },
    {
      "authorId": "50620813",
      "name": "T. Sibley"
    },
    {
      "authorId": "1625586781",
      "name": "Jover Lee"
    },
    {
      "authorId": "9564920",
      "name": "M. Ilcisin"
    },
    {
      "authorId": "39163396",
      "name": "K. Fay"
    },
    {
      "authorId": "50748351",
      "name": "R. Burstein"
    },
    {
      "authorId": "40371198",
      "name": "Beth K. Martin"
    },
    {
      "authorId": "145353158",
      "name": "C. Lockwood"
    },
    {
      "authorId": "152379201",
      "name": "Matthew J. Thompson"
    },
    {
      "authorId": "48731331",
      "name": "B. Lutz"
    },
    {
      "authorId": "33310509",
      "name": "M. Jackson"
    },
    {
      "authorId": "2247530494",
      "name": "J. Hughes"
    },
    {
      "authorId": "6054238",
      "name": "M. Boeckh"
    },
    {
      "authorId": "2431330",
      "name": "J. Shendure"
    },
    {
      "authorId": "28950924",
      "name": "T. Bedford"
    }
  ],
  "abstract": "Detection of Covid-19 through a Citywide Surveillance Platform The Seattle Flu study, initiated in 2018, mailed kits for home collection of midnasal swabs to people reporting respiratory symptoms. ..."
}
```

### `sfs-nejm-2020__snippet.txt`

```
# tool: snippet_search
# args: {"query": "citywide pandemic surveillance early detection Covid-19 Seattle self-swab", "paper_ids": "PMID:32356944"}
# status: OK

{
  "data": [
    {
      "score": 0.807836172457821,
      "paper": {
        "corpusId": "218469866",
        "title": "Early Detection of Covid-19 through a Citywide Pandemic Surveillance Platform",
        "authors": [
          "H. Chu",
          "J. Englund",
          "L. Starita",
          "M. Famulare",
          "E. Brandstetter",
          "D. Nickerson",
          "M. Rieder",
          "A. Adler",
          "K. Lacombe",
          "Ashley E. Kim",
          "Chelsey Graham",
          "J. Logue",
          "C. Wolf",
          "Jessica Heimonen",
          "Denise J. McCulloch",
          "P. Han",
          "T. Sibley",
          "Jover Lee",
          "M. Ilcisin",
          "K. Fay",
          "R. Burstein",
          "Beth K. Martin",
          "C. Lockwood",
          "Matthew J. Thompson",
          "B. Lutz",
          "M. Jackson",
          "J. Hughes",
          "M. Boeckh",
          "J. Shendure",
          "T. Bedford"
        ],
        "openAccessInfo": {
          "license": "unspecified-oa",
          "status": "GREEN",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7206929, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Detection of Covid-19 through a Citywide Surveillance Platform The Seattle Flu study, initiated in 2018, mailed kits for home collection of midnasal swabs to people reporting respiratory symptoms. ...",
        "snippetKind": "abstract",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 200
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.6186864950319191,
      "paper": {
        "corpusId": "218469866",
        "title": "Early Detection of Covid-19 through a Citywide Pandemic Surveillance Platform",
        "authors": [
          "H. Chu",
          "J. Englund",
          "L. Starita",
          "M. Famulare",
          "E. Brandstetter",
          "D. Nickerson",
          "M. Rieder",
          "A. Adler",
          "K. Lacombe",
          "Ashley E. Kim",
          "Chelsey Graham",
          "J. Logue",
          "C. Wolf",
          "Jessica Heimonen",
          "Denise J. McCulloch",
          "P. Han",
          "T. Sibley",
          "Jover Lee",
          "M. Ilcisin",
          "K. Fay",
          "R. Burstein",
          "Beth K. Martin",
          "C. Lockwood",
          "Matthew J. Thompson",
          "B. Lutz",
          "M. Jackson",
          "J. Hughes",
          "M. Boeckh",
          "J. Shendure",
          "T. Bedford"
        ],
        "openAccessInfo": {
          "license": "unspecified-oa",
          "status": "GREEN",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC7206929, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Early Detection of Covid-19 through a Citywide Pandemic Surveillance Platform",
        "snippetKind": "title",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 77
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
