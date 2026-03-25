title: "EnzymeLyzer Pro: An R/Shiny platform for quantitative enzyme assay analysis and visualization"
tags:
* R
* Shiny
* enzyme assay
* microbiology
* data analysis
  authors:
* name: Arunesh Kumar
  affiliation: 1
  email: [akpandit.iari@gmail.com](mailto:akpandit.iari@gmail.com)
* name: S. Subramanian
  affiliation: 1
* name: Raja Rushi
  affiliation: 1
* name: Sai Manoj Marella
  affiliation: 1
* name: Preeti Sharma
  affiliation: 1
* name: Pavan JS
  affiliation: 1
* name: Amit
  affiliation: 1
  affiliations:
* name: ICAR-Indian Agricultural Research Institute (IARI), New Delhi, India
  index: 1
  date: 2025
  bibliography: paper.bib

---

# Summary

EnzymeLyzer Pro is an open-source web-based application developed using R and Shiny for the analysis of enzyme assay data. The platform integrates multiple analytical steps including protein estimation, enzyme activity calculation, product concentration determination, specific activity normalization, and qualitative enzyme screening within a unified interface.

The application supports multi-replicate datasets and incorporates statistical analysis such as one-way analysis of variance (ANOVA) and Tukey’s HSD post-hoc test (@tukey1949), enabling robust comparison of enzymatic activity across microbial isolates. Additionally, EnzymeLyzer Pro generates publication-quality visualizations and integrates assay-specific protocols to improve reproducibility and usability.

---

# Statement of Need

Quantitative enzyme assays are fundamental tools in microbiology and biochemical research for evaluating enzymatic activity in microbial isolates and biological systems. Standard experimental methods such as the Bradford protein assay (@bradford1976) and DNS-based reducing sugar estimation (@miller1959) are widely used; however, the downstream analysis of such data remains largely fragmented and manual.

Researchers typically rely on spreadsheet-based calculations, manual normalization, and separate statistical software to perform analyses such as ANOVA and post-hoc comparisons. This multi-step workflow is not only time-consuming but also increases the likelihood of calculation errors, inconsistencies in data handling, and lack of reproducibility across studies.

Despite the widespread use of enzyme assays, there is currently no dedicated, integrated platform that combines protein estimation, enzyme activity calculation, specific activity normalization, statistical validation, and visualization within a single reproducible environment. Existing tools either focus on isolated analytical steps or require programming expertise, creating barriers for researchers without computational backgrounds.

EnzymeLyzer Pro addresses this gap by providing a unified, user-friendly platform that automates the complete enzyme assay analysis workflow. By integrating data processing, statistical analysis, and visualization with embedded experimental protocols, the tool enhances reproducibility, reduces analytical errors, and standardizes enzyme assay data analysis across laboratories.


---

# Features

EnzymeLyzer Pro provides the following capabilities:

* Multi-enzyme support including cellulase, hemicellulase, pectinase, lipase, invertase, and protease
* Protein estimation using standard curve regression methods
* Enzyme activity and specific activity calculation
* Product concentration analysis
* Statistical analysis including ANOVA and Tukey HSD
* Replication quality assessment using coefficient of variation (CV%)
* Generation of publication-quality graphical outputs
* Integration of enzyme assay protocols within the application

---

# Acknowledgements

The authors acknowledge the support and facilities provided by the Division of Entomology, ICAR-Indian Agricultural Research Institute (IARI), New Delhi.

The authors thank Dr. S. Subramanian for guidance in experimental design, enzyme assay methodology, and scientific supervision.

---

# References

@article{bradford1976}

@article{miller1959}

@article{tukey1949}

@book{r_core}
