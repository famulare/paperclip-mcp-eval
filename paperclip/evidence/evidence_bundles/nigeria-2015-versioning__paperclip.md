# Evidence Bundle: nigeria-2015-versioning | Arm: Paperclip MCP

**Target identifier(s) requested:** arXiv 1504.02751 | PMID 26317401 | DOI 10.1371/journal.pone.0135765
**Case notes:** Canonical version-lineage case.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

### nigeria-2015-versioning__lookup_arxiv_1504_02751.txt

```
# command: lookup arxiv 1504.02751
# captured: 2026-05-22T00:19:33.1214730-07:00

Found 1 papers

  1. Has wild poliovirus been eliminated from Nigeria?
     Michael Famulare
     1504.02751 · arXiv · 2015-04-10
     https://doi.org/10.1371/journal.pone.0135765


```

### nigeria-2015-versioning__lookup_doi.txt

```
# command: lookup doi 10.1371/journal.pone.0135765
# captured: 2026-05-22T00:19:32.0344872-07:00

Found 1 papers

  1. Has wild poliovirus been eliminated from Nigeria?
     Michael Famulare
     1504.02751 · arXiv · 2015-04-10
     https://doi.org/10.1371/journal.pone.0135765


```

### nigeria-2015-versioning__lookup_pmid.txt

```
# command: lookup pmid 26317401
# captured: 2026-05-22T00:19:32.5650516-07:00

Found 1 papers

  1. Has Wild Poliovirus Been Eliminated from Nigeria?
     Michael Famulare
     PMC4552877 · PLoS ONE · 2015
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4552877/


```

### nigeria-2015-versioning__ls.txt

```
# command: ls /papers/PMC4552877/
# captured: 2026-05-22T00:19:35.3927425-07:00

meta.json  content.lines  (116 lines)  sections/  supplements/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### nigeria-2015-versioning__map_n_probe.txt

```
# command: map --from s_0ee69dd3 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:19:40.1649933-07:00

Map complete: 4/4 tasks succeeded in 1509ms
Results ID: m_f8fe6d27
Full results: /.gxl/map_m_f8fe6d27.txt

  [success] Has wild poliovirus been eliminated from Nigeria?  (arx_1504.02751)
    The provided text does not contain a research paper or any content addressing the elimination of wild poliovirus in Nigeria. Therefore, I cannot ident
  [success] Sub-national estimation of surveillance sensitivity to inform declarat  (med_a0b332816c2a)
    The paper claims that a statistical framework—specifically a multi-stage, multi-component "scenario tree" approach—can be used to quantify the time-va
  [success] Eradication of wild poliovirus in Nigeria: Lessons learnt  (PMC9461633)
    The central claim of this paper is that Nigeria’s successful eradication of wild poliovirus was achieved through a multi-faceted strategy—specifically
  [success] Poliovirus-nonsusceptible Vero cell line for the World Health Organiza  (bio_7f8114f26da7)
    The paper claims that the newly generated **Vero $\Delta$PVR1/2 double-knockout (DKO) cell line** is resistant to poliovirus (PV) infection because it

Full results: /.gxl/map_m_f8fe6d27.txt

```

### nigeria-2015-versioning__search_title.txt

```
# command: search -t --all "Has wild poliovirus been eliminated from Nigeria?" -n 5
# captured: 2026-05-22T00:19:34.4425971-07:00

Found 4 papers  [s_536e96a7]

  1. Has wild poliovirus been eliminated from Nigeria?
     Michael Famulare
     arx_1504.02751 · arXiv · 2015-04-10
     https://doi.org/10.1371/journal.pone.0135765
     "This study modeled poliovirus transmission in Nigeria to estimate elimination probabilities. Wild poliovirus type 1 and 3 are likely eliminated, but circulating vaccine-derived type 2 poliovirus transmission continues."

  2. Sub-national estimation of surveillance sensitivity to inform declaration of disease elimination: A retrospective validation against the elimination of wild poliovirus in Nigeria
     Emily S Nightingale *, Ly Pham-Minh, Isah Mohammed Bello, Samuel Okrior, Tesfaye Bedada Erbeto, Mary...
     med_a0b332816c2a · medRxiv · 2025-01-30
     https://doi.org/10.1101/2025.01.30.25321401
     "A statistical framework estimated the sensitivity of polio surveillance in Nigeria. This framework's validation showed it can prospectively inform disease elimination declarations."

  3. Eradication of wild poliovirus in Nigeria: Lessons learnt
     Osmond C. Ekwebelem, Obinna V. Nnorom-Dike, Abdullahi Tunde Aborode, Nicholas C. Ekwebelem, Job C. A...
     PMC9461633 · biomedrxiv · 2021-05-15
     https://doi.org/10.1016/j.puhip.2021.100144
     "Nigeria's polio eradication initiative successfully eliminated wild poliovirus through effective partnerships and community mobilization. This achievement highlights the importance of sustained prioritization and global support for global polio eradication."

  4. Poliovirus-nonsusceptible Vero cell line for the World Health Organization global action plan
     Yuko Okemoto-Nakamura, Kenji Someya, Toshiyuki Yamaji, Kyoko Saito, Makoto Takeda, Kentaro Hanada *
     bio_7f8114f26da7 · bioRxiv · 2020-08-19
     https://doi.org/10.1101/2020.08.19.257204
     "A poliovirus-nonsusceptible Vero cell subline was generated. This cell line can be used to isolate viruses without the risk of generating poliovirus-infected materials, aiding global polio eradication efforts."

[815ms, saved to s_536e96a7]

💡 Extract data across these results with: map --from s_536e96a7 "your question"

```

### nigeria-2015-versioning__wc.txt

```
# command: wc /papers/PMC4552877/content.lines
# captured: 2026-05-22T00:19:35.9757086-07:00

116    7126   43204 /papers/PMC4552877/content.lines

```

