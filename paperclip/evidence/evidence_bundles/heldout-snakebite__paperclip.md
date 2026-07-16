# Evidence Bundle: heldout-snakebite | Arm: Paperclip MCP

**Target identifier(s) requested:** PMID 29363648
**Case notes:** Held-out outside-wheelhouse: snakebite preclinical.
**Synthesizer rule:** Answer the 8 evaluation prompts using ONLY the Paperclip outputs below. Do not consult external knowledge of the paper, authors, or topic. Quote bundle text to support claims. If Paperclip's outputs are wrong, missing, or contaminated (e.g., map across multiple papers), say so explicitly.

**Known Paperclip behaviors to flag:**
- map -n 1 does NOT honor the result limit; map output across multiple papers is contaminated.
- Empty /papers/<id>/supplements/ directory does not mean no supplements — may be merged into content.lines.
- Top-1 search hit is not identity proof; check that returned PMC/med/arx ID matches the target.

## Paperclip retrieval outputs (verbatim)

### heldout-snakebite__lookup_pmid.txt

```
# command: lookup pmid 29363648
# captured: 2026-05-22T00:20:16.5816743-07:00

Found 1 papers

  1. Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on  Deinagkistrodon acutus  Envenomation in Adult Rats
     Mo Li, Zhi-Hui Xie, An-Yong Yu, Dong-Po He
     PMC5798054 · Chinese Medical Journal · 2018
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5798054/


```

### heldout-snakebite__ls.txt

```
# command: ls /papers/PMC5798054/
# captured: 2026-05-22T00:20:18.4814021-07:00

meta.json  content.lines  (92 lines)  sections/  figures/
  (read-only — use /.gxl/ for writable storage)

```

### heldout-snakebite__map_n_probe.txt

```
# command: map --from s_b3a5e578 -n 1 "What is the central mechanistic or empirical claim of THIS paper only?"
# captured: 2026-05-22T00:20:22.7781419-07:00

Map complete: 5/5 tasks succeeded in 1671ms
Results ID: m_2b6e90a3
Full results: /.gxl/map_m_2b6e90a3.txt

  [success] Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on  De  (PMC5798054)
    The central claim of this paper is that combining hyperbaric oxygen (HBO) with antivenom is more efficacious than antivenom alone in treating *Deinagk
  [success] Healthcare workers’ prioritization of snake antivenoms for the treatme  (med_ade7997372ff)
    The central empirical claim of this paper is that healthcare workers in the Kwahu Afram Plains districts of Ghana exhibit a clear hierarchy of antiven
  [success] Mechanism and Prevention of Hyperbaric Oxygen Convulsions  (arx_2402.14669)
    The provided text does not contain any content or claims; it only provides the title "Mechanism and Prevention of Hyperbaric Oxygen Convulsions." Ther
  [success] Effect of Several  Naja atra  Antivenom Injection Methods on the Rabbi  (PMC9970700)
    The central claim of this paper is that while intravenous antivenom administration effectively neutralizes systemic toxins (improving cardiac and hepa
  [success] Pathogenesis of local necrosis induced by  Naja atra  venom: Assessmen  (PMC7032728)
    The paper claims that while the Taiwanese freeze-dried neurotoxic antivenom (FNAV) is highly potent at neutralizing the lethality of *Naja atra* venom

Full results: /.gxl/map_m_2b6e90a3.txt

```

### heldout-snakebite__search_title.txt

```
# command: search -t --all "Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on Deinagkistrodon acutus Envenomation" -n 5
# captured: 2026-05-22T00:20:17.5792687-07:00

Found 5 papers  [s_863433b3]

  1. Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on  Deinagkistrodon acutus  Envenomation in Adult Rats
     Mo Li, Zhi-Hui Xie, An-Yong Yu, Dong-Po He
     PMC5798054 · PMC · 2018-02-05
     https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5798054/
     "This study investigated the effects of antivenom combined with hyperbaric oxygen on *Deinagkistrodon acutus* envenomation in rats. The combination therapy significantly reduced brain damage and improved coagulation and oxidative stress markers compared to antivenom alone."

  2. Healthcare workers’ prioritization of snake antivenoms for the treatment of snakebite envenoming: Perspectives from Ghana
     Eric Nyarko *, Ebenezer Kwesi Ameho
     med_ade7997372ff · medRxiv · 2025-06-12
     https://doi.org/10.1101/2025.06.12.25329513
     "Healthcare workers in Ghana were surveyed on their antivenom prioritization for snakebite treatment. Inoserp Pan-Africa polyvalent antivenom was most highly prioritized, while several others were least prioritized."

  3. Mechanism and Prevention of Hyperbaric Oxygen Convulsions
     Ondrej Groborz and Ludek Sefc and Petr Marsalek
     arx_2402.14669 · arXiv · 2024-02-22
     "This study investigated the mechanisms behind hyperbaric oxygen convulsions and proposed preventive strategies. Increased reactive oxygen species and direct pressure effects on inhibitory receptors contribute to convulsions, which can be prevented with antioxidants, pyridoxine, and sedatives."

  4. Effect of Several  Naja atra  Antivenom Injection Methods on the Rabbit Model of  Naja naja atra  Bite Poisoning
     Jie Yang, Jin-Cheng Li, Zhou Huang, Dong-Ling Huang, Fan Wang, Wan-Xia Wei, Ji-Fei Nong, Feng Yang, ...
     PMC9970700 · biomedrxiv · 2023-01-01
     https://doi.org/10.1155/2023/3253771
     "This study investigated the effects of different injection methods for *Naja atra* antivenom on a rabbit model of cobra envenomation. Topical antivenom injection was found to potentially ameliorate local tissue necrosis."

  5. Pathogenesis of local necrosis induced by  Naja atra  venom: Assessment of the neutralization ability of Taiwanese freeze-dried neurotoxic antivenom in animal models
     Chien-Chun Liu, Yu-Shao Chou, Chun-Yu Chen, Kuei-Lin Liu, Guo-Jen Huang, Jau-Song Yu, Cho-Ju Wu, Gen...
     PMC7032728 · biomedrxiv · 2020-02-07
     https://doi.org/10.1371/journal.pntd.0008054
     "This study investigated the ability of Taiwanese freeze-dried neurotoxic antivenom (FNAV) to neutralize local necrosis induced by *Naja atra* venom in animal models. FNAV effectively neutralized lethal venom effects but failed to prevent necrosis caused by venom cytotoxins."

[499ms, saved to s_863433b3]

💡 Extract data across these results with: map --from s_863433b3 "your question"

```

### heldout-snakebite__wc.txt

```
# command: wc /papers/PMC5798054/content.lines
# captured: 2026-05-22T00:20:19.1453563-07:00

92    5172   33630 /papers/PMC5798054/content.lines

```

