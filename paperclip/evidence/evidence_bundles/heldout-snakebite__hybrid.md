# Evidence Bundle: heldout-snakebite | Arm: Hybrid (predeclared workflow)

**Target identifier(s) requested:** PMID 29363648
**Case notes:** Held-out outside-wheelhouse: snakebite preclinical.
**Synthesizer rule:** This is the hybrid arm. You have access to web/API identity, Paperclip retrieval, and (if applicable) local PDF slices. Answer the 8 prompts using only the evidence in this bundle. Treat the web/API metadata as identity truth, Paperclip outputs as content evidence to be checked, and local PDF slices as content evidence to be checked. Flag arm conflicts (e.g., Paperclip returned a different paper than the target) explicitly. Do not invent.

## Section 1 — Web/API identity and abstract

# Ground Truth: heldout-snakebite

**Origin:** Claude Opus 4.7 (1M context). Authoritative metadata from PubMed/PMC/arXiv/ClinicalTrials.gov.
**Date built:** 2026-05-22
**Case family:** Snakebite antivenom efficacy (rat study)
**Case type:** concept-discovery outside wheelhouse
**Wheelhouse:** no

## PubMed source-of-record

- **PMID:** 29363648
- **PMCID:** PMC5798054
- **DOI:** 10.4103/0366-6999.223840
- **Title:** Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on Deinagkistrodon acutus Envenomation in Adult Rats.
- **Authors (top 6):** Li M; Xie ZH; Yu AY; He DP
- **Journal:** Chinese medical journal
- **Pub date:** 2018 Feb 5

## Abstract (fair-use snippet)

```
1. Chin Med J (Engl). 2018 Feb 5;131(3):323-329. doi: 10.4103/0366-6999.223840.

Increased Efficacy of Antivenom Combined with Hyperbaric Oxygen on 
Deinagkistrodon acutus Envenomation in Adult Rats.

Li M(1), Xie ZH(2), Yu AY(1), He DP(1).

Author information:
(1)Department of Emergency, The First Affiliated Hospital of Zunyi Medical 
College, Zunyi, Guizhou 563003, China.
(2)Department of Hyperbaric Oxygen, The First Affiliated Hospital of Zunyi 
Medical College, Zunyi, Guizhou 563003, China.

BACKGROUND: Snakebites are a neglected threat to global human health with a high 
morbidity rate. The present study explored the efficacy of antivenom with 
hyperbaric oxygen (HBO) intervention on snakebites, which could provide the 
experimental basis for clinical adjuvant therapy.
METHODS: Male Sprague-Dawley rats (n = 96) were randomized into four groups: the 
poison model was established by injecting Deinagkistrodon acutus (D. acutus) 
venom (0.8 LD50) via the caudal vein; the antivenom group was injected 
immediately with specific antivenom via the caudal vein after successful 
establishment of the envenomation model; and the antivenom + HBO group was 
exposed to HBO environment for 1 h once at predetermined periods of 0 h, 4 h, 12 
h, and 23 h after antivenin administration. Each HBO time point had six rats; 
the control group was left untreated. The rats in the experimental group were 
euthanized at the corresponding time points after HBO therapy, and brain tissue 
and blood were harvested immediately. Hematoxylin and eosin (H&E) staining was 
used to investigate the pathological changes in the rat brain. 
Immunohistochemistry (IHC), real-time polymerase chain reaction (PCR), and 
Western blotting were used to detect the expression of Nestin mRNA and protein 
in the subventricular zone (SVZ) of the brain. The levels of coagulation 
function (prothrombin time, activated partial thromboplastin time [APTT], and 
fibrinogen) and oxidation/antioxidation index (malondialdehyde [MDA] and 
superoxide dismutase [SOD]) were analyzed. Data were analyzed using one-way 
analysis of variance.
RESULTS: The brain tissue from rats in the poison model was observed for 
pathological changes using H&E staining. Tissues showed edema, decreased cell 
number, and disordered arrangement in the SVZ in the snake venom group. The 
antivenom - HBO intervention significantly alleviated these observations and was 
more prominent in the antivenom + HBO group. The serum levels of SOD and MDA in 
the snake venom group were increased and the antivenom - HBO intervention 
further increased the SOD levels but significantly decreased the MDA levels; 
however, this was enhanced within 1 h after HBO administration (MDA: F = 5.540, 
P = 0.008, SOD: F = 7.361, P = 0.000). Activated partial thromboplastin time 
(APTT) was significantly abnormal after venom administration but improved after 
antivenom and was even more significant in the antivenom + HBO group 5 h after 
envenomation (F = 25.430, P = 0.000). Only a few nestin-positive cells were 
observed in the envenomation model. The expression levels were significant in 
the antivenom and antivenom + HBO groups within 1 and 5 h after envenomation and 
were more significant in the antivenom + HBO group as determined by IHC, 
real-time PCR, and Western blotting (P < 0.05). D. acutus envenomation has 
neurotoxic effects in the brain of rats.
CONCLUSIONS: Antivenin and HBO, respectively, induced a neuroprotective effect 
after D. acutus envenomation by attenuating brain edema, upregulating nestin 
expression in SVZ, and improving coagulopathy and oxidative stress. The 
intervention efficacy of antivenom with HBO was maximum within 5 h after 
envenomation and was more efficacious than antivenom alone.
```

## Diagnostic claim anchors (scorer reference)

- Animal (rat) study of antivenom efficacy combined with hyperbaric oxygen for Deinagkistrodon acutus envenomation.
- Preclinical/translational rather than human trial.
- Toxinology / envenomation subject area.

## Notes for scorers

- This file is the answer key for scoring. Compare arm-isolated synthesis answers against the identity fields, abstract, and diagnostic claim anchors.
- Do not infer beyond what is on this page.
- If an arm output makes claims that go beyond this ground truth without arm-bundle evidence, that is unsupported-claim territory.


## Section 2 — Paperclip retrieval outputs (verbatim)

Reminder: map -n 1 does not honor -n; map outputs may be multi-paper. Empty supplement dir does not mean no supplements (could be merged into content.lines).

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


