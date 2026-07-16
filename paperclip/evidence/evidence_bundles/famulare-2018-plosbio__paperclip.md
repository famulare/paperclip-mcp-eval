# Evidence Bundle: famulare-2018-plosbio | Arm: Paperclip MCP

**Target identifier(s) requested:** DOI 10.1371/journal.pbio.2002468 | PMID 29702638 | PMCID PMC5942853 | bioRxiv 10.1101/084012
**Case notes:** Supplement-heavy; preprint-final lineage; canonical Paperclip-DOI-miss case.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

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

