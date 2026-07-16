---
case_id: khoury-2021-natmed
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: khoury-2021-natmed | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `khoury-2021-natmed__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:34002089"}
# status: OK

{
  "paperId": "3e8f21648a67dde3ccc394bf55b0164a02b38e55",
  "externalIds": {
    "MAG": "3163785571",
    "DOI": "10.1038/s41591-021-01377-8",
    "CorpusId": 234769053,
    "PubMed": "34002089"
  },
  "url": "https://www.semanticscholar.org/paper/3e8f21648a67dde3ccc394bf55b0164a02b38e55",
  "title": "Neutralizing antibody levels are highly predictive of immune protection from symptomatic SARS-CoV-2 infection",
  "venue": "Nature Medicine",
  "year": 2021,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://www.nature.com/articles/s41591-021-01377-8.pdf",
    "status": "BRONZE",
    "license": null,
    "disclaimer": "Notice: The following paper fields have been elided by the publisher: {'abstract'}. Paper or abstract available at https://api.unpaywall.org/v2/10.1038/s41591-021-01377-8?email=<INSERT_YOUR_EMAIL> or https://doi.org/10.1038/s41591-021-01377-8, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2021-05-17",
  "journal": {
    "name": "Nature Medicine",
    "pages": "1205 - 1211",
    "volume": "27"
  },
  "authors": [
    {
      "authorId": "49116342",
      "name": "D. Khoury"
    },
    {
      "authorId": "5939914",
      "name": "D. Cromer"
    },
    {
      "authorId": "2829406",
      "name": "A. Reynaldi"
    },
    {
      "authorId": "2381660",
      "name": "T. Schlub"
    },
    {
      "authorId": "32015288",
      "name": "A. Wheatley"
    },
    {
      "authorId": "3855171",
      "name": "J. Juno"
    },
    {
      "authorId": "144107264",
      "name": "K. Subbarao"
    },
    {
      "authorId": "38588896",
      "name": "S. Kent"
    },
    {
      "authorId": "4900800",
      "name": "J. Triccas"
    },
    {
      "authorId": "39702481",
      "name": "M. Davenport"
    }
  ],
  "abstract": null
}
```

### `khoury-2021-natmed__snippet.txt`

```
# tool: snippet_search
# args: {"query": "neutralizing antibody levels predictive immune protection SARS-CoV-2", "paper_ids": "PMID:34002089"}
# status: OK

{
  "data": [],
  "retrievalVersion": "pa1-v1"
}
```
