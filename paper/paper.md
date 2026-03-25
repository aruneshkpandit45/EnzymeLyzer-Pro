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

Quantitative enzyme assays are widely used in microbiology, and biochemical research for evaluating enzymatic activity in biological systems. Standard experimental methods such as the Bradford protein assay (@bradford1976) and DNS-based reducing sugar estimation (@miller1959) are commonly employed for enzyme characterization.

However, data analysis workflows typically involve multiple manual steps including spreadsheet-based calculations, statistical testing, and graphical visualization, which are time-consuming and prone to user error.

Existing tools often lack integration of enzyme-specific analytical workflows, statistical validation, and protocol guidance within a single platform. EnzymeLyzer Pro addresses these limitations by providing an interactive and reproducible environment that automates calculations, supports replication-based analysis, and standardizes enzyme assay workflows.

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
