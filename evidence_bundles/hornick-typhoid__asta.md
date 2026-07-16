---
case_id: hornick-typhoid
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: hornick-typhoid | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `hornick-typhoid__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:4916913"}
# status: OK

{
  "paperId": "2fb64614776880f42ec3a1402880d3d31e3b441b",
  "externalIds": {
    "MAG": "2003602243",
    "DOI": "10.1056/NEJM197010012831406",
    "CorpusId": 19324387,
    "PubMed": "4916913"
  },
  "url": "https://www.semanticscholar.org/paper/2fb64614776880f42ec3a1402880d3d31e3b441b",
  "title": "Typhoid fever: pathogenesis and immunologic control.",
  "venue": "New England Journal of Medicine",
  "year": 1970,
  "isOpenAccess": false,
  "openAccessPdf": {
    "url": "",
    "status": "CLOSED",
    "license": null,
    "disclaimer": "Notice: The following paper fields have been elided by the publisher: {'abstract'}. Paper or abstract available at https://api.unpaywall.org/v2/10.1056/NEJM197010012831406?email=<INSERT_YOUR_EMAIL> or https://doi.org/10.1056/NEJM197010012831406, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "1970-09-24",
  "journal": {
    "name": "The New England journal of medicine",
    "pages": "\n          686-91\n        ",
    "volume": "283 13"
  },
  "authors": [
    {
      "authorId": "8564103",
      "name": "R. Hornick"
    },
    {
      "authorId": "13222880",
      "name": "S. E. Greisman"
    },
    {
      "authorId": "5898910",
      "name": "T. Woodward"
    },
    {
      "authorId": "145741440",
      "name": "H. Dupont"
    },
    {
      "authorId": "145439775",
      "name": "A. T. Dawkins"
    },
    {
      "authorId": "4103252",
      "name": "M. J. Snyder"
    }
  ],
  "abstract": null
}
```

### `hornick-typhoid__snippet.txt`

```
# tool: snippet_search
# args: {"query": "typhoid fever pathogenesis immunologic control challenge dose", "paper_ids": "PMID:4916913"}
# status: OK

{
  "data": [],
  "retrievalVersion": "pa1-v1"
}
```
