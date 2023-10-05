output$select_protocolo <- renderUI({
  
  lista_protocolos <- list_control(
    data_pdi_protocolos %>% 
      filter(PILAR == pilar_seleccionado()) %>% 
      mutate(NOMBRE = paste0(CODIGO, " ", NOMBRE)),
    CODIGO,
    NOMBRE
  )
  
  selectInput("select_protocolo",
              "Seleccione el protocolo:",
              choices = lista_protocolos)
  
})

output$valuebox_protocolos_Estado <- renderValueBox({
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(ESTADO)
  p <- paste0(valores)
  
  valor <- p
  
  titulo = paste0("Estado")
  
  valueBox(
    valor, titulo, icon = icon("chalkboard-teacher"),
    color = "olive"
  )
})

output$valuebox_protocolos_Periodicidad <- renderValueBox({
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(PERIODICIDAD)
  p <- paste0(valores)
  
  valor <- p
  
  titulo = paste0("Periodicidad ")
  
  valueBox(
    valor, titulo, icon = icon("user-slash"),
    color ="aqua"
  )
})

output$valuebox_protocolos_Nivel_De_Gestion <- renderValueBox({
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(NIVEL_DE_GESTION)
  p <- paste0(valores)
  
  valor <- p
  
  titulo = paste0("Nivel de Gestión ")
  
  valueBox(
    valor, titulo, icon = icon("user-graduate"),
    color = "purple"
  )
})


output$valuebox_protocolos_unidad <- renderValueBox({
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(UNIDAD)
  p <- paste0(valores)
  
  valor <-p
  
  titulo = paste0("Unidad ")
  
  valueBox(
    valor, titulo, icon = icon("desktop"),
    color = "orange"
  )
})


output$texto_Protocolos_Codigo <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(CODIGO)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Estado <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(ESTADO)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Fecha_Creacion <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(FECHA_CREACION)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Fecha_Ultima_Modificacion <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(FECHA_ULTIMA_MODIFICACION)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Nombre <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(NOMBRE)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Descripcion <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(DESCRIPCION)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Pilar <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(PILAR)
  p <- paste0(valores)
  
  p
})


output$texto_Protocolos_Nivel_De_Gestion <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(NIVEL_DE_GESTION)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Fuente_De_Datos <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(FUENTE_DE_DATOS)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Responsable_Del_Calculo <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(RESPONSABLE_DEL_CALCULO)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Responsable_Gestion <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(RESPONSABLE_GESTION)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Unidad <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(UNIDAD)
  p <- paste0(valores)
  
  p
})


output$texto_Protocolos_Formula <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(FORMULA)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Consideraciones_Calculo <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(CONSIDERACIONES_CALCULO)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Impulsores_Aporta <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(IMPULSORES_APORTA)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Periodicidad <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(PERIODICIDAD)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Glosario <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(GLOSARIO)
  p <- paste0(valores)
  
  p
})

output$texto_Protocolos_Presentacion <- renderText({
  
  valores <-   data_pdi_protocolos %>% 
    filter(CODIGO == input$select_protocolo) %>% 
    select(PRESENTACION)
  p <- paste0(valores)
  
  p
})

output$tabla_protocolos_metadato <- renderDataTable(
  
  datatable(
    
    read_xlsx('data/TB_EXTERNO_PDI_PROTOCOLOS.xlsx', sheet = input$select_protocolo),
    
    extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 15,
      info = FALSE,
      #rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    )
  )# %>%
  #formatStyle(c('PORCENTAJE_CUMPLIMIENTO'), backgroundColor = styleInterval(brks, clrs))    
)


output$tabla_protocolos_reporte_ejemplo <- renderDataTable(
  
  datatable(
    
    read_xlsx('data/TB_EXTERNO_PDI_PROTOCOLOS.xlsx', sheet = paste0(input$select_protocolo,"P")),
    
    extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 15,
      info = FALSE,
      #rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    )
  )# %>%
  #formatStyle(c('PORCENTAJE_CUMPLIMIENTO'), backgroundColor = styleInterval(brks, clrs))    
)

output$tabla_protocolos_control_cambios <- renderDataTable(
  
  datatable(
    data_pdi_protocolos_cambios %>% 
      filter(CODIGO_PROTOCOLO == input$select_protocolo),
    
    extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 15,
      info = FALSE,
      #rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    )
  )# %>%
  #formatStyle(c('PORCENTAJE_CUMPLIMIENTO'), backgroundColor = styleInterval(brks, clrs))    
)