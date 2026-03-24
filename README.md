EnzymeLyzer Pro
Quantitative Enzyme Assay Analysis Platform | R/Shiny

Overview
EnzymeLyzer Pro is an interactive, open-source R/Shiny application for robust analysis and visualization of protein and enzyme assay data. It supports multi-replicate studies, automated calculations, statistical grouping, and publication-quality visual output suitable for scientific research and thesis work.

Core Features
Multi-enzyme configuration: Cellulase, Hemicellulase, Pectinase, Lipase, Invertase, Protease

Stepwise workflow covering protein estimation, enzyme activity, product concentration, specific activity, and qualitative analyses

Built-in statistical analysis: ANOVA, Tukey HSD post-hoc, and CV% precision checks

Grouped bar plots with significance letters for easy interpretation

Automated quality, error bar, and replicate reporting

Easy-to-use CSV templates and sample data

Directory Structure
text
EnzymeLyzer-Pro/
├── app.R
├── www/
│   └── enzymelyzer_logo.png
├── data/
│   └── templates/
│       ├── bradford_standards.csv
│       ├── protein_samples.csv
│       ├── enzyme_assay.csv
│       ├── qualitative_zone.csv
│       ├── cellulase_standards.csv
│       ├── hemicellulase_standards.csv
│       ├── pectinase_standards.csv
│       ├── lipase_standards.csv
│       ├── invertase_standards.csv
│       ├── protease_standards.csv
├── protocols/
        ├── full_protocol.md
├── LICENSE
├── README.md

Deployment
Ready for easy one-click deploy at shinyapps.io
https://akpandit.shinyapps.io/enzymelyzer-pro/
Usage
Prepare your experimental data using the CSV templates in data/templates/.

Launch the app.

Begin with the "Protein Estimation" tab, then proceed through the workflow tabs.

Download results and figures as needed for publication/thesis.

Citation
Arunesh Kumar & S. Subramanian (2025). EnzymeLyzer Pro: An R/Shiny platform for quantitative enzyme assay analysis and visualization. GitHub

License
Released under the MIT License.
See LICENSE for details.

Development Team
Arunesh Kumar
Lead Developer
Indian Agricultural Research Institute, New Delhi
Email: akpandit.iari@gmail.com

Dr. S. Subramanian
Principal Advisor & Co-Developer
Molecular Entomology Laboratory
Email: entosubra@yahoo.co.in

Help & Support
Open an issue on GitHub for bug reports or feature requests.

Email Arunesh Kumar for questions (akpandit.iari@gmail.com).

© 2025 Arunesh Kumar & Dr. S. Subramanian | Released under the MIT License
