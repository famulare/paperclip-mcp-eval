# Evidence Bundle: famulare-2018-plosbio | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** DOI 10.1371/journal.pbio.2002468 | PMID 29702638 | PMCID PMC5942853 | bioRxiv 10.1101/084012
**Case notes:** Supplement-heavy; preprint-final lineage; canonical Paperclip-DOI-miss case.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: famulare-2018-plosbio

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Famulare 2018 PLOS Biology plus bioRxiv lineage
**Case type:** supplement-heavy/versioned
**Wheelhouse:** yes

## PubMed source-of-record

- **PMID:** 29702638
- **PMCID:** PMC5942853
- **DOI:** 10.1371/journal.pbio.2002468
- **Title:** Assessing the stability of polio eradication after the withdrawal of oral polio vaccine.
- **Authors (top 6):** Famulare M; Selinger C; McCarthy KA; Eckhoff PA; Chabot-Couture G
- **Journal:** PLoS biology
- **Pub date:** 2018 Apr
- **Also:** preprint = bioRxiv 10.1101/084012 (2016)

## Abstract (fair-use snippet)

```
1. PLoS Biol. 2018 Apr 27;16(4):e2002468. doi: 10.1371/journal.pbio.2002468. 
eCollection 2018 Apr.

Assessing the stability of polio eradication after the withdrawal of oral polio 
vaccine.

Famulare M(1), Selinger C(1), McCarthy KA(1), Eckhoff PA(1), Chabot-Couture 
G(1).

Author information:
(1)Institute for Disease Modeling, Bellevue, Washington, United States of 
America.

The oral polio vaccine (OPV) contains live-attenuated polioviruses that induce 
immunity by causing low virulence infections in vaccine recipients and their 
close contacts. Widespread immunization with OPV has reduced the annual global 
burden of paralytic poliomyelitis by a factor of 10,000 or more and has driven 
wild poliovirus (WPV) to the brink of eradication. However, in instances that 
have so far been rare, OPV can paralyze vaccine recipients and generate 
vaccine-derived polio outbreaks. To complete polio eradication, OPV use should 
eventually cease, but doing so will leave a growing population fully susceptible 
to infection. If poliovirus is reintroduced after OPV cessation, under what 
conditions will OPV vaccination be required to interrupt transmission? Can 
conditions exist in which OPV and WPV reintroduction present similar risks of 
transmission? To answer these questions, we built a multi-scale mathematical 
model of infection and transmission calibrated to data from clinical trials and 
field epidemiology studies. At the within-host level, the model describes the 
effects of vaccination and waning immunity on shedding and oral susceptibility 
to infection. At the between-host level, the model emulates the interaction of 
shedding and oral susceptibility with sanitation and person-to-person contact 
patterns to determine the transmission rate in communities. Our results show 
that inactivated polio vaccine (IPV) is sufficient to prevent outbreaks in low 
transmission rate settings and that OPV can be reintroduced and withdrawn as 
needed in moderate transmission rate settings. However, in high transmission 
rate settings, the conditions that support vaccine-derived outbreaks have only 
been rare because population immunity has been high. Absent population immunity, 
the Sabin strains from OPV will be nearly as capable of causing outbreaks as 
WPV. If post-cessation outbreak responses are followed by new vaccine-derived 
outbreaks, strategies to restore population immunity will be required to ensure 
the stability of polio eradication.
```

## Diagnostic claim anchors (scorer reference)

- Mathematical model assessing risk of poliovirus reintroduction after OPV withdrawal.
- Setting-dependent stability of polio eradication: depends on immunity, transmission, and surveillance/response.
- Uses Sabin-strain reversion dynamics and transmission modeling.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

### famulare-2018-plosbio__grep_supplement.txt

```
# command: grep -n -i -m 5 "supplement|appendix" /papers/PMC5942853/content.lines
# captured: 2026-05-22T00:18:15.3787769-07:00

(no matches found)

```

### famulare-2018-plosbio__lookup_doi.txt

```
# command: lookup doi 10.1371/journal.pbio.2002468
# captured: 2026-05-22T00:18:10.4409299-07:00

No documents found.

```

### famulare-2018-plosbio__lookup_pmid.txt

```
# command: lookup pmid 29702638
# captured: 2026-05-22T00:18:11.2973888-07:00

Found 1 papers

  1. Assessing the stability of polio eradication after the withdrawal of oral polio vaccine
     Michael Famulare, Christian Selinger, Kevin A. McCarthy, Philip A. Eckhoff, Guillaume Chabot-Couture
     PMC5942853 · PLoS Biology · 2018
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942853/


```

### famulare-2018-plosbio__ls_supplements.txt

```
# command: ls /papers/PMC5942853/supplements/
# captured: 2026-05-22T00:18:14.5254909-07:00

pbio.2002468.s001.pdf  pbio.2002468.s002.zip
  (read-only — use /.gxl/ for writable storage)

```

### famulare-2018-plosbio__ls.txt

```
# command: ls /papers/PMC5942853/
# captured: 2026-05-22T00:18:12.9253851-07:00

meta.json  content.lines  (252 lines)  sections/  supplements/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### famulare-2018-plosbio__map_n_probe.txt

```
# command: map --from s_c224dc93 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:18:20.2906038-07:00

Map complete: 5/5 tasks succeeded in 3176ms
Results ID: m_1b08a7c9
Full results: /.gxl/map_m_1b08a7c9.txt

  [success] Assessing the stability of polio eradication after the withdrawal of o  (PMC5942853)
    The central claim of this paper is that the long-term stability of polio eradication post-OPV cessation depends on the local transmission rate of a co
  [success] Battle of Polio eradication in the Western Pacific Region in the trans  (med_ef5c8f1f6c08)
    The paper claims that there are potential shortfalls in population immunity against polio within the Western Pacific Region, identifying that current 
  [success] Leveraging Opinions and Vaccination to Eradicate Networked Epidemics  (arx_2304.12516)
    The paper claims that by integrating opinion dynamics with epidemic spreading, "the eradication of an epidemic is possible even if the vaccination rat
  [success] Planning for globally coordinated cessation of bivalent oral polioviru  (PMC5892013)
    The paper claims that the risks associated with the globally coordinated cessation of bivalent oral poliovirus vaccine (bOPV) are generally similar to
  [success] Preventing Vaccine-Derived Poliovirus Emergence during the Polio Endga  (PMC4934862)
    The paper claims that in settings with low routine immunization coverage, the implementation of a limited number of supplementary immunization activit

Full results: /.gxl/map_m_1b08a7c9.txt

```

### famulare-2018-plosbio__search_title.txt

```
# command: search -t --all "Assessing the stability of polio eradication after the withdrawal of oral polio vaccine" -n 5
# captured: 2026-05-22T00:18:12.1972553-07:00

Found 5 papers  [s_acdaee15]

  1. Assessing the stability of polio eradication after the withdrawal of oral polio vaccine
     Michael Famulare, Christian Selinger, Kevin A. McCarthy, Philip A. Eckhoff, Guillaume Chabot-Couture
     PMC5942853 · PMC · 2018-04-27
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5942853/
     "A mathematical model assessed polio transmission risks after oral polio vaccine (OPV) withdrawal. In high-transmission settings without population immunity, OPV-derived poliovirus poses risks similar to wild poliovirus."

  2. Battle of Polio eradication in the Western Pacific Region in the transition to COVID-19 endemicity
     Ruobing Mei, Shirley L. L. Kwok, Eric H. Y. Lau, Tiffany H. K. Lo, Joseph T. Wu, Leesa K. Lin *, Kat...
     med_ef5c8f1f6c08 · medRxiv · 2022-11-30
     https://doi.org/10.1101/2022.11.30.22282954
     "This study reviewed polio vaccination in the Western Pacific Region and assessed population immunity. It found potential immunity shortfalls and identified factors contributing to vaccine hesitancy."

  3. Leveraging Opinions and Vaccination to Eradicate Networked Epidemics
     Humphrey Leung, Zhuocong Li, Baike She, Philip E. Par\'e
     arx_2304.12516 · arXiv · 2023-04-25
     "This study modeled epidemic spread with opinion dynamics and self-interested vaccination. Influencing opinions can achieve herd immunity, eradicating the disease by stabilizing the system at a healthy state."

  4. Planning for globally coordinated cessation of bivalent oral poliovirus vaccine: risks of non-synchronous cessation and unauthorized oral poliovirus vaccine use
     Radboud J. Duintjer Tebbens, Lee M. Hampton, Kimberly M. Thompson
     PMC5892013 · biomedrxiv · 2018-04-10
     https://doi.org/10.1186/s12879-018-3074-0
     "This paper analyzes risks of non-synchronized bivalent oral polio vaccine (bOPV) cessation and unauthorized use. Risks for serotype 3 are lower than serotype 2, but serotype 1 risks are similar, necessitating synchronized cessation and verification."

  5. Preventing Vaccine-Derived Poliovirus Emergence during the Polio Endgame
     Margarita Pons-Salort, Cara C. Burns, Hil Lyons, Isobel M. Blake, Hamid Jafari, M. Steven Oberste, O...
     PMC4934862 · PMC · 2016-07-06
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4934862/
     "This study modeled VDPV2 emergence and analyzed Nigerian data to assess risks of oral polio vaccine withdrawal. Higher routine immunization coverage significantly reduces VDPV2 emergence risk."

[379ms, saved to s_acdaee15]

💡 Extract data across these results with: map --from s_acdaee15 "your question"

```

### famulare-2018-plosbio__wc.txt

```
# command: wc /papers/PMC5942853/content.lines
# captured: 2026-05-22T00:18:13.8447093-07:00

252  317634 1081313 /papers/PMC5942853/content.lines

```


## Section 3 — Local PDF slices

### Slot: famulare-2018-plosbio__main

# Local PDF Slice: famulare-2018-plosbio__main

**File:** Famulare_Bellevue_2017_Assessing_the_stability_of_polio_eradication_after_the_withdrawal_of_oral_polio.pdf
**Pages:** 71
**Chars:** 326834
**Lines:** 6801

## Head slice (first 2500 chars)

```
bioRxiv preprint first posted online Oct. 27, 2016; doi: http://dx.doi.org/10.1101/084012. The copyright holder for this preprint (which was not
                     peer-reviewed) is the author/funder. It is made available under a CC-BY-ND 4.0 International license.




         Assessing the stability of polio eradication after the withdrawal of oral
         polio vaccine

         Michael Famulare1, * , Christian Selinger1 , Kevin A. McCarthy1 , Guillaume Chabot-Couture1 , Philip

         A. Eckhoff1


         1 Institute for Disease Modeling, Bellevue WA, USA


          senior author

         *mfamulare@idmod.org



         Abstract

         A fundamental complexity of polio eradication is that the elimination of wild poliovirus (WPV)

         alters the risk-benefit profile of using oral polio vaccine (OPV)—as WPV is eliminated, OPV

         produces an increasing proportion of the paralytic disease burden since, in rare instances, OPV

         causes paralysis in vaccine recipients and generates circulating vaccine-derived polio outbreaks

         (cVDPV) in under-immunized populations. Therefore, to secure the success and long-term stability

         of polio eradication, OPV use should eventually cease. Type 2 OPV (OPV2) was withdrawn from

         routine immunization (RI) in April 2016, but ongoing type 2 cVDPV have necessitated the use of

         OPV2 in outbreak response. Thus the world today: RI with OPV2 has stopped, but OPV2 is

         needed to interrupt outbreaks, and any future use several years hence will take place in a population

         with an unprecedented lack of type 2 immunity. To better understand the complex risk landscape of

         OPV cessation, we summarized data spanning 75 years of polio literature detailing how vaccination

         affects individual susceptibility to infection and viral shedding. We then examined individual

         immunity in the context of close-contact transmission data from the USA and India to quantify the

         impacts of vaccination on transmission. Our results demonstrate that in settings with poor

         sanitation: (1) OPV has been effective in all populations because it blocks transmission locally, (2)

         cross-immunity against type 2 produced by bivalent types 1 and 3 OPV is insufficient to block




                                                                                                
```

## Tail slice (last 700 chars)

```
phase 4, non-inferiority study. The Lancet

            Infectious Diseases. 2015;3099(15). doi:10.1016/S1473-3099(15)00219-4.

       21. Asturias EJ, Bandyopadhyay AS, Self S, Rivera L, Saez-llorens X, Lopez E, et al. Humoral and

            intestinal immunity induced by new schedules of bivalent oral poliovirus vaccine and one or two doses

            of inactivated poliovirus vaccine in Latin American infants: an open-label randomised controlled trial.

            Lancet. 2016;6736(16):1–12. doi:10.1016/S0140-6736(16)00703-0.




                                                                                                                                     16/16

```


### Slot: famulare-2018-plosbio__s1

# Local PDF Slice: famulare-2018-plosbio__s1

**File:** Unknown_1960_S1_Text_Assessing_the_stability_of_polio_eradication_after_the_withdrawal_of.pdf
**Pages:** 17
**Chars:** 53223
**Lines:** 995

## Head slice (first 2500 chars)

```
S1 Text: Assessing the stability of polio eradication after the withdrawal of
oral polio vaccine

Michael Famulare1* , Christian Selinger1 , Kevin A. McCarthy1 , Philip A. Eckhoff1 , Guillaume

Chabot-Couture1

1 Institute for Disease Modeling, Bellevue WA, USA. * mfamulare@idmod.org



Contents

Part A     Parameter table                                                                                         1


Part B     Within-host model                                                                                      3

   Part B.1   Sources of data on shedding and oral susceptibility to infection . . . . . . . . . . . . . .        3

   Part B.2   Shedding duration after OPV challenge or WPV infection . . . . . . . . . . . . . . . . .            5

   Part B.3   Concentration of poliovirus in stool . . . . . . . . . . . . . . . . . . . . . . . . . . . . .      6

   Part B.4   Oral susceptibility to infection from OPV challenge . . . . . . . . . . . . . . . . . . . .          6

   Part B.5   Waning immunity against infection . . . . . . . . . . . . . . . . . . . . . . . . . . . . .          7


Part C     Transmission model                                                                                     8

   Part C.1   Houston 1960 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .      8

   Part C.2   Louisiana 1953–1955 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .     10

   Part C.3   Uttar Pradesh and Bihar 2003–2008 . . . . . . . . . . . . . . . . . . . . . . . . . . . . .         10

   Part C.4   Model fit . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .   11



Part A        Parameter table

The values of all parameters used in the model, both from calibration and in the Results presentation, are

shown in Table A.




                                                        1
                    Table A. Parameter table.
component                 equation     parameter           value (range)                                           meaning
                                                               1, 211
                                                                      
OPV-equivalent an-           -            NAb                                                          individual correlate of immunity
tibody titer
                                           µS      
```

## Tail slice (last 700 chars)

```
vić AB, Kretzschmar MEE. Linking the

   seroresponse to infection to within-host heterogeneity in antibody production. Epidemics.

   2016;16:33–39. doi:10.1016/j.epidem.2016.04.001.




                                                                                                        16/17
39. Gelfand HM, Leblanc DR, Fox JP, Conwell DP. Studies on the development of natural immunity to

   poliomyelitis in Louisiana. II. Description and Analysis of Episodes of infection observed in study

   group households. American Journal of Hygeine. 1957;65:367–385.




                                                                                                   17/17

```


