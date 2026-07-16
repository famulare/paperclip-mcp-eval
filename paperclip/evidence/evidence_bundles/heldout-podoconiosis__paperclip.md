# Evidence Bundle: heldout-podoconiosis | Arm: Paperclip MCP

**Target identifier(s) requested:** PMID 33558538
**Case notes:** Held-out outside-wheelhouse: NTD genetics.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

### heldout-podoconiosis__lookup_pmid.txt

```
# command: lookup pmid 33558538
# captured: 2026-05-22T00:20:23.9831547-07:00

Found 1 papers

  1. Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups
     Tewodros Gebresilase, Chris Finan, Daniel Suveges, Tesfaye Sisay Tessema, Abraham Aseffa, Gail Davey...
     PMC7870958 · Scientific Reports · 2021
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7870958/


```

### heldout-podoconiosis__ls.txt

```
# command: ls /papers/PMC7870958/
# captured: 2026-05-22T00:20:26.3141125-07:00

meta.json  content.lines  (134 lines)  sections/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### heldout-podoconiosis__map_n_probe.txt

```
# command: map --from s_004d5954 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:20:31.3794426-07:00

Map complete: 5/5 tasks succeeded in 2084ms
Results ID: m_96c0ef1e
Full results: /.gxl/map_m_96c0ef1e.txt

  [success] Replication of HLA class II locus association with susceptibility to p  (PMC7870958)
    The central empirical claim of this paper is that the association between HLA class II variants and susceptibility to podoconiosis is confirmed across
  [success] Confirmation of HLA-II associations with TB susceptibility in admixed   (med_6470252a6d97)
    The paper claims that the "local ancestry allelic adjusted association" (LAAA) model successfully identifies a near-genome-wide significant associatio
  [success] The class of the bielliptic locus in genus 3  (arx_1206.4301)
    The provided text contains only the title of the paper ("The class of the bielliptic locus in genus 3") and lacks the body content. Therefore, the cen
  [success] Evidence for immune activation in pathogenesis of the HLA class II ass  (PMC10917762)
    The central claim of this paper is that podoconiosis is a soil particle-driven, HLA-associated disease characterized by a state of persistent immune a
  [success] Prediction of HLA Class II Alleles Using SNPs in an African Population  (PMC3386230)
    The central claim of this paper is that HLA class II alleles (HLA-DRB1 and HLA-DQB1) can be predicted from SNP genotype data with a high level of accu

Full results: /.gxl/map_m_96c0ef1e.txt

```

### heldout-podoconiosis__search_title.txt

```
# command: search -t --all "Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups" -n 5
# captured: 2026-05-22T00:20:25.3244186-07:00

Found 3 papers  [s_1cfc1d10]

  1. Confirmation of HLA-II associations with TB susceptibility in admixed African samples
     Dayna Croock, Yolandi Swart, Haiko Schurz, Desiree C. Petersen, Marlo Möller, Caitlin Uren *
     med_6470252a6d97 · medRxiv · 2024-05-30
     https://doi.org/10.1101/2024.05.30.24308060
     "This study investigated TB susceptibility in an admixed South African cohort using a local ancestry adjusted model. A significant association was found in the HLA-DPB1 gene, confirming its role in TB susceptibility in this population."

  2. The class of the bielliptic locus in genus 3
     Carel Faber and Nicola Pagani
     arx_1206.4301 · arXiv · 2012-06-19
     "Researchers calculated the bielliptic locus class in the moduli space of genus 3 curves. This class was determined by intersecting the locus with specific surfaces."

  3. Replication of HLA class II locus association with susceptibility to podoconiosis in three Ethiopian ethnic groups
     Tewodros Gebresilase, Chris Finan, Daniel Suveges, Tesfaye Sisay Tessema, Abraham Aseffa, Gail Davey...
     PMC7870958 · PMC · 2021-02-08
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7870958/
     "This study replicated a genome-wide association study for podoconiosis susceptibility in three Ethiopian ethnic groups. The HLA class II region was confirmed to be significantly associated with the disease, suggesting a role for immune responses in its pathogenesis."

[802ms, saved to s_1cfc1d10]

💡 Extract data across these results with: map --from s_1cfc1d10 "your question"

```

### heldout-podoconiosis__wc.txt

```
# command: wc /papers/PMC7870958/content.lines
# captured: 2026-05-22T00:20:27.0416370-07:00

134    8412   55364 /papers/PMC7870958/content.lines

```

