library(shiny)
library(shinydashboard)
library(readxl)
library(tidyverse)
library(plotly)
library(leaflet)
library(DT)
library(echarts4r)
library(RJDBC)
# library(xlsx)
library(shinycssloaders)
library(collapsibleTree) 

# Inicializar en FALSE para ambientes productivos
isLocal <- TRUE
options(encoding = 'UTF-8')

# Archivos estáticos importados que conforman la estructura básica de la página. En
# general, no debería ser necesario modificarlos
source("layout/head-meta-SEO.R", local = isLocal)
source("layout/header.R", local = isLocal)
source("layout/navBar.R", local = isLocal)
source("layout/side-bar.R", local = isLocal)
source("layout/footer.R", local = isLocal)
source("layout/footer-imports.R", local = isLocal)
source("layout/modal.R", local = isLocal)
 
# Importación de páginas ligadas al sideBarMenu. Estas páginas se encuentran en la
# carpeta "pages" en la raiz del proyecto.

source("pages/pilares/pdi_resumen.R", local = isLocal)
source("pages/pilares/pdi_resultados.R", local = isLocal)
#source("pages/pilares/pdi_protocolos.R", local = isLocal)
source("pages/pilares/pdi_general.R", local = isLocal)

options(encoding='UTF-8')
options(shiny.autoreload=T)

cat("\n\nreloading...")

ui <- tags$body(
  tags$head(includeHTML(("google-analytics.html"))),

  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"),
  
  HeadMetaSEO,
  div(class="wrapper main-wrapper d-flex align-items-stretch",
    Sidebar,
    div(id="content", class="p-4 p-md-5",
      # Header
      NavBar,

      # Body (Main content)
      div(class="section-content tab-content",
          templatePDI_Resumen,
          templatePDI_Resultados,
          templatePDI_General,
      ),
      Footer,
    )
  ),
  Modal,

  # Footer layout
  FooterImports
)
