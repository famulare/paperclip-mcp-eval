---
case_id: kew-2005-opv-review
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: kew-2005-opv-review | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `kew-2005-opv-review__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:16153180"}
# status: OK

{
  "paperId": "6a19fa11a8cc629259c1d19661682a760bfcc8b2",
  "externalIds": {
    "MAG": "2117691753",
    "DOI": "10.1146/ANNUREV.MICRO.58.030603.123625",
    "CorpusId": 22669747,
    "PubMed": "16153180"
  },
  "url": "https://www.semanticscholar.org/paper/6a19fa11a8cc629259c1d19661682a760bfcc8b2",
  "title": "Vaccine-derived polioviruses and the endgame strategy for global polio eradication.",
  "venue": "Annual Review of Microbiology",
  "year": 2005,
  "isOpenAccess": false,
  "openAccessPdf": {
    "url": "",
    "status": "CLOSED",
    "license": null,
    "disclaimer": "Notice: The following paper fields have been elided by the publisher: {'abstract'}. Paper or abstract available at https://api.unpaywall.org/v2/10.1146/ANNUREV.MICRO.58.030603.123625?email=<INSERT_YOUR_EMAIL> or https://doi.org/10.1146/ANNUREV.MICRO.58.030603.123625, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2005-09-09",
  "journal": {
    "name": "Annual review of microbiology",
    "pages": "\n          587-635\n        ",
    "volume": "59"
  },
  "authors": [
    {
      "authorId": "5164553",
      "name": "O. Kew"
    },
    {
      "authorId": "3596298",
      "name": "R. Sutter"
    },
    {
      "authorId": "6445195",
      "name": "E. D. de Gourville"
    },
    {
      "authorId": "5136442",
      "name": "W. Dowdle"
    },
    {
      "authorId": "1862306",
      "name": "M. Pallansch"
    }
  ],
  "abstract": null
}
```

### `kew-2005-opv-review__snippet.txt`

```
# tool: snippet_search
# args: {"query": "vaccine-derived poliovirus VDPV endgame eradication immunodeficiency", "paper_ids": "PMID:16153180"}
# status: OK

{
  "data": [],
  "retrievalVersion": "pa1-v1"
}
```
