# EnzymeLyzer Pro
# Professional Enzyme Assay Analysis Platform
# Version: 1.0.0 (Production Ready)
# License: MIT
# Last Updated: November 2025

library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
library(DT)

# ===== ENZYME CONFIGURATION =====
enzyme_config <- list(
  Cellulase = list(
    standard_product = "Glucose",
    standard_wavelength = "540 nm (DNS)",
    product_unit = "mg/mL",
    molar_mass = 180,
    enzyme_unit = "U/mL"
  ),
  Hemicellulase = list(
    standard_product = "Xylose",
    standard_wavelength = "540 nm (DNS)",
    product_unit = "mg/mL",
    molar_mass = 150,
    enzyme_unit = "U/mL"
  ),
  Pectinase = list(
    standard_product = "D-galacturonic acid",
    standard_wavelength = "540 nm",
    product_unit = "mg/mL",
    molar_mass = 194,
    enzyme_unit = "U/mL"
  ),
  Lipase = list(
    standard_product = "p-Nitrophenol (pNP)",
    standard_wavelength = "410 nm",
    product_unit = "µM",
    molar_mass = 139,
    enzyme_unit = "U/mL"
  ),
  Invertase = list(
    standard_product = "Glucose",
    standard_wavelength = "540 nm (DNS)",
    product_unit = "mg/mL",
    molar_mass = 180,
    enzyme_unit = "U/mL"
  ),
  Protease = list(
    standard_product = "Tyrosine",
    standard_wavelength = "280 nm",
    product_unit = "mg/mL",
    molar_mass = 181,
    enzyme_unit = "U/mL"
  )
)

# ===== DEVELOPER INFORMATION =====
developer_name <- "Arunesh Kumar"
developer_institution <- "Indian Agricultural Research Institute, New Delhi"
developer_department <- "Department of Entomology"
developer_email <- "akpandit.iari@gmail.com"
developer_github <- "aruneshkpandit45"
advisor_name <- "Dr. S. Subramanian (Principal Scientist and Professor Division of Entomology ICAR-IARI New Delhi)"
advisor_email <- "entosubra@yahoo.co.in"
lab_name <- "Molecular Entomology Laboratory"
# ===== CO-DEVELOPERS =====
co_developers <- list(
  list(name = "C N Rajarushi", role = "Statistical Analysis"),
  list(name = "Sai Manoj Marella", role = "UI Design"),
  list(name = "Preeti Sharma", role = "UI Design"),
  list(name = "Pavan JS", role = "Enzyme Workflow & Protocol Design"),
  list(name = "Amit Umesh Paschapur", role = "Enzyme Workflow & Protocol Design")
)

# ===== USER INTERFACE =====
ui <- fluidPage(
  
  # ===== CSS FOR HEADER WITH HORIZONTAL TABS =====
  tags$style(HTML("
    .enzyme-header {
      background: linear-gradient(135deg, #ecf0f1 0%, #f8f9f9 100%);
      padding: 25px 30px;
      border-bottom: 3px solid #2980b9;
      margin-bottom: 20px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      border-radius: 8px;
    }
    
    .enzyme-header-top {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      margin-bottom: 20px;
    }
    
    .enzyme-header img {
      height: 156px;
      margin-right: 0px;
      vertical-align: middle;
      max-width: 100%;
      width: auto;
    }
    
       .reaction-volume-box {
      background-color: #fff9e6;
      border: 2px solid #f39c12;
      border-radius: 8px;
      padding: 15px;
      margin: 15px 0;
    }
    
    .protocol-btn {
      background-color: #e8f4f8;
      border: 2px solid #2980b9;
      color: #2980b9;
      border-radius: 5px;
      padding: 10px 15px;
      font-weight: 600;
      cursor: pointer;
      margin-top: 10px;
      transition: all 0.3s ease;
      width: 100%;
    }
    
    .protocol-btn:hover {
      background-color: #2980b9;
      color: white;
    }

    .enzyme-title {
      display: flex;
      flex-direction: column;
      justify-content: center;
    }
    
    .enzyme-title h1 {
      color: #2c3e50;
      margin: 0;
      font-weight: bold;
      font-size: 2.1em;
      line-height: 1.1;
    }
    
    .enzyme-title p {
      color: #16a085;
      margin: 0;
      font-size: 1.05em;
      font-weight: bold;
      padding-left: 2px;
    }
    
    .enzyme-header-tabs {
      display: flex;
      flex-wrap: nowrap;
      gap: 8px;
      padding-top: 15px;
      border-top: 2px solid rgba(41, 128, 185, 0.2);
      overflow-x: auto;
    }
    
    .enzyme-header-tabs a {
      display: inline-block;
      padding: 8px 14px;
      background-color: rgba(255, 255, 255, 0.6);
      color: #2980b9 !important;
      text-decoration: none;
      border-radius: 4px;
      font-size: 0.9em;
      font-weight: 500;
      transition: all 0.3s ease;
      border: 1px solid rgba(41, 128, 185, 0.3);
      cursor: pointer;
      white-space: nowrap;
    }
    
    .enzyme-header-tabs a:hover {
      background-color: #2980b9;
      color: white !important;
      transform: translateY(-2px);
      box-shadow: 0 2px 8px rgba(41, 128, 185, 0.3);
    }
    
    .enzyme-header-tabs a.active {
      background-color: #2980b9;
      color: white !important;
      border: 1px solid #2980b9;
      font-weight: 600;
    }
    
    .nav-tabs {
      display: none !important;
    }
  ")),

  # ===== HEADER WITH TABS =====
  div(class = "enzyme-header",
      div(class = "enzyme-header-top",
          tags$img(
            src = "www/enzymelyzer_logo.png",
            height = "200px"
          ),
          div(class = "enzyme-title",
              h1("EnzymeLyzer Pro"),
              p("Quantitative Enzyme Assay Analysis Platform")
          )
      ),
      div(class = "enzyme-header-tabs",
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"About\"]').click(); return false;", "About"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Instructions\"]').click(); return false;", "Instructions"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Protein Estimation\"]').click(); return false;", "Protein Estimation"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Enzyme Activity\"]').click(); return false;", "Enzyme Activity"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Product Concentration\"]').click(); return false;", "Product Concentration"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Specific Activity\"]').click(); return false;", "Specific Activity"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Replication Quality\"]').click(); return false;", "Replication Quality"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Statistics & Plots\"]').click(); return false;", "Statistics & Plots"),
          a(href = "#", class = "nav-link", onclick = "$('[data-value=\"Qualitative Analysis\"]').click(); return false;", "Qualitative Analysis")
        
      )
  ),
  
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      h3("Navigation", style = "color: #2980b9;"),
      selectInput("enzyme_type_nav", "Select Enzyme Type:", names(enzyme_config), "Cellulase"),
      hr(),
      p(strong("Analysis Workflow:"), style = "font-size: 14px;"),
      tags$ol(
        tags$li("Protein Estimation"),
        tags$li("Enzyme Activity"),
        tags$li("Product Concentration"),
        tags$li("Specific Activity"),
        tags$li("Replication Quality"),
        tags$li("Statistical Analysis"),
        tags$li("Qualitative Analysis")
      )
    ),
    
    mainPanel(
      width = 9,
      
      tabsetPanel(
        tabPanel("About",
                 
                 h2("EnzymeLyzer Pro - Professional Enzyme Analysis Platform", 
                    style = "color: #2980b9; text-align: center;"),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 h3("Overview", style = "color: #2980b9;"),
                 p("EnzymeLyzer Pro is a web-based analytical platform for quantitative enzyme assay analysis. 
    It provides automated data processing, statistical validation, and publication-ready outputs 
    for enzyme characterization studies."),
                 
                 h4("Core Features", style = "color: #34495e;"),
                 tags$ul(
                   tags$li(strong("Multi-Replication Support:"), " Analysis with ≥3 replicates per sample"),
                   tags$li(strong("Specific Activity Normalization:"), " Enzyme activity expressed as U/mg protein"),
                   tags$li(strong("Statistical Framework:"), " ANOVA with Tukey HSD post-hoc testing"),
                   tags$li(strong("Multiple Enzyme Support:"), " Configured for major enzyme classes"),
                   tags$li(strong("Publication-Ready Output:"), " Graphs and statistical summaries"),
                   tags$li(strong("Quality Control:"), " R² and CV% evaluation")
                 ),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 h3("Methodology", style = "color: #2980b9;"),
                 tags$ul(
                   tags$li("Protein quantification using Bradford assay with standard curve regression"),
                   tags$li("Enzyme activity calculation with blank correction and reaction normalization"),
                   tags$li("Specific activity calculation: U/mg protein"),
                   tags$li("Statistical analysis using ANOVA and Tukey HSD (α = 0.05)")
                 ),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 h3("Publication & Citation", style = "color: #2980b9;"),
                 div(style = "background-color: #ecf0f1; padding: 15px; border-left: 4px solid #2980b9; border-radius: 5px;",
                     p("EnzymeLyzer Pro v1.0: A web-based platform for quantitative enzyme assay analysis with replication support and statistical validation.", 
                       style = "margin: 0; font-style: italic;")
                 ),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 h3("Development Team", style = "color: #2980b9;"),
                 
                 div(style = "background-color: #eaf4fb; padding: 18px; border-radius: 10px;",
                     h5("👨‍💻 Lead Developer", style = "margin-top:0; color:#2c3e50;"),
                     p(
                       strong("Arunesh Kumar"), br(),
                       "ICAR–Indian Agricultural Research Institute (IARI), New Delhi", br(),
                       "Division of Entomology", br(),
                       a(developer_email, href = paste0("mailto:", developer_email), style = "color:#2980b9;"), br(),
                       a(developer_github, href = paste0("https://github.com/", developer_github), target = "_blank"),
                       style = "line-height:1.7; margin:0;"
                     )
                 ),
                 
                 div(style = "background-color: #fff7e6; padding: 18px; border-radius: 10px; margin-top: 12px;",
                     h5("🧠 Scientific Advisor", style = "margin-top:0; color:#2c3e50;"),
                     p(
                       strong("Dr. S. Subramanian"), br(),
                       "Principal Scientist", br(),
                       "Division of Entomology, ICAR-IARI, New Delhi", br(),
                       "Molecular Entomology Laboratory", br(),
                       a(advisor_email, href = paste0("mailto:", advisor_email), style = "color:#2980b9;"),
                       style = "line-height:1.7; margin:0;"
                     )
                 ),
                 div(style = "background-color: #f3eefc; padding: 18px; border-radius: 10px; margin-top: 12px;",
                     h5("👥 Co-Developers", style = "margin-top:0; color:#2c3e50;"),
                     
                     tags$ul(style = "padding-left:18px; margin:0;",
                             lapply(co_developers, function(dev) {
                               tags$li(
                                 tags$span(style="font-weight:600;", dev$name),
                                 paste0(" — ", dev$role)
                               )
                             })
                     )
                 ),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 h3("Technical Support", style = "color: #2980b9;"),
                 tags$ul(
                   tags$li("Email: ", a(developer_email, href = paste0("mailto:", developer_email))),
                   tags$li("Advisor: ", a(advisor_email, href = paste0("mailto:", advisor_email)))
                 ),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 h3("Version Information", style = "color: #2980b9;"),
                 p(strong("Version:"), "1.0.0", br(),
                   strong("Release Date:"), "November 2025", br(),
                   strong("License:"), "MIT License",
                   style = "line-height: 1.8;"),
                 
                 hr(style = "border-top: 2px solid #2980b9;"),
                 
                 div(style = "text-align: center; color: #7f8c8d; padding: 20px;",
                     p(strong("EnzymeLyzer Pro v1.0.0"), br(),
                       "© 2025 Arunesh Kumar & Dr. S. Subramanian", br(),
                       "Licensed under MIT License")
                 )
        ),
        tabPanel("Instructions",
                 
                 h2("User Guide", style = "color: #2980b9;"),
                 hr(),
                 
                 h3("Workflow Overview", style = "color: #2980b9;"),
                 tags$ol(
                   tags$li("Upload protein standard data and sample data for protein estimation"),
                   tags$li("Upload enzyme standard curve data"),
                   tags$li("Upload enzyme assay data (including blanks and replicates)"),
                   tags$li("Set reaction parameters (volume and time)"),
                   tags$li("Click 'Calculate' to compute enzyme activity"),
                   tags$li("Proceed to Product Concentration and Specific Activity tabs"),
                   tags$li("Perform statistical analysis and visualize results")
                 ),
                 
                 hr(),
                 
                 h3("Data Requirements", style = "color: #2980b9;"),
                 tags$ul(
                   tags$li("Use provided CSV templates for correct formatting"),
                   tags$li("Include at least 3 replicates per sample"),
                   tags$li("Ensure blank values are included for correction"),
                   tags$li("Maintain consistent naming of samples and microorganisms")
                 ),
                 
                 hr(),
                 
                 h3("Protocol Usage", style = "color: #2980b9;"),
                 p("Detailed enzyme assay protocols are integrated within the application."),
                 
                 tags$ul(
                   tags$li("Select enzyme type from the sidebar"),
                   tags$li("Navigate to 'Enzyme Activity' tab"),
                   tags$li("Click '📖 View Protocol' to access assay procedure")
                 ),
                 
                 hr(),
                 
                 h3("Output Interpretation", style = "color: #2980b9;"),
                 tags$ul(
                   tags$li("Enzyme Activity: Expressed as U/mL"),
                   tags$li("Specific Activity: Expressed as U/mg protein"),
                   tags$li("Statistical outputs include ANOVA and Tukey HSD grouping"),
                   tags$li("Coefficient of Variation (CV%) indicates data precision")
                 ),
                 
                 hr(),
                 
                 h3("Notes", style = "color: #2980b9;"),
                 tags$ul(
                   tags$li("Ensure proper calibration of spectrophotometer"),
                   tags$li("Maintain consistent assay conditions across samples"),
                   tags$li("Verify standard curve linearity before analysis")
                 ),
                 
                 hr(),
                 
                 div(style = "color: #7f8c8d;",
                     p("For detailed experimental protocols and references, refer to the project repository documentation.")
                 
                 )
                     ),
        

        tabPanel("Protein Estimation",
                 h3("Bradford Protein Assay"),
                 
                 fluidRow(
                   column(6,
                          h4("Standard Curve", style = "color: #2980b9;"),
                          p("15-point calibration (5 concentrations × 3 replicates)", style = "color: #7f8c8d;"),
                          fileInput("protein_standards_file", "Upload Standards CSV"),
                          downloadButton("dl_protein_standards_template", "Download Template", class = "btn-info"),
                          br(), br(),
                          plotOutput("protein_calibration_plot", height = "300px"),
                          verbatimTextOutput("protein_calib_eq")
                   ),
                   
                   column(6,
                          h4("Sample Analysis", style = "color: #2980b9;"),
                          p("Protein concentration in test samples", style = "color: #7f8c8d;"),
                          fileInput("protein_samples_file", "Upload Sample Data CSV"),
                          downloadButton("dl_protein_samples_template", "Download Template", class = "btn-info"),
                          br(), br(),
                          actionButton("calc_protein", "Calculate", class = "btn-success btn-block"),
                          br(), br(),
                          downloadButton("dl_protein_results", "Export Results", class = "btn-success")
                   )
                 ),
                 
                 hr(),
                 h4("Results"),
                 DTOutput("protein_results_table"),
                 hr(),
                 h4("Summary Statistics"),
                 DTOutput("protein_stats_table")
        ),
        
        
        tabPanel("Enzyme Activity",
                 h3("Enzyme Activity Assay"),
                 
                 fluidRow(
                   column(6,
                          h4("Standard Curve", style = "color: #2980b9;"),
                          p(textOutput("enzyme_info_display1")),
                          p(textOutput("enzyme_product_display")),
                          p(textOutput("enzyme_wavelength_display"), style = "color: #7f8c8d;"),
                          fileInput("enzyme_standards_file", "Upload Standards CSV"),
                          downloadButton("dl_enzyme_template", "Download Template", class = "btn-info"),
                          br(), br(),
                          plotOutput("enzyme_calibration_plot", height = "300px"),
                          verbatimTextOutput("enzyme_calib_eq")
                   ),
                   
                   column(6,
                          h4("Assay Data", style = "color: #2980b9;"),
                          p("Activity calculation with blank correction", style = "color: #7f8c8d;"),
                          fileInput("enzyme_assay_file", "Upload Assay Data CSV"),
                          downloadButton("dl_enzyme_assay_template", "Download Template", class = "btn-info"),
                          br(), br(),
                          div(class = "reaction-volume-box",
                              h5("⚙️ Reaction Parameters"),
                              numericInput("reaction_volume_user", "Reaction Volume (mL)", value = 1.0, min = 0, step = 0.1),
                              numericInput("reaction_time_user", "Reaction Time (min)", value = 30, min = 1)
                          ),
                          actionButton("show_protocol", "📖 View Protocol", class = "protocol-btn"),
                          br(),
                          actionButton("calc_enzyme", "Calculate", class = "btn-success btn-block")
                   )
                 ),
                 
                 hr(),
                 h4("Results"),
                 DTOutput("enzyme_activity_table"),
                 br(),
                 downloadButton("dl_enzyme_activity", "Export", class = "btn-success"),
                 hr(),
                 h4("Summary Statistics"),
                 DTOutput("enzyme_activity_stats_table")
        ),
                 
                 
                 tabPanel("Product Concentration",
                          h3("Product Concentration Analysis"),
                          p("Quantitative determination of product formation", style = "color: #16a085; font-weight: bold;"),
                          br(),
                          h4("Results"),
                          DTOutput("product_concentration_table"),
                          hr(),
                          h4("Summary"),
                          DTOutput("product_concentration_stats_table")
                 ),
                 
                
                 tabPanel("Specific Activity",
                          h3("Specific Activity - Normalized Enzyme Efficiency"),
                          p("Enzyme activity normalized to protein concentration", style = "color: #16a085; font-weight: bold;"),
                          
                          fluidRow(
                            column(6, 
                                   h4("Protein Data"),
                                   fileInput("protein_for_specific", "Upload protein_results.csv"),
                                   p("From Protein Estimation", style = "color: #7f8c8d;")
                            ),
                            column(6,
                                   h4("Enzyme Data"),
                                   fileInput("enzyme_for_specific", "Upload enzyme_activity.csv"),
                                   p("From Enzyme Activity", style = "color: #7f8c8d;")
                            )
                          ),
                          
                          br(),
                          actionButton("calc_specific", "Calculate Specific Activity", class = "btn-success btn-lg btn-block"),
                          hr(),
                          h4("Results"),
                          DTOutput("specific_activity_table"),
                          br(),
                          downloadButton("dl_specific_activity", "Export", class = "btn-success"),
                          hr(),
                          h4("Summary Statistics"),
                          DTOutput("specific_activity_stats_table")
                 ),
                 
            
                 tabPanel("Replication Quality",
                          h3("Replication Assessment & Quality Control"),
                          p("Measurement precision and reproducibility evaluation", style = "color: #16a085; font-weight: bold;"),
                          br(),
                          h4("Protein - Replicates"),
                          DTOutput("protein_replication_table"),
                          hr(),
                          h4("Enzyme Activity - Replicates"),
                          DTOutput("enzyme_replication_table"),
                          hr(),
                          h4("Specific Activity - Summary"),
                          DTOutput("specific_replication_table"),
                          hr(),
                          h4("Quality Metrics (CV%)"),
                          verbatimTextOutput("replication_quality_metrics")
                 ),
                 
                 
                 tabPanel("Statistics & Plots",
                          h3("Statistical Analysis and Visualizations"),
                          br(),
                          h4("Mean Specific Activity with Error Bars"),
                          plotOutput("plot_specific_activity", height = "300px"),
                          hr(),
                          h4("Individual Replicate Values"),
                          plotOutput("plot_all_replicates", height = "300px"),
                          hr(),
                          h4("Distribution with Box Plot"),
                          plotOutput("plot_boxplot_activity", height = "300px"),
                          hr(),
                          h4("Mean with 95% Confidence Intervals"),
                          plotOutput("plot_barplot_activity", height = "300px"),
                          hr(),
                          h4("With Tukey HSD Statistical Grouping"),
                          p("Letters above bars: Same letter = not significantly different (p > 0.05), Different letters = significant difference (p < 0.05)", 
                            style = "color: #34495e; font-size: 12px;"),
                          plotOutput("plot_barplot_grouped", height = "300px"),
                          hr(),
                          h4("CV% Quality Assessment"),
                          plotOutput("plot_cv", height = "300px"),
                          hr(),
                          h3("Statistical Results", style = "color: #2980b9;"),
                          h4("Descriptive Statistics"),
                          verbatimTextOutput("quant_descriptive_stats"),
                          hr(),
                          h4("One-Way ANOVA"),
                          verbatimTextOutput("quant_anova_results"),
                          hr(),
                          h4("Tukey HSD Post-hoc Test"),
                          verbatimTextOutput("quant_posthoc_results")
                 ),
                 
                 
                 tabPanel("Qualitative Analysis",
                          h3("Zone Diameter Analysis"),
                          fileInput("qualitative_data_file", "Upload Zone Assay CSV"),
                          downloadButton("dl_qualitative_template", "Download Template", class = "btn-info"),
                          br(), hr(),
                          actionButton("calc_qualitative", "Calculate", class = "btn-success btn-block"),
                          hr(),
                          h4("Results"),
                          DTOutput("qualitative_results_table"),
                          hr(),
                          h4("Summary Statistics"),
                          DTOutput("qualitative_stats_table"),
                          hr(),
                          h4("Descriptive Statistics"),
                          verbatimTextOutput("qual_descriptive_stats"),
                          hr(),
                          h4("ANOVA Results"),
                          verbatimTextOutput("qual_anova_results"),
                          hr(),
                          h4("Post-hoc Comparison"),
                          verbatimTextOutput("qual_posthoc_results"),
                          br(),
                          h4("Distribution Plot"),
                          plotOutput("plot_qual_boxplot", height = "350px")
                 ),
                 
                 
                
        )
      )
  )
)
  


# ===== SERVER =====
server <- function(input, output, session) {
  
  output$enzyme_info_display1 <- renderText(paste("Enzyme Type:", input$enzyme_type_nav))
  output$enzyme_product_display <- renderText(paste("Product:", enzyme_config[[input$enzyme_type_nav]]$standard_product))
  output$enzyme_wavelength_display <- renderText(paste("Wavelength:", enzyme_config[[input$enzyme_type_nav]]$standard_wavelength))
  
  observeEvent(input$show_protocol, {
    showModal(modalDialog(
      title = paste(input$enzyme_type_nav, "- Protocol & Reaction Parameters"),
      size = "l",
      HTML(paste(
        "<h4>📋 Enzyme Information:</h4>",
        "<p><strong>Enzyme:</strong> ", input$enzyme_type_nav, "</p>",
        "<p><strong>Product:</strong> ", enzyme_config[[input$enzyme_type_nav]]$standard_product, "</p>",
        "<p><strong>Wavelength:</strong> ", enzyme_config[[input$enzyme_type_nav]]$standard_wavelength, "</p>",
        "<hr>",
        "<h4>⚙️ Current Reaction Parameters:</h4>",
        "<p><strong>Reaction Volume:</strong> ", input$reaction_volume_user, " mL</p>",
        "<p><strong>Reaction Time:</strong> ", input$reaction_time_user, " minutes</p>",
        "<hr>",
        "<h4>📖 Protocol Details:</h4>",
        "<p style='background-color: #f0f0f0; padding: 15px; border-radius: 5px;'>",
        
        if(input$enzyme_type_nav == 'Cellulase') {
          "Cellulase Assay:<br><br>
<b>Principle:</b> Cellulase hydrolyses cellulose releasing reducing sugars which react with DNS reagent to produce a colored complex measured at 540 nm.<br><br>

<b>Substrate:</b> 1% Carboxymethylcellulose (CMC)<br>
<b>Buffer:</b> 50 mM citrate buffer (pH 5.0)<br><br>

<b>Procedure:</b><br>
1. Mix 1 mL substrate + 1 mL enzyme extract<br>
2. Incubate at 55°C for 15 min<br>
3. Add 2 mL DNS reagent<br>
4. Boil for 5 min<br>
5. Cool and measure absorbance at 540 nm<br><br>

<b>Calculation:</b><br>
Activity (U/mL) = µmol glucose released per minute per mL enzyme"
        } 
        else if(input$enzyme_type_nav == 'Lipase') {
          "Lipase Assay:<br><br>

<b>Principle:</b> Lipase hydrolyses p-nitrophenyl butyrate (PNPB) releasing p-nitrophenol measured at 405 nm.<br><br>

<b>Substrate:</b> p-Nitrophenyl butyrate (PNPB)<br>
<b>Buffer:</b> Phosphate buffer (pH 7.0–8.0)<br><br>

<b>Procedure:</b><br>
1. Mix enzyme extract with PNPB substrate<br>
2. Incubate at 37°C for 10–15 min<br>
3. Measure absorbance at 405 nm<br><br>

<b>Calculation:</b><br>
Activity (U/mL) = µmol p-nitrophenol released per minute per mL enzyme"
        } 
        else if(input$enzyme_type_nav == 'Pectinase') {
          "Pectinase Assay:<br><br>

<b>Principle:</b> Pectinase hydrolyses pectin releasing galacturonic acid measured using DNS reagent at 540 nm.<br><br>

<b>Substrate:</b> 1% Pectin<br>
<b>Buffer:</b> 50 mM Citrate buffer (pH 5.0)<br><br>

<b>Procedure:</b><br>
1. Mix enzyme extract with pectin solution<br>
2. Incubate at 50°C for 15 min<br>
3. Add DNS reagent<br>
4. Boil for 5 min<br>
5. Measure absorbance at 540 nm<br><br>

<b>Calculation:</b><br>
Activity (U/mL) = µmol galacturonic acid released per minute per mL enzyme"
        } 
        else if(input$enzyme_type_nav == 'Hemicellulase') {
          "Hemicellulase Assay:<br><br>

<b>Principle:</b> Hemicellulase hydrolyses xylan releasing xylose detected using DNS reagent at 540 nm.<br><br>

<b>Substrate:</b> 1% Xylan<br>
<b>Buffer:</b> 50 mM Citrate buffer (pH 5.0)<br><br>

<b>Procedure:</b><br>
1. Mix enzyme extract with xylan substrate<br>
2. Incubate at 50–55°C for 15 min<br>
3. Add DNS reagent<br>
4. Boil for 5 min<br>
5. Measure absorbance at 540 nm<br><br>

<b>Calculation:</b><br>
Activity (U/mL) = µmol xylose released per minute per mL enzyme"
        } else if(input$enzyme_type_nav == 'Invertase') {
          "Invertase Assay:<br><br>

<b>Principle:</b> Invertase hydrolyses sucrose into glucose and fructose detected using DNS reagent at 540 nm.<br><br>

<b>Substrate:</b> Sucrose solution<br>
<b>Buffer:</b> Citrate buffer (pH 4.5–5.0)<br><br>

<b>Procedure:</b><br>
1. Mix enzyme extract with sucrose substrate<br>
2. Incubate at 50°C for 15 min<br>
3. Add DNS reagent<br>
4. Boil for 5 min<br>
5. Measure absorbance at 540 nm<br><br>

<b>Calculation:</b><br>
Activity (U/mL) = µmol glucose released per minute per mL enzyme"
        } else if(input$enzyme_type_nav == 'Protease') {
          "Protease Assay:<br><br>

<b>Principle:</b> Protease hydrolyses casein releasing tyrosine which is measured spectrophotometrically at 280 nm.<br><br>

<b>Substrate:</b> Casein<br>
<b>Buffer:</b> Phosphate buffer (pH 7.5)<br><br>

<b>Procedure:</b><br>
1. Mix enzyme extract with casein solution<br>
2. Incubate at 37°C for 10–20 min<br>
3. Stop reaction using TCA<br>
4. Centrifuge and collect supernatant<br>
5. Measure absorbance at 280 nm<br><br>

<b>Calculation:</b><br>
Activity (U/mL) = µmol tyrosine released per minute per mL enzyme"
        },
        
        "</p>",
        "<br><br>",
        "<a href='https://github.com/aruneshkpandit45/EnzymeLyzer-Pro/blob/main/protocols/full_protocol.md' target='_blank' style='color:#2980b9; font-weight:bold;'>📄 View Full Protocol</a>",
        sep = "\n"
      )),
      easyClose = TRUE,
      footer = modalButton("Close")
    ))
  })
  
  
  protein_model <- reactiveVal(NULL)
  protein_results <- reactiveVal(NULL)
  enzyme_model <- reactiveVal(NULL)
  enzyme_activity_results <- reactiveVal(NULL)
  product_concentration_results <- reactiveVal(NULL)
  specific_activity_results <- reactiveVal(NULL)
  qualitative_results <- reactiveVal(NULL)
  
  
  output$dl_protein_standards_template <- downloadHandler(
    filename = "bradford_standards.csv",
    content = function(file) {
      df <- data.frame(
        Concentration_µg_mL = c(0, 0, 0, 50, 50, 50, 100, 100, 100, 200, 200, 200, 500, 500, 500),
        Replicate = c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3),
        Absorbance_595nm = c(0.051, 0.053, 0.052, 0.143, 0.147, 0.145, 0.238, 0.242, 0.240, 0.333, 0.337, 0.335, 0.523, 0.527, 0.525)
      )
      write.csv(df, file, row.names = FALSE)
    }
  )
  
  output$dl_protein_samples_template <- downloadHandler(
    filename = "protein_samples.csv",
    content = function(file) {
      df <- data.frame(
        Sample_ID = c("P1", "P1", "P1", "P2", "P2", "P2", "P3", "P3", "P3"),
        Microorganism = c("Org_A", "Org_A", "Org_A", "Org_B", "Org_B", "Org_B", "Org_C", "Org_C", "Org_C"),
        Replicate = c(1, 2, 3, 1, 2, 3, 1, 2, 3),
        Absorbance_595nm = c(0.145, 0.152, 0.148, 0.238, 0.245, 0.240, 0.332, 0.340, 0.336)
      )
      write.csv(df, file, row.names = FALSE)
    }
  )
  
  protein_standards <- reactive({
    req(input$protein_standards_file)
    read.csv(input$protein_standards_file$datapath, stringsAsFactors = FALSE)
  })
  
  observe({
    req(protein_standards())
    model <- lm(Absorbance_595nm ~ Concentration_µg_mL, data = protein_standards())
    protein_model(model)
  })
  
  output$protein_calibration_plot <- renderPlot({
    req(protein_standards(), protein_model())
    model <- protein_model()
    conc_range <- seq(0, max(protein_standards()$Concentration_µg_mL), length.out = 100)
    pred_df <- data.frame(Concentration_µg_mL = conc_range)
    pred_df$Absorbance_595nm <- predict(model, newdata = pred_df)
    
    ggplot(protein_standards(), aes(x = Concentration_µg_mL, y = Absorbance_595nm)) +
      geom_point(size = 4, color = "darkblue", alpha = 0.8) +
      geom_line(data = pred_df, color = "red", size = 1, linetype = "dashed") +
      theme_minimal(base_size = 12) +
      labs(title = "Bradford Standard Curve", x = "BSA (µg/mL)", y = "Absorbance (595 nm)", 
           subtitle = paste("R² =", round(summary(model)$r.squared, 4)))
  })
  
  output$protein_calib_eq <- renderPrint({
    req(protein_model())
    model <- protein_model()
    coef_val <- coefficients(model)
    cat("BRADFORD EQUATION\n")
    cat("==================\n\n")
    cat("Absorbance =", round(coef_val[1], 6), "+", round(coef_val[2], 6), "× Protein_µg_mL\n\n")
    cat("R² =", round(summary(model)$r.squared, 4), "\n\n")
    cat("For each sample:\nProtein_mg_mL = [(Absorbance -", round(coef_val[1], 6), ") /", round(coef_val[2], 6), "] / 1000\n")
  })
  
  observeEvent(input$calc_protein, {
    req(input$protein_samples_file, protein_model())
    samples <- read.csv(input$protein_samples_file$datapath, stringsAsFactors = FALSE)
    model <- protein_model()
    coef_val <- coefficients(model)
    samples$Protein_µg_mL <- (samples$Absorbance_595nm - coef_val[1]) / coef_val[2]
    samples$Protein_mg_mL <- samples$Protein_µg_mL / 1000
    protein_results(samples)
    showNotification("✓ Protein calculated!", type = "message", duration = 2)
  })
  
  output$protein_results_table <- renderDT({
    req(protein_results())
    datatable(protein_results(), options = list(pageLength = 20, scrollX = TRUE)) %>%
      formatRound(columns = which(sapply(protein_results(), is.numeric)), digits = 4)
  })
  
  output$protein_stats_table <- renderDT({
    req(protein_results())
    stats <- protein_results() %>%
      group_by(Microorganism) %>%
      summarise(N = n(), Mean_mg_mL = mean(Protein_mg_mL, na.rm = TRUE), 
                SD = sd(Protein_mg_mL, na.rm = TRUE), SE = SD/sqrt(N), 
                CV_Percent = (SD/Mean_mg_mL)*100, .groups = "drop")
    datatable(stats) %>% formatRound(columns = 2:5, digits = 4)
  })
  
  output$dl_protein_results <- downloadHandler(
    filename = function() paste0("protein_", Sys.Date(), ".csv"),
    content = function(file) {
      req(protein_results())
      write.csv(protein_results(), file, row.names = FALSE)
    }
  )
  
  # ===== ENZYME MODULE =====
  
  output$dl_enzyme_template <- downloadHandler(
    filename = function() paste0(tolower(input$enzyme_type_nav), "_standards.csv"),
    content = function(file) {
      if(input$enzyme_type_nav == "Lipase") {
        df <- data.frame(Concentration_µM = c(0, 0, 0, 10, 10, 10, 25, 25, 25, 50, 50, 50, 100, 100, 100),
                         Replicate = c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3),
                         Absorbance = c(0.049, 0.051, 0.050, 0.143, 0.147, 0.145, 0.283, 0.287, 0.285, 0.518, 0.522, 0.520, 0.948, 0.952, 0.950))
      } else {
        df <- data.frame(Concentration_mg_mL = c(0, 0, 0, 0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 2.0, 2.0, 2.0, 5.0, 5.0, 5.0),
                         Replicate = c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3),
                         Absorbance = c(0.049, 0.051, 0.050, 0.143, 0.147, 0.145, 0.238, 0.242, 0.240, 0.433, 0.437, 0.435, 0.918, 0.922, 0.920))
      }
      write.csv(df, file, row.names = FALSE)
    }
  )
  
  output$dl_enzyme_assay_template <- downloadHandler(
    filename = "enzyme_assay.csv",
    content = function(file) {
      df <- data.frame(Sample_ID = c("E1", "E1", "E1", "E2", "E2", "E2", "E3", "E3", "E3"),
                       Microorganism = c("Org_A", "Org_A", "Org_A", "Org_B", "Org_B", "Org_B", "Org_C", "Org_C", "Org_C"),
                       Replicate = c(1, 2, 3, 1, 2, 3, 1, 2, 3),
                       Absorbance = c(0.450, 0.465, 0.455, 0.380, 0.395, 0.385, 0.520, 0.535, 0.528),
                       Blank_Absorbance = rep(0.050, 9))
      write.csv(df, file, row.names = FALSE)
    }
  )
  
  enzyme_standards <- reactive({
    req(input$enzyme_standards_file)
    read.csv(input$enzyme_standards_file$datapath, stringsAsFactors = FALSE)
  })
  
  observe({
    req(enzyme_standards())
    colnames_std <- names(enzyme_standards())
    model <- lm(as.formula(paste(colnames_std[3], "~", colnames_std[1])), data = enzyme_standards())
    enzyme_model(model)
  })
  
  output$enzyme_calibration_plot <- renderPlot({
    req(enzyme_standards(), enzyme_model())
    model <- enzyme_model()
    data <- enzyme_standards()
    colnames_std <- names(data)
    conc_range <- seq(min(data[[1]]), max(data[[1]]), length.out = 100)
    pred_df <- data.frame(conc_range)
    names(pred_df)[1] <- colnames_std[1]
    pred_df[[colnames_std[3]]] <- predict(model, newdata = pred_df)
    
    ggplot(data, aes_string(x = colnames_std[1], y = colnames_std[3])) +
      geom_point(size = 4, color = "darkgreen", alpha = 0.8) +
      geom_line(data = pred_df, color = "red", size = 1, linetype = "dashed") +
      theme_minimal(base_size = 12) +
      labs(title = paste(input$enzyme_type_nav, "Standard Curve"), 
           subtitle = paste("R² =", round(summary(model)$r.squared, 4)))
  })
  
  output$enzyme_calib_eq <- renderPrint({
    req(enzyme_model())
    model <- enzyme_model()
    data <- enzyme_standards()
    colnames_std <- names(data)
    coef_val <- coefficients(model)
    cat(toupper(input$enzyme_type_nav), "EQUATION\n")
    cat(paste(rep("=", 35), collapse = ""), "\n\n")
    cat(colnames_std[3], "=", round(coef_val[1], 6), "+", round(coef_val[2], 6), "×", colnames_std[1], "\n\n")
    cat("R² =", round(summary(model)$r.squared, 4), "\n\n")
    cat("For each sample:\n1. Corrected_Abs = Raw_Abs - Blank\n2. Product = (Corrected_Abs -", round(coef_val[1], 6), ") /", round(coef_val[2], 6), "\n3. Activity = Product / Reaction_Time\n")
  })
  
  observeEvent(input$calc_enzyme, {
    req(input$enzyme_assay_file, enzyme_model())
    enzyme_data <- read.csv(input$enzyme_assay_file$datapath, stringsAsFactors = FALSE)
    model <- enzyme_model()
    std_data <- enzyme_standards()
    std_colnames <- names(std_data)
    coef_val <- coefficients(model)
    enzyme_conf <- enzyme_config[[input$enzyme_type_nav]]
    
    enzyme_data$Corrected_Absorbance <- enzyme_data$Absorbance - enzyme_data$Blank_Absorbance
    enzyme_data$Product_Conc <- (enzyme_data$Corrected_Absorbance - coef_val[1]) / coef_val[2]
    if(std_colnames == "Concentration_µg_mL") {
      enzyme_data$Product_mol <- enzyme_data$Product_Conc * 1000 / enzyme_conf$molar_mass
    } else {
      enzyme_data$Product_mol <- enzyme_data$Product_Conc
    }
    
    
    enzyme_data$Enzyme_Activity_U_mL <- (enzyme_data$Product_mol / input$reaction_time_user) / input$reaction_volume_user
    
    
    enzyme_activity_results(enzyme_data)
    product_concentration_results(enzyme_data)
    showNotification(paste("✓ Enzyme activity calculated! (Volume:", input$reaction_volume_user, "mL, Time:", input$reaction_time_user, "min)"), type = "message", duration = 3)
    
    
    output$enzyme_activity_table <- renderDT({
      req(enzyme_activity_results())
      display_cols <- c("Sample_ID", "Microorganism", "Replicate", "Absorbance", "Blank_Absorbance", "Corrected_Absorbance", "Product_µmol", "Enzyme_Activity_U_mL")
      datatable(enzyme_activity_results()[, display_cols], options = list(pageLength = 20, scrollX = TRUE)) %>%
        formatRound(columns = which(sapply(enzyme_activity_results()[, display_cols], is.numeric)), digits = 4)
    })
    
    output$enzyme_activity_stats_table <- renderDT({
      req(enzyme_activity_results())
      stats <- enzyme_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean = mean(Enzyme_Activity_U_mL, na.rm = TRUE), 
                  SD = sd(Enzyme_Activity_U_mL, na.rm = TRUE), SE = SD/sqrt(N), 
                  CV_Percent = (SD/Mean)*100, .groups = "drop")
      datatable(stats) %>% formatRound(columns = 2:5, digits = 4)
    })
    
    output$dl_enzyme_activity <- downloadHandler(
      filename = function() paste0("enzyme_", input$enzyme_type_nav, "_", Sys.Date(), ".csv"),
      content = function(file) {
        req(enzyme_activity_results())
        write.csv(enzyme_activity_results(), file, row.names = FALSE)
      }
    )
    
    # ===== PRODUCT CONCENTRATION MODULE =====
    
    output$product_concentration_table <- renderDT({
      req(product_concentration_results())
      display_cols <- c("Sample_ID", "Microorganism", "Replicate", "Product_Conc", "Product_µmol")
      datatable(product_concentration_results()[, display_cols], options = list(pageLength = 20, scrollX = TRUE)) %>%
        formatRound(columns = which(sapply(product_concentration_results()[, display_cols], is.numeric)), digits = 4)
    })
    
    output$product_concentration_stats_table <- renderDT({
      req(product_concentration_results())
      stats <- product_concentration_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean_Product_µmol = mean(Product_µmol, na.rm = TRUE), 
                  SD = sd(Product_µmol, na.rm = TRUE), SE = SD/sqrt(N), 
                  CV_Percent = (SD/Mean_Product_µmol)*100, .groups = "drop")
      datatable(stats) %>% formatRound(columns = 2:5, digits = 4)
    })
    
    # ===== SPECIFIC ACTIVITY MODULE =====
    
    observeEvent(input$calc_specific, {
      req(input$protein_for_specific, input$enzyme_for_specific)
      protein_data <- read.csv(input$protein_for_specific$datapath, stringsAsFactors = FALSE)
      enzyme_data <- read.csv(input$enzyme_for_specific$datapath, stringsAsFactors = FALSE)
      
      merged <- merge(enzyme_data, protein_data[, c("Sample_ID", "Replicate", "Protein_mg_mL")],
                      by = c("Sample_ID", "Replicate"), all.x = TRUE)
      
      merged$Specific_Activity_U_mg <- merged$Enzyme_Activity_U_mL / merged$Protein_mg_mL
      
      specific_activity_results(merged)
      showNotification("✓ Specific activity calculated!", type = "message", duration = 3)
    })
    
    output$specific_activity_table <- renderDT({
      req(specific_activity_results())
      display_cols <- c("Sample_ID", "Microorganism", "Replicate", "Protein_mg_mL", "Enzyme_Activity_U_mL", "Specific_Activity_U_mg")
      datatable(specific_activity_results()[, display_cols], options = list(pageLength = 20, scrollX = TRUE)) %>%
        formatRound(columns = which(sapply(specific_activity_results()[, display_cols], is.numeric)), digits = 4)
    })
    
    output$specific_activity_stats_table <- renderDT({
      req(specific_activity_results())
      stats <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), 
                  SD = sd(Specific_Activity_U_mg, na.rm = TRUE), SE = SD/sqrt(N), 
                  CV_Percent = (SD/Mean)*100, .groups = "drop")
      datatable(stats) %>% formatRound(columns = 2:5, digits = 4)
    })
    
    output$dl_specific_activity <- downloadHandler(
      filename = function() paste0("specific_activity_", Sys.Date(), ".csv"),
      content = function(file) {
        req(specific_activity_results())
        write.csv(specific_activity_results(), file, row.names = FALSE)
      }
    )
    
    # ===== REPLICATION ANALYSIS MODULE =====
    
    output$protein_replication_table <- renderDT({
      req(protein_results())
      datatable(protein_results(), options = list(pageLength = 20, scrollX = TRUE)) %>%
        formatRound(columns = which(sapply(protein_results(), is.numeric)), digits = 4)
    })
    
    output$enzyme_replication_table <- renderDT({
      req(enzyme_activity_results())
      display_cols <- c("Sample_ID", "Microorganism", "Replicate", "Corrected_Absorbance", "Product_µmol", "Enzyme_Activity_U_mL")
      datatable(enzyme_activity_results()[, display_cols], options = list(pageLength = 20, scrollX = TRUE)) %>%
        formatRound(columns = which(sapply(enzyme_activity_results()[, display_cols], is.numeric)), digits = 4)
    })
    
    output$specific_replication_table <- renderDT({
      req(specific_activity_results())
      summary_rep <- specific_activity_results() %>%
        group_by(Microorganism, Replicate) %>%
        summarise(Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), .groups = "drop") %>%
        pivot_wider(names_from = Replicate, values_from = Mean, names_prefix = "Rep_")
      
      summary_rep$Mean_All <- rowMeans(summary_rep[, -1], na.rm = TRUE)
      summary_rep$SD <- apply(summary_rep[, -1], 1, sd, na.rm = TRUE)
      summary_rep$CV_Percent <- (summary_rep$SD / summary_rep$Mean_All) * 100
      
      datatable(summary_rep) %>% formatRound(columns = which(sapply(summary_rep, is.numeric)), digits = 4)
    })
    
    output$replication_quality_metrics <- renderPrint({
      req(specific_activity_results())
      stats <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), 
                  SD = sd(Specific_Activity_U_mg, na.rm = TRUE), 
                  CV_Percent = (SD/Mean)*100, .groups = "drop")
      
      cat("QUALITY CONTROL METRICS\n")
      cat("="*50, "\n\n")
      cat("Standards: <5% EXCELLENT, 5-10% GOOD, 10-20% ACCEPTABLE, >20% POOR\n\n")
      for(i in 1:nrow(stats)) {
        cv <- stats$CV_Percent[i]
        quality <- if(cv < 5) "EXCELLENT" else if(cv < 10) "GOOD" else if(cv < 20) "ACCEPTABLE" else "POOR"
        cat(sprintf("%-20s CV=%5.2f%%  %s\n", stats$Microorganism[i], cv, quality))
      }
    })
    
    # ===== VISUALIZATION MODULE =====
    
    get_tukey_letters <- function(data) {
      if(n_distinct(data$Microorganism) < 2) return(NULL)
      tryCatch({
        model <- aov(Specific_Activity_U_mg ~ Microorganism, data = data)
        tukey_result <- TukeyHSD(model)
        orgs <- unique(data$Microorganism)
        n_orgs <- length(orgs)
        letters <- rep("a", n_orgs)
        names(letters) <- orgs
        
        for(i in 1:n_orgs) {
          for(j in (i+1):n_orgs) {
            comp_idx <- paste0(orgs[j], "-", orgs[i])
            if(comp_idx %in% rownames(tukey_result$Microorganism)) {
              p_val <- tukey_result$Microorganism[comp_idx, "p adj"]
              if(p_val < 0.05) {
                if(letters[i] == letters[j]) {
                  letters[j] <- intToUtf8(utf8ToInt(letters[j]) + 1)
                }
              }
            }
          }
        }
        return(data.frame(Microorganism = names(letters), letter = letters, stringsAsFactors = FALSE))
      }, error = function(e) {
        return(NULL)
      })
    }
    
    output$plot_specific_activity <- renderPlot({
      req(specific_activity_results())
      summary_data <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), 
                  SE = sd(Specific_Activity_U_mg, na.rm = TRUE) / sqrt(n()), .groups = "drop")
      
      ggplot(summary_data, aes(x = Microorganism, y = Mean, fill = Microorganism)) +
        geom_bar(stat = "identity", color = "black", alpha = 0.8, width = 0.7) +
        geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE), width = 0.25, size = 1) +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Mean Specific Activity ± SE", x = "Microorganism", y = "U/mg") +
        scale_fill_brewer(palette = "Set2")
    })
    
    output$plot_all_replicates <- renderPlot({
      req(specific_activity_results())
      ggplot(specific_activity_results(), aes(x = Microorganism, y = Specific_Activity_U_mg, 
                                              color = as.factor(Replicate))) +
        geom_point(size = 4, alpha = 0.8, position = position_dodge(width = 0.3)) +
        theme_minimal(base_size = 13) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "All Replicate Values", x = "Microorganism", y = "U/mg", color = "Replicate") +
        scale_color_manual(values = c("1" = "#FF6B6B", "2" = "#4ECDC4", "3" = "#45B7D1"))
    })
    
    output$plot_boxplot_activity <- renderPlot({
      req(specific_activity_results())
      ggplot(specific_activity_results(), aes(x = Microorganism, y = Specific_Activity_U_mg, 
                                              fill = Microorganism)) +
        geom_boxplot(alpha = 0.7) +
        geom_jitter(width = 0.2, alpha = 0.5, size = 2) +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Distribution with Replicates", x = "Microorganism", y = "U/mg") +
        scale_fill_brewer(palette = "Set1")
    })
    
    output$plot_barplot_activity <- renderPlot({
      req(specific_activity_results())
      summary_data <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), 
                  SD = sd(Specific_Activity_U_mg, na.rm = TRUE), 
                  SE = SD/sqrt(n()),
                  CI_Lower = Mean - 1.96*SE, CI_Upper = Mean + 1.96*SE, .groups = "drop")
      
      ggplot(summary_data, aes(x = Microorganism, y = Mean, fill = Microorganism)) +
        geom_bar(stat = "identity", color = "black", alpha = 0.8, width = 0.7) +
        geom_errorbar(aes(ymin = CI_Lower, ymax = CI_Upper), width = 0.25, size = 1.2) +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Mean with 95% CI", x = "Microorganism", y = "U/mg") +
        scale_fill_brewer(palette = "Set2")
    })
    
    output$plot_barplot_grouped <- renderPlot({
      req(specific_activity_results())
      
      summary_data <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), 
                  SD = sd(Specific_Activity_U_mg, na.rm = TRUE), 
                  SE = SD/sqrt(n()),
                  CI_Lower = Mean - 1.96*SE, CI_Upper = Mean + 1.96*SE, .groups = "drop")
      
      letter_groups <- get_tukey_letters(specific_activity_results())
      
      if(!is.null(letter_groups)) {
        summary_data <- merge(summary_data, letter_groups, by = "Microorganism")
      } else {
        summary_data$letter <- ""
      }
      
      max_y <- max(summary_data$CI_Upper, na.rm = TRUE)
      y_limit <- max_y * 1.15
      
      ggplot(summary_data, aes(x = Microorganism, y = Mean, fill = Microorganism)) +
        geom_bar(stat = "identity", color = "black", alpha = 0.8, width = 0.7) +
        geom_errorbar(aes(ymin = CI_Lower, ymax = CI_Upper), width = 0.25, size = 1.2) +
        geom_text(aes(y = CI_Upper + max_y*0.07, label = letter), size = 6, fontface = "bold") +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Tukey HSD Grouping", x = "Microorganism", y = "U/mg", 
             caption = "Same letter = not significant (p > 0.05)") +
        scale_fill_brewer(palette = "Set2") +
        ylim(0, y_limit)
    })
    
    output$plot_cv <- renderPlot({
      req(specific_activity_results())
      cv_data <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(CV = (sd(Specific_Activity_U_mg, na.rm = TRUE) / mean(Specific_Activity_U_mg, na.rm = TRUE)) * 100, .groups = "drop")
      
      ggplot(cv_data, aes(x = Microorganism, y = CV, fill = Microorganism)) +
        geom_bar(stat = "identity", color = "black", alpha = 0.8, width = 0.7) +
        geom_hline(yintercept = c(5, 10, 20), linetype = "dashed", color = c("green", "orange", "red"), size = 1) +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "CV% Quality", x = "Microorganism", y = "CV (%)") +
        scale_fill_brewer(palette = "Spectral")
    })
    
    # ===== STATISTICS =====
    
    output$quant_descriptive_stats <- renderPrint({
      req(specific_activity_results())
      cat("DESCRIPTIVE STATISTICS\n")
      stats <- specific_activity_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean = mean(Specific_Activity_U_mg, na.rm = TRUE), 
                  SD = sd(Specific_Activity_U_mg, na.rm = TRUE), 
                  SE = SD/sqrt(N), CV_Percent = (SD/Mean)*100, 
                  Min = min(Specific_Activity_U_mg, na.rm = TRUE), 
                  Max = max(Specific_Activity_U_mg, na.rm = TRUE), .groups = "drop")
      print(stats, n = Inf)
    })
    
    output$quant_anova_results <- renderPrint({
      req(specific_activity_results())
      if(n_distinct(specific_activity_results()$Microorganism) < 2) {
        cat("Insufficient groups for ANOVA\n")
        return()
      }
      model <- aov(Specific_Activity_U_mg ~ Microorganism, data = specific_activity_results())
      cat("ONE-WAY ANOVA\n\n")
      print(summary(model))
    })
    
    output$quant_posthoc_results <- renderPrint({
      req(specific_activity_results())
      if(n_distinct(specific_activity_results()$Microorganism) < 2) return()
      model <- aov(Specific_Activity_U_mg ~ Microorganism, data = specific_activity_results())
      cat("TUKEY HSD TEST\n\n")
      print(TukeyHSD(model))
    })
    
    # ===== QUALITATIVE MODULE =====
    
    output$dl_qualitative_template <- downloadHandler(
      filename = "qualitative_zone.csv",
      content = function(file) {
        df <- data.frame(Sample_ID = c("Q1", "Q1", "Q1", "Q2", "Q2", "Q2", "Q3", "Q3", "Q3"),
                         Microorganism = c("Org_A", "Org_A", "Org_A", "Org_B", "Org_B", "Org_B", "Org_C", "Org_C", "Org_C"),
                         Replicate = c(1, 2, 3, 1, 2, 3, 1, 2, 3),
                         Colony_Diameter_mm = c(5.0, 5.2, 5.1, 4.8, 5.1, 4.9, 5.3, 5.0, 5.2),
                         Zone_Diameter_mm = c(15.2, 14.8, 15.0, 12.5, 13.0, 12.7, 18.5, 17.8, 18.2))
        write.csv(df, file, row.names = FALSE)
      }
    )
    
    observeEvent(input$calc_qualitative, {
      req(input$qualitative_data_file)
      qual_data <- read.csv(input$qualitative_data_file$datapath, stringsAsFactors = FALSE)
      qual_data$Enzymatic_Index <- qual_data$Zone_Diameter_mm / qual_data$Colony_Diameter_mm
      qual_data$Activity_Rating <- cut(qual_data$Enzymatic_Index, 
                                       breaks = c(-Inf, 1, 2, 3, 5, Inf),
                                       labels = c("None", "Weak", "Moderate", "Strong", "Very Strong"))
      qualitative_results(qual_data)
      showNotification("✓ Calculated!", type = "message", duration = 2)
    })
    
    output$qualitative_results_table <- renderDT({
      req(qualitative_results())
      display_cols <- c("Sample_ID", "Microorganism", "Replicate", "Colony_Diameter_mm", 
                        "Zone_Diameter_mm", "Enzymatic_Index", "Activity_Rating")
      datatable(qualitative_results()[, display_cols], options = list(pageLength = 20, scrollX = TRUE)) %>%
        formatRound(columns = which(sapply(qualitative_results()[, display_cols], is.numeric)), digits = 3)
    })
    
    output$qualitative_stats_table <- renderDT({
      req(qualitative_results())
      stats <- qualitative_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean_EI = mean(Enzymatic_Index, na.rm = TRUE), 
                  SD = sd(Enzymatic_Index, na.rm = TRUE), SE = SD/sqrt(N), 
                  CV_Percent = (SD/Mean_EI)*100, .groups = "drop")
      datatable(stats) %>% formatRound(columns = 2:5, digits = 3)
    })
    
    output$qual_descriptive_stats <- renderPrint({
      req(qualitative_results())
      cat("DESCRIPTIVE STATISTICS\n")
      stats <- qualitative_results() %>%
        group_by(Microorganism) %>%
        summarise(N = n(), Mean = mean(Enzymatic_Index, na.rm = TRUE), 
                  SD = sd(Enzymatic_Index, na.rm = TRUE), SE = SD/sqrt(N), .groups = "drop")
      print(stats, n = Inf)
    })
    
    output$qual_anova_results <- renderPrint({
      req(qualitative_results())
      if(n_distinct(qualitative_results()$Microorganism) < 2) {
        cat("Insufficient groups\n")
        return()
      }
      model <- aov(Enzymatic_Index ~ Microorganism, data = qualitative_results())
      cat("ONE-WAY ANOVA\n\n")
      print(summary(model))
    })
    
    output$qual_posthoc_results <- renderPrint({
      req(qualitative_results())
      if(n_distinct(qualitative_results()$Microorganism) < 2) return()
      model <- aov(Enzymatic_Index ~ Microorganism, data = qualitative_results())
      cat("TUKEY HSD\n\n")
      print(TukeyHSD(model))
    })
    
    output$plot_qual_boxplot <- renderPlot({
      req(qualitative_results())
      ggplot(qualitative_results(), aes(x = Microorganism, y = Enzymatic_Index, 
                                        fill = Microorganism)) +
        geom_boxplot(alpha = 0.7) +
        geom_jitter(width = 0.2, alpha = 0.5, size = 2) +
        theme_minimal(base_size = 13) +
        theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = "Enzymatic Index", x = "Microorganism", y = "Index") +
        scale_fill_brewer(palette = "Set1")
    })
  }
  )

}
  # ===== LAUNCH =====
   shinyApp(ui = ui, server = server)

