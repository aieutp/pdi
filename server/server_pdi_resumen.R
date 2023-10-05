output$texto_Resumen_Nombre <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(NOMBRE)
  p <- paste0(valores)
  
  p
})

output$texto_Resumen_DocumentoHTML <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(DOCUMENTO_HTML)
  p <- paste0(valores)
  
  p
})

output$texto_Resumen_IMG_ACTORES <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(IMG_ACTORES)
  p <- paste0(valores)
  
  p
})


output$texto_Resumen_PortafolioProyectos_DocumentoHTML <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(PORTAFOLIO_PROYECTOS)
  p <- paste0(valores)
  
  p
})

output$collapsibleTreePDI <- renderCollapsibleTree({

  PDI <- data_pdi_estructura %>%
    filter(PLAN_ID == plan_seleccionado(), ID_PILAR == input$select_pilar_gestion) %>%
    filter(!grepl("IMPULSOR", DISPLAY_NAME)) %>% 
    select(PILAR, PROGRAMA, PROYECTO)

  p <- collapsibleTree(PDI, c("PILAR", "PROGRAMA", "PROYECTO"), collapsed = FALSE, )

  p
})