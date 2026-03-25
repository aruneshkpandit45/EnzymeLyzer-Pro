# EnzymeLyzer Pro

### Quantitative Enzyme Assay Analysis Platform | R/Shiny

---

## Overview

EnzymeLyzer Pro is an interactive, open-source R/Shiny application for robust analysis and visualization of protein and enzyme assay data.

The platform supports multi-replicate experiments, automated calculations, statistical analysis, and publication-quality outputs suitable for scientific research and thesis work.

---

## Core Features

* Multi-enzyme configuration:
  Cellulase, Hemicellulase, Pectinase, Lipase, Invertase, Protease

* Stepwise workflow:

  * Protein estimation
  * Enzyme activity
  * Product concentration
  * Specific activity
  * Qualitative analysis

* Built-in statistical analysis:

  * One-way ANOVA
  * Tukey HSD post-hoc test
  * Coefficient of Variation (CV%)

* Visualization:

  * Grouped bar plots with significance letters
  * Error bars and replicate summaries
  * Publication-quality graphical output

* Data handling:

  * Multi-replicate support
  * Automated calculations
  * Ready-to-use CSV templates

---

##  Directory Structure

```
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
├── paper/
│   ├── paper.md
│   └── paper.bib
├── protocols/
│   └── full_protocol.md
├── LICENSE
├── README.md
```

---

## Live Application

 https://akpandit.shinyapps.io/enzymelyzer-pro/

The app may take a few seconds to load initially due to server activation.

---

## Usage

1. Prepare experimental data using CSV templates (`data/templates/`)
2. Launch the application
3. Start with **Protein Estimation**
4. Proceed sequentially through workflow tabs
5. Export results and figures for publication or thesis

---

## Output

* Enzyme Activity (U/mL)
* Specific Activity (U/mg protein)
* Product concentration
* ANOVA and Tukey HSD results
* CV% (replication quality metrics)
* Publication-ready plots

---

## Citation

Arunesh Kumar & S. Subramanian (2025).
**EnzymeLyzer Pro: An R/Shiny platform for quantitative enzyme assay analysis and visualization.**
GitHub Repository.

---

## Development Team

**Arunesh Kumar**
Lead Developer
ICAR–Indian Agricultural Research Institute (IARI), New Delhi
[akpandit.iari@gmail.com](mailto:akpandit.iari@gmail.com)

**Dr. S. Subramanian**
Principal Advisor & Co-Developer
Division of Entomology, ICAR-IARI
 [entosubra@yahoo.co.in](mailto:entosubra@yahoo.co.in)

---

## Support

* Open an issue on GitHub for bug reports or feature requests
* Contact via email for academic queries

---

## License

Released under the MIT License. See `LICENSE` file for details.

---

## © Copyright

© 2025 Arunesh Kumar & Dr. S. Subramanian
