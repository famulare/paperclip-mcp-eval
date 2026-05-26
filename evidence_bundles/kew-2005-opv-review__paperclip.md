# Evidence Bundle: kew-2005-opv-review | Arm: Paperclip MCP

**Target identifier(s) requested:** DOI 10.1146/annurev.micro.58.030603.123625 | PMID 16153180
**Case notes:** Annual Reviews; canonical Paperclip exact-ID miss.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

### kew-2005-opv-review__lookup_doi.txt

```
# command: lookup doi 10.1146/annurev.micro.58.030603.123625
# captured: 2026-05-22T00:18:30.4074957-07:00

No documents found.

```

### kew-2005-opv-review__lookup_pmid.txt

```
# command: lookup pmid 16153180
# captured: 2026-05-22T00:18:31.2421659-07:00

No documents found.

```

### kew-2005-opv-review__ls.txt

```
# command: ls /papers/med_ef5c8f1f6c08/
# captured: 2026-05-22T00:18:33.2736911-07:00

meta.json  content.lines  (270 lines)  sections/  supplements/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### kew-2005-opv-review__map_n_probe.txt

```
# command: map --from s_33cd8f0d -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:18:37.1635554-07:00

Map complete: 5/5 tasks succeeded in 1546ms
Results ID: m_4ac602de
Full results: /.gxl/map_m_4ac602de.txt

  [success] Battle of Polio eradication in the Western Pacific Region in the trans  (med_ef5c8f1f6c08)
    The paper claims that there are significant shortfalls in population immunity against polio within the Western Pacific Region—evidenced by vaccination
  [success] The final stages of the global eradication of poliomyelitis  (PMC3720038)
    The paper argues that the global eradication of wild-type poliovirus is technically and politically feasible, but the "polio endgame" requires a coord
  [success] Leveraging Opinions and Vaccination to Eradicate Networked Epidemics  (arx_2304.12516)
    The paper claims that the eradication of networked epidemics can be achieved by integrating opinion dynamics with vaccination strategies, noting that 
  [success] Polio endgame risks and the possibility of restarting the use of oral   (PMC6168953)
    The paper claims that while globally coordinated oral poliovirus vaccine (OPV) cessation is essential for the polio endgame, restarting OPV remains a 
  [success] Reflections on Modeling Poliovirus Transmission and the Polio Eradicat  (PMC7983882)
    The central claim of this paper is that the Global Polio Eradication Initiative (GPEI) strategy of global oral poliovirus vaccine (OPV) cessation is c

Full results: /.gxl/map_m_4ac602de.txt

```

### kew-2005-opv-review__search_title.txt

```
# command: search -t --all "Vaccine-derived polioviruses and the endgame strategy for global polio eradication" -n 5
# captured: 2026-05-22T00:18:32.5353613-07:00

Found 5 papers  [s_a84256b0]

  1. Battle of Polio eradication in the Western Pacific Region in the transition to COVID-19 endemicity
     Ruobing Mei, Shirley L. L. Kwok, Eric H. Y. Lau, Tiffany H. K. Lo, Joseph T. Wu, Leesa K. Lin *, Kat...
     med_ef5c8f1f6c08 · medRxiv · 2022-11-30
     https://doi.org/10.1101/2022.11.30.22282954
     "This study reviewed polio vaccination in the Western Pacific Region and assessed population immunity. It found potential immunity shortfalls and identified factors contributing to vaccine hesitancy."

  2. The final stages of the global eradication of poliomyelitis
     Nicholas C. Grassly
     PMC3720038 · biomedrxiv · 2013-08-05
     https://doi.org/10.1098/rstb.2012.0140
     "This paper examines the challenges and progress in the global eradication of poliomyelitis. The key finding is that while significant progress has been made, challenges like vaccine-derived polioviruses and surveillance limitations remain."

  3. Leveraging Opinions and Vaccination to Eradicate Networked Epidemics
     Humphrey Leung, Zhuocong Li, Baike She, Philip E. Par\'e
     arx_2304.12516 · arXiv · 2023-04-25
     "This study modeled epidemic spread with opinion dynamics and self-interested vaccination. Influencing opinions can achieve herd immunity, eradicating the disease by stabilizing the system at a healthy state."

  4. Polio endgame risks and the possibility of restarting the use of oral poliovirus vaccine
     Radboud J. Duintjer Tebbens, Kimberly M. Thompson
     PMC6168953 · biomedrxiv · 2018-01-01
     https://doi.org/10.1080/14760584.2018.1506333
     "The study reviewed risks of poliovirus transmission after oral poliovirus vaccine (OPV) cessation and modeled OPV restart scenarios. A high risk of uncontrolled outbreaks necessitates OPV restart if over 5,000 cases occur post-cessation."

  5. Reflections on Modeling Poliovirus Transmission and the Polio Eradication Endgame
     Kimberly M. Thompson, Dominika A. Kalkowska
     PMC7983882 · PMC · 2020-04-27
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7983882/
     "This paper reflects on the role of modeling in polio eradication strategy and policy discussions. It concludes that modeling has had limited influence on decisions and that current strategies for polio eradication appear infeasible."

[433ms, saved to s_a84256b0]

💡 Extract data across these results with: map --from s_a84256b0 "your question"

```

### kew-2005-opv-review__wc.txt

```
# command: wc /papers/med_ef5c8f1f6c08/content.lines
# captured: 2026-05-22T00:18:33.8091933-07:00

270    8802   63027 /papers/med_ef5c8f1f6c08/content.lines

```

