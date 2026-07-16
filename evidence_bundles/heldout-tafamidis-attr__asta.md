---
case_id: heldout-tafamidis-attr
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: heldout-tafamidis-attr | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `heldout-tafamidis-attr__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:30145929"}
# status: OK

{
  "paperId": "8e7cd303f4752286575f61363c63d8c6ec2b0249",
  "externalIds": {
    "MAG": "2888036721",
    "DOI": "10.1056/NEJMoa1805689",
    "CorpusId": 205103334,
    "PubMed": "30145929"
  },
  "url": "https://www.semanticscholar.org/paper/8e7cd303f4752286575f61363c63d8c6ec2b0249",
  "title": "Tafamidis Treatment for Patients with Transthyretin Amyloid Cardiomyopathy",
  "venue": "New England Journal of Medicine",
  "year": 2018,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://www.nejm.org/doi/pdf/10.1056/NEJMoa1805689?articleTools=true",
    "status": "BRONZE",
    "license": null,
    "disclaimer": "Notice: Paper or abstract available at https://api.unpaywall.org/v2/10.1056/NEJMoa1805689?email=<INSERT_YOUR_EMAIL> or https://doi.org/10.1056/NEJMoa1805689, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2018-08-27",
  "journal": {
    "name": "The New England Journal of Medicine",
    "pages": "1007–1016",
    "volume": "379"
  },
  "authors": [
    {
      "authorId": "3787925",
      "name": "M. Maurer"
    },
    {
      "authorId": "46648528",
      "name": "J. Schwartz"
    },
    {
      "authorId": "3999090",
      "name": "B. Gundapaneni"
    },
    {
      "authorId": "2143480",
      "name": "P. Elliott"
    },
    {
      "authorId": "3183257",
      "name": "G. Merlini"
    },
    {
      "authorId": "1404482148",
      "name": "M. Waddington‐Cruz"
    },
    {
      "authorId": "3085115",
      "name": "A. Kristen"
    },
    {
      "authorId": "145699060",
      "name": "M. Grogan"
    },
    {
      "authorId": "7661758",
      "name": "R. Witteles"
    },
    {
      "authorId": "13103567",
      "name": "T. Damy"
    },
    {
      "authorId": "12977588",
      "name": "B. Drachman"
    },
    {
      "authorId": "3273875",
      "name": "Sanjiv J. Shah"
    },
    {
      "authorId": "143894033",
      "name": "M. Hanna"
    },
    {
      "authorId": "5619860",
      "name": "D. Judge"
    },
    {
      "authorId": "5834242",
      "name": "A. Barsdorf"
    },
    {
      "authorId": "17319940",
      "name": "P. Huber"
    },
    {
      "authorId": "31958556",
      "name": "T. Patterson"
    },
    {
      "authorId": "2058533886",
      "name": "S. Riley"
    },
    {
      "authorId": "47737001",
      "name": "J. Schumacher"
    },
    {
      "authorId": "49053228",
      "name": "M. Stewart"
    },
    {
      "authorId": "8576798",
      "name": "M. Sultan"
    },
    {
      "authorId": "3892795",
      "name": "C. Rapezzi"
    }
  ],
  "abstract": "Background Transthyretin amyloid cardiomyopathy is caused by the deposition of transthyretin amyloid fibrils in the myocardium. The deposition occurs when wild‐type or variant transthyretin becomes unstable and misfolds. Tafamidis binds to transthyretin, preventing tetramer dissociation and amyloidogenesis. Methods In a multicenter, international, double‐blind, placebo‐controlled, phase 3 trial, we randomly assigned 441 patients with transthyretin amyloid cardiomyopathy in a 2:1:2 ratio to receive 80 mg of tafamidis, 20 mg of tafamidis, or placebo for 30 months. In the primary analysis, we hierarchically assessed all‐cause mortality, followed by frequency of cardiovascular‐related hospitalizations according to the Finkelstein–Schoenfeld method. Key secondary end points were the change from baseline to month 30 for the 6‐minute walk test and the score on the Kansas City Cardiomyopathy Questionnaire–Overall Summary (KCCQ‐OS), in which higher scores indicate better health status. Results In the primary analysis, all‐cause mortality and rates of cardiovascular‐related hospitalizations were lower among the 264 patients who received tafamidis than among the 177 patients who received placebo (P<0.001). Tafamidis was associated with lower all‐cause mortality than placebo (78 of 264 [29.5%] vs. 76 of 177 [42.9%]; hazard ratio, 0.70; 95% confidence interval [CI], 0.51 to 0.96) and a lower rate of cardiovascular‐related hospitalizations, with a relative risk ratio of 0.68 (0.48 per year vs. 0.70 per year; 95% CI, 0.56 to 0.81). At month 30, tafamidis was also associated with a lower rate of decline in distance for the 6‐minute walk test (P<0.001) and a lower rate of decline in KCCQ‐OS score (P<0.001). The incidence and types of adverse events were similar in the two groups. Conclusions In patients with transthyretin amyloid cardiomyopathy, tafamidis was associated with reductions in all‐cause mortality and cardiovascular‐related hospitalizations and reduced the decline in functional capacity and quality of life as compared with placebo. (Funded by Pfizer; ATTR‐ACT ClinicalTrials.gov number, NCT01994889.)"
}
```

### `heldout-tafamidis-attr__snippet.txt`

```
# tool: snippet_search
# args: {"query": "tafamidis transthyretin amyloid cardiomyopathy all-cause mortality", "paper_ids": "PMID:30145929"}
# status: OK

{
  "data": [],
  "retrievalVersion": "pa1-v1"
}
```
