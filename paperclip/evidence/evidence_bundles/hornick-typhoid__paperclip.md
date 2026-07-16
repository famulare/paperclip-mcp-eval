# Evidence Bundle: hornick-typhoid | Arm: Paperclip MCP

**Target identifier(s) requested:** PMID 4916913 | N Engl J Med 1970
**Case notes:** Pre-1980 NEJM + OCR stress case.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

### hornick-typhoid__lookup_pmid.txt

```
# command: lookup pmid 4916913
# captured: 2026-05-22T00:19:20.1954494-07:00

No documents found.

```

### hornick-typhoid__ls.txt

```
# command: ls /papers/med_1d85b4706e45/
# captured: 2026-05-22T00:19:21.6151458-07:00

meta.json  content.lines  (240 lines)  sections/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### hornick-typhoid__map_n_probe.txt

```
# command: map --from s_f5c17030 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:19:25.5685148-07:00

Map complete: 5/5 tasks succeeded in 1700ms
Results ID: m_dbea57d7
Full results: /.gxl/map_m_dbea57d7.txt

  [success] Risk factors for typhoid fever: A desk review  (med_1d85b4706e45)
    The central claim of this paper is that typhoid fever transmission is driven by a multifaceted set of risk factors—specifically socio-economic/housing
  [success] Why Is Eradicating Typhoid Fever So Challenging: Implications for Vacc  (PMC6160957)
    The central claim of this paper is that eradicating typhoid fever is exceptionally challenging due to the emergence of multidrug-resistant (MDR) and e
  [success] Mathematical Analysis of the role of Information on the Dynamics of Ty  (arx_2310.09825)
    The provided text does not contain the content of the paper, only its title. Therefore, I cannot identify the central mechanistic or empirical claim.
  [success] Complex Adaptive Immunity to Enteric Fevers in Humans: Lessons Learned  (PMC4209864)
    The paper claims that while both humoral and cell-mediated immunity (CMI) are elicited by *S.* Typhi infection and vaccination, CMI—specifically invol
  [success] Eosinopenia in Patients With Typhoid Fever: A Case-Control Study  (PMC7549842)
    The central claim of this paper is that eosinopenia, when present in patients with clinical features or serology suggestive of typhoid fever, is a str

Full results: /.gxl/map_m_dbea57d7.txt

```

### hornick-typhoid__search_title.txt

```
# command: search -t --all "Typhoid fever pathogenesis and immunologic control" -n 5
# captured: 2026-05-22T00:19:21.0605455-07:00

Found 5 papers  [s_d18cfb8b]

  1. Risk factors for typhoid fever: A desk review
     Portia Boakye Okyere *, Sampson Twumasi-Ankrah, Sam Newton, Samuel Nkansah Darko, Michael Owusu Ansa...
     med_1d85b4706e45 · medRxiv · 2024-09-10
     https://doi.org/10.1101/2024.09.10.24313440
     "This desk review synthesized evidence on typhoid fever risk factors from 1928-2023. Socio-economic, housing, foodborne, and WASH-related factors were the most frequently identified contributors to transmission."

  2. Why Is Eradicating Typhoid Fever So Challenging: Implications for Vaccine and Therapeutic Design
     Yi-An Yang, Alexander Chong, Jeongmin Song
     PMC6160957 · biomedrxiv · 2018-07-24
     https://doi.org/10.3390/vaccines6030045
     "This paper reviews challenges in eradicating typhoid fever, particularly due to drug-resistant strains and chronic carriers. Incomplete understanding of *S. Typhi* pathogenesis hinders vaccine and therapy development, necessitating new approaches for acute and chronic infections."

  3. Mathematical Analysis of the role of Information on the Dynamics of Typhoid Fever
     Nyanga Honda Masasila, Rigobert Charles Ngeleja and Odeli John Kigodi
     arx_2310.09825 · arXiv · 2023-10-15
     https://doi.org/10.4236/oalib.1110109
     "This study modeled how information impacts Typhoid Fever spread using mathematical analysis. Increased information can worsen transmission by affecting behavior and poor adherence to precautions."

  4. Complex Adaptive Immunity to Enteric Fevers in Humans: Lessons Learned and the Path Forward
     Marcelo B. Sztein, Rosangela Salerno-Goncalves, Monica A. McArthur
     PMC4209864 · PMC · 2014-09-12
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4209864/
     "This review assesses human adaptive immune responses to enteric fever pathogens. It concludes that cell-mediated immunity, particularly in the gut, is likely crucial for protection, while the role of antibodies remains unclear."

  5. Eosinopenia in Patients With Typhoid Fever: A Case-Control Study
     Uzma Ishaq, Jahanzeb Malik, Maliha Asif, Hina Zaib, Iqbal Haider, Tayyaba Zahid, Rana Abdul Sattar, ...
     PMC7549842 · PMC · 2020-09-10
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7549842/
     "This case-control study investigated eosinopenia in typhoid fever patients. Eosinopenia was significantly associated with typhoid fever and could help predict positive cultures, suggesting early treatment initiation."

[294ms, saved to s_d18cfb8b]

💡 Extract data across these results with: map --from s_d18cfb8b "your question"

```

### hornick-typhoid__wc.txt

```
# command: wc /papers/med_1d85b4706e45/content.lines
# captured: 2026-05-22T00:19:22.1489349-07:00

240   13132   79607 /papers/med_1d85b4706e45/content.lines

```

