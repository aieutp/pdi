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

options(encoding = 'UTF-8')

server <- function(input, output, session) {
  source('funciones.R', encoding = 'UTF-8')
  source('server/server_dataload.R', local = TRUE)
  source('server/server_pdi_resumen.R', local = TRUE)
  source('server/server_pdi_resultados.R', local = TRUE)
  source('server/server_pdi_protocolos.R', local = TRUE)
  source('server/server_pdi_general.R', local = TRUE)
  
  
  observe({
    query <- parseQueryString(session$clientData$url_search)
    pilar <- as.numeric(query[["pilar"]])

    pilares <- data_pdi_estructura %>%
      filter(PLAN_ID == plan_seleccionado(),
             NODE_TYPE_ID == 'NODO_PILAR') %>%
      distinct(DISPLAY_NAME, ID_PILAR) %>%
      arrange(DISPLAY_NAME) %>%
      select(ID_PILAR) %>%
      pull()
    
    updateSelectInput(session, "select_pilar_gestion", selected = c(pilares)[pilar])
    
    # if(pilar %in% c(1,2,3,4,5)){
    #   updateSelectInput(session, "select_pilar_gestion", selected = c(pilares)[pilar])
    # }

  })

}