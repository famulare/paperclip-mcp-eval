# Evidence Bundle: heldout-tbe-vaccine | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** PMID 23997980
**Case notes:** Held-out outside-wheelhouse: TBE vaccine.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: heldout-tbe-vaccine

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Tick-borne encephalitis vaccine (Europe schedule)
**Case type:** concept-discovery outside wheelhouse
**Wheelhouse:** no

## PubMed source-of-record

- **PMID:** 23997980
- **PMCID:** PMC3755374
- **DOI:** 10.4172/2157-2526.S1-003
- **Title:** Tick-borne Encephalitis Vaccines.
- **Authors (top 6):** Lehrer AT; Holbrook MR
- **Journal:** Journal of bioterrorism & biodefense
- **Pub date:** 2011

## Abstract (fair-use snippet)

```
1. J Bioterror Biodef. 2011;2011(Suppl 1):3. doi: 10.4172/2157-2526.S1-003.

Tick-borne Encephalitis Vaccines.

Lehrer AT(1), Holbrook MR.

Author information:
(1)PanThera Biopharma, Aiea, HI 96701.

Tick-borne encephalitis (TBE) is a disease that is found from western Europe 
across Asia and into Japan. In recent years the incidence rate has been 
increasing as has the endemic range of the virus. Tick-borne encephalitis is 
caused by three genetically distinct sutypes of viruses within a single TBE 
virus (TBEV) serocomplex. These three subtypes consist of Far-eastern subtype 
TBEV (TBEV-FE), Siberian subtype (TBEV-Sib) and European subtype (TBEV-Eu). Each 
of these subtypes cause clinically distinct diseases with varying degrees of 
severity. Development of the first vaccines for TBEV began in the late 1930s 
shortly after the first isolation of TBEV-FE in Russia. In the 1970s Austria 
began large scale vaccine production and a nationalized vaccine campaign that 
significantly reduced the incidence rate of TBE. Currently there are four 
licensed TBE vaccines, two in Europe and two in Russia. These vaccines are all 
quite similar formalin-inactivated virus vaccines but the each use a different 
virus strain for production. Published studies have shown that European vaccines 
are cross-protective in rodent studies and elicit cross-reactive neutralizing 
antibody responses in human vaccines. European vaccines have been licensed for a 
rapid vaccine schedule that could be used in response to a significant outbreak 
and reasonable neutralizing antibody titers can be achieved after a single dose 
although a second dose provides nearly complete and long-lasting protection. 
This review focuses on the current status of licensed TBE vaccines and provides 
a brief summary of technology currently being developed for new vaccines.
```

## Diagnostic claim anchors (scorer reference)

- Reviews/synthesizes tick-borne encephalitis (TBE) vaccines and vaccination schedules.
- Covers European epidemiology, immunogenicity, and recommended schedules.
- Should not be confused with polio vaccine literature.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### heldout-tbe-vaccine__lookup_pmid.txt

```
# command: lookup pmid 23997980
# captured: 2026-05-22T00:19:55.3488378-07:00

No documents found.

```

### heldout-tbe-vaccine__ls.txt

```
# command: ls /papers/PMC3899155/
# captured: 2026-05-22T00:19:57.4116417-07:00

meta.json  content.lines  (203 lines)  sections/
  (read-only — use /.gxl/ for writable storage)

```

### heldout-tbe-vaccine__map_n_probe.txt

```
# command: map --from s_d002d6ad -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:20:01.5873975-07:00

Map complete: 5/5 tasks succeeded in 1793ms
Results ID: m_35142931
Full results: /.gxl/map_m_35142931.txt

  [success] Development of a Tick-Borne Encephalitis Virus Nanoparticle Vaccine Ut  (bio_41d493ca7185)
    The paper claims that the TBEV envelope (E) dimer, when displayed on the surface of Mi3 nanoparticles using the SpyCatcher-SpyTag system, functions as
  [success] Epidemiology of tick-borne encephalitis (TBE) in Europe and its preven  (PMC3899155)
    The paper claims that vaccination is the most effective measure to prevent Tick-borne encephalitis (TBE) and that current TBE vaccines (FSME-Immun®, E
  [success] Factor Temporal Prognosis of Tick-Borne Encephalitis Foci Functioning   (arx_cs0401018)
    The provided text does not contain the content of the research paper; it only includes the title. Therefore, the central mechanistic or empirical clai
  [success] Immunogenicity against Far Eastern and Siberian subtypes of tick-borne  (PMC5443051)
    The paper claims that currently available Western TBE vaccines, which are based on the European subtype (TBEV-Eu), elicit high levels of cross-subtype
  [success] Cross-neutralisation of viruses of the tick-borne encephalitis complex  (PMC5627269)
    The paper claims that there is significant cross-neutralisation of tick-borne encephalitis (TBE) complex viruses following TBE vaccination and/or infe

Full results: /.gxl/map_m_35142931.txt

```

### heldout-tbe-vaccine__search_title.txt

```
# command: search -t --all "Tick-borne Encephalitis Vaccines" -n 5
# captured: 2026-05-22T00:19:56.4486677-07:00

Found 5 papers  [s_2d8cd128]

  1. Development of a Tick-Borne Encephalitis Virus Nanoparticle Vaccine Utilizing Envelope Dimer
     Bingjie Wang, Haiyan Zhao *
     bio_41d493ca7185 · bioRxiv · 2024-11-13
     https://doi.org/10.1101/2024.11.13.622924
     "A novel nanoparticle vaccine was developed using the TBEV envelope E dimer. This E dimer nanoparticle vaccine elicited a potent humoral immune response, showing promise for TBEV immunization."

  2. Epidemiology of tick-borne encephalitis (TBE) in Europe and its prevention by available vaccines
     Daniela Amicizia, Alexander Domnich, Donatella Panatto, Piero Luigi Lai, Maria Luisa Cristina, Ulder...
     PMC3899155 · biomedrxiv · 2013-05-01
     https://doi.org/10.4161/hv.23802
     "This paper reviews the changing epidemiology of tick-borne encephalitis in Europe and the development of available vaccines. Vaccines demonstrate high efficacy, safety, and cross-protection against different TBE virus strains."

  3. Factor Temporal Prognosis of Tick-Borne Encephalitis Foci Functioning on   the South of Russian Far East
     E.I. Bolotin, G.Sh. Tsitsiashvili, I.V. Golycheva
     arx_cs0401018 · arXiv · 2004-01-22
     "Researchers developed a method to predict tick-borne encephalitis outbreaks in the Russian Far East. This approach achieved high accuracy in forecasting infection rates in specific regions."

  4. Immunogenicity against Far Eastern and Siberian subtypes of tick-borne encephalitis (TBE) virus elicited by the currently available vaccines based on the European subtype: Systematic review and meta-analysis
     Alexander Domnich, Donatella Panatto, Eva Klementievna Arbuzova, Alessio Signori, Ulderico Avio, Rob...
     PMC5443051 · biomedrxiv · 2014-10-01
     https://doi.org/10.4161/hv.29984
     "This study reviewed data on TBE vaccines' cross-subtype immunogenicity. European-subtype vaccines elicit high antibody responses against Far Eastern and Siberian subtypes, suggesting their potential use where diverse subtypes circulate."

  5. Cross-neutralisation of viruses of the tick-borne encephalitis complex following tick-borne encephalitis vaccination and/or infection
     Alexander J. McAuley, Bevan Sawatsky, Thomas Ksiazek, Maricela Torres, Miša Korva, Stanka Lotrič-Fur...
     PMC5627269 · PMC · 2017-03-13
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5627269/
     "This study investigated cross-neutralization of tick-borne encephalitis complex viruses in vaccinated and infected individuals. Tick-borne encephalitis virus vaccination provides broad cross-neutralization, but protection against Powassan virus is minimal."

[312ms, saved to s_2d8cd128]

💡 Extract data across these results with: map --from s_2d8cd128 "your question"

```

### heldout-tbe-vaccine__wc.txt

```
# command: wc /papers/PMC3899155/content.lines
# captured: 2026-05-22T00:19:58.1093861-07:00

203    7895   52247 /papers/PMC3899155/content.lines

```


