---
case_id: famulare-2018-plosbio
arm: asta
synthesizer: Claude Opus 4.8
---

# Evidence Bundle: famulare-2018-plosbio | Arm: Asta (Ai2 Scientific Corpus MCP)

## Synthesizer rule (Asta arm)

Answer the 8 evaluation prompts (see synthesis_prompts.md) using ONLY the Asta outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If a prompt cannot be answered from this bundle, write "Cannot answer from this arm's evidence" and state what is missing.

Asta arm caveats (properties of the tool, not of the paper): Asta provides metadata + abstract (`get_paper`) and ~500-word `snippet_search` excerpts drawn from title/abstract/body text, **excluding figure captions and the bibliography**. It has **no supplement, table, figure, or trial-registry surface**. An empty snippet result means the paper's full text is not in Asta's snippet index (common for paywalled papers) — treat it as 'no body-text evidence available', not as evidence of absence in the paper.

## Asta retrieval evidence

### `famulare-2018-plosbio__get_paper.txt`

```
# tool: get_paper
# args: {"paper_id": "PMID:29702638"}
# status: OK

{
  "paperId": "ba1c7a08cdb9649c8fbf6b69e7f9081cd4570f37",
  "externalIds": {
    "PubMedCentral": "5942853",
    "MAG": "2951412666",
    "DOI": "10.1371/journal.pbio.2002468",
    "CorpusId": 13712173,
    "PubMed": "29702638"
  },
  "url": "https://www.semanticscholar.org/paper/ba1c7a08cdb9649c8fbf6b69e7f9081cd4570f37",
  "title": "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine",
  "venue": "bioRxiv",
  "year": 2017,
  "isOpenAccess": true,
  "openAccessPdf": {
    "url": "https://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.2002468&type=printable",
    "status": "GOLD",
    "license": "CCBY",
    "disclaimer": "Notice: Paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC5942853, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
  },
  "publicationDate": "2017-03-16",
  "journal": {
    "name": "PLoS Biology",
    "volume": "16"
  },
  "authors": [
    {
      "authorId": "3059487",
      "name": "M. Famulare"
    },
    {
      "authorId": "144379335",
      "name": "C. Selinger"
    },
    {
      "authorId": "38933180",
      "name": "K. McCarthy"
    },
    {
      "authorId": "1979314",
      "name": "P. Eckhoff"
    },
    {
      "authorId": "1387950133",
      "name": "G. Chabot-Couture"
    }
  ],
  "abstract": "The oral polio vaccine (OPV) contains live-attenuated polioviruses that induce immunity by causing low virulence infections in vaccine recipients and their close contacts. Widespread immunization with OPV has reduced the annual global burden of childhood paralysis by a factor of ten thousand or more and has driven wild poliovirus (WPV) to the brink of eradication. However, in instances that have so far been rare, OPV can paralyze vaccine recipients and generate vaccine-derived polio outbreaks. To complete polio eradication, OPV use should eventually cease, but doing so will leave a growing population fully susceptible to infection. If poliovirus is somehow re-introduced after OPV cessation, will it be likely to cause outbreaks? If the virus is from OPV, will the risk of vaccine-derived outbreaks always remain low? To answer these questions, we built a multiscale mathematical model of infection and transmission with data from clinical trials and field epidemiology studies. The within-host model describes the effects of vaccination and waning immunity on shedding and dose response. The transmission model captures how shedding and dose response interact with sanitation and person-to-person contact patterns to determine the force of infection in communities. Our results show that inactivated polio vaccine alone is sufficient to prevent outbreaks in low force of infection settings, and that OPV can be started and stopped safely in moderate force of infection settings. However, in high force of infection settings, the conditions that support vaccine-derived outbreaks have only been rare because population immunity has been high. With insufficient immunity, the Sabin strains from OPV will be nearly as capable of causing outbreaks as WPV. We conclude that while eradication may still be achieved with continued use of Sabin OPV, a new vaccine is needed to secure eradication for all time. Author Summary Oral polio vaccine (OPV) has played an essential role in the elimination of wild poliovirus (WPV). OPV contains transmissible viruses that can spread from person-to-person. When OPV transmission persists uninterrupted, vaccine-derived outbreaks occur. After OPV is no longer used in routine immunization, as with the cessation of type 2 OPV in 2016, population immunity will decline. A key question is how this affects the potential of OPV viruses to spread within and across communities. To address this, we examined the roles of immunity, sanitation, and social contact in limiting OPV transmission. Our results derive from an extensive review and synthesis of vaccine trial data and community epidemiological studies. Shedding, dose response, and transmission data are analyzed to systematically explain and model observations of WPV and OPV circulation. We show that in high force of infection settings, falling population immunity after OPV cessation will lead to conditions where OPV and WPV are similarly capable of causing outbreaks, and that this conclusion is compatible with the known safety of OPV prior to global cessation. Abbreviations WPV wild poliovirus OPV oral polio vaccine tOPV trivalent OPV mOPV monovalent OPV bOPV bivalent type 1 and 3 OPV cVDPV circulating vaccine-derived poliovirus IPV inactivated polio vaccine CID50 the culture infectious dose that induces a cytopathic effect in 50% of infected cell or tissue cultures HID50 the dose (measured in CID50) that infects 50% of orally-exposed and immunologically-naive humans MLE maximum likelihood estimate CI confidence inteval UP Uttar Pradesh"
}
```

### `famulare-2018-plosbio__snippet.txt`

```
# tool: snippet_search
# args: {"query": "stability of polio eradication withdrawal oral polio vaccine transmission", "paper_ids": "PMID:29702638"}
# status: OK

{
  "data": [
    {
      "score": 1.1784509979234288,
      "paper": {
        "corpusId": "13712173",
        "title": "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine",
        "authors": [
          "M. Famulare",
          "C. Selinger",
          "K. McCarthy",
          "P. Eckhoff",
          "G. Chabot-Couture"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC5942853, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine",
        "snippetKind": "title",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 87
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.6796566980946515,
      "paper": {
        "corpusId": "13712173",
        "title": "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine",
        "authors": [
          "M. Famulare",
          "C. Selinger",
          "K. McCarthy",
          "P. Eckhoff",
          "G. Chabot-Couture"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC5942853, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "The oral polio vaccine (OPV) contains live-attenuated polioviruses that induce immunity by causing low virulence infections in vaccine recipients and their close contacts. Widespread immunization with OPV has reduced the annual global burden of childhood paralysis by a factor of ten thousand or more and has driven wild poliovirus (WPV) to the brink of eradication. However, in instances that have so far been rare, OPV can paralyze vaccine recipients and generate vaccine-derived polio outbreaks. To complete polio eradication, OPV use should eventually cease, but doing so will leave a growing population fully susceptible to infection. If poliovirus is somehow re-introduced after OPV cessation, will it be likely to cause outbreaks? If the virus is from OPV, will the risk of vaccine-derived outbreaks always remain low? To answer these questions, we built a multiscale mathematical model of infection and transmission with data from clinical trials and field epidemiology studies. The within-host model describes the effects of vaccination and waning immunity on shedding and dose response. The transmission model captures how shedding and dose response interact with sanitation and person-to-person contact patterns to determine the force of infection in communities. Our results show that inactivated polio vaccine alone is sufficient to prevent outbreaks in low force of infection settings, and that OPV can be started and stopped safely in moderate force of infection settings. However, in high force of infection settings, the conditions that support vaccine-derived outbreaks have only been rare because population immunity has been high. With insufficient immunity, the Sabin strains from OPV will be nearly as capable of causing outbreaks as WPV. We conclude that while eradication may still be achieved with continued use of Sabin OPV, a new vaccine is needed to secure eradication for all time. Author Summary Oral polio vaccine (OPV) has played an essential role in the elimination of wild poliovirus (WPV). OPV contains transmissible viruses that can spread from person-to-person. When OPV transmission persists uninterrupted, vaccine-derived outbreaks occur. After OPV is no longer used in routine immunization, as with the cessation of type 2 OPV",
        "snippetKind": "abstract",
        "section": null,
        "snippetOffset": {
          "start": 0,
          "end": 2266
        },
        "annotations": {
          "refMentions": null,
          "sentences": null
        }
      }
    },
    {
      "score": 0.4620924759579477,
      "paper": {
        "corpusId": "13712173",
        "title": "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine",
        "authors": [
          "M. Famulare",
          "C. Selinger",
          "K. McCarthy",
          "P. Eckhoff",
          "G. Chabot-Couture"
        ],
        "openAccessInfo": {
          "license": "CCBY",
          "status": "GOLD",
          "disclaimer": "Notice: This snippet is extracted from the open access paper or abstract available at https://pmc.ncbi.nlm.nih.gov/articles/PMC5942853, which is subject to the license by the author or copyright owner provided with this content. Please go to the source to verify the license and copyright information for your use."
        }
      },
      "snippet": {
        "text": "WPV). OPV contains transmissible viruses that can spread from person-to-person. When OPV transmission persists uninterrupted, vaccine-derived outbreaks occur. After OPV is no longer used in routine immunization, as with the cessation of type 2 OPV in 2016, population immunity will decline. A key question is how this affects the potential of OPV viruses to spread within and across communities. To address this, we examined the roles of immunity, sanitation, and social contact in limiting OPV transmission. Our results derive from an extensive review and synthesis of vaccine trial data and community epidemiological studies. Shedding, dose response, and transmission data are analyzed to systematically explain and model observations of WPV and OPV circulation. We show that in high force of infection settings, falling population immunity after OPV cessation will lead to conditions where OPV and WPV are similarly capable of causing outbreaks, and that this conclusion is compatible with the known safety of OPV prior to global cessation. Abbreviations WPV wild poliovirus OPV oral polio vaccine tOPV trivalent OPV mOPV monovalent OPV bOPV bivalent type 1 and 3 OPV cVDPV circulating vaccine-derived poliovirus IPV inactivated polio vaccine CID50 the culture infectious dose that induces a cytopathic effect in 50% of infected cell or tissue cultures HID50 the dose (measured in CID50) that infects 50% of orally-exposed and immunologically-naive humans MLE maximum likelihood estimate CI confidence inteval UP Uttar Pradesh",
        "snippetKind": "abstract",
        "section": null,
        "snippetOffset": {
          "start": 2019,
          "end": 3548
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
