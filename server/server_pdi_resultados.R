
brks <- reactive({
  parametros[corte_seleccionado()][[1]]
})

clrs <- c("#DE4B39","#F08325","#F49C13","#6CB754","#3A9970")
clrs_box <- c("red","orange","yellow","green","olive")

output$texto_Nombre <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(NOMBRE)
  p <- paste0(valores)
  
  p
})

output$texto_Objetivo <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_OBJETIVO)
  p <- paste0(valores)
  
  p
})

output$texto_Impulsores <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_IMPULSORES)
  p <- paste0(valores)
  
  p
})

output$texto_Descripcion <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(DESCRIPCION)
  p <- paste0(valores)
  
  p
})

output$texto_Cumplimiento <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_CUMPLIMIENTO)
  p <- paste0(valores)
  
  p
})

output$texto_PilaresImpulsores <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_PILARES_IMPULSORES)
  p <- paste0(valores)
  
  p
})

output$texto_Programas <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_PROGRAMAS)
  p <- paste0(valores)
  
  p
})

output$img_Actores <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(IMG_ACTORES)
  p <- paste0(valores)
  
  p
})

output$img_Pilar <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(IMG)
  p <- paste0(valores)
  
  p
})

output$texto_Proyectos <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_PROYECTOS)
  p <- paste0(valores)
  
  p
})

output$texto_Niveles <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(TEXTO_NIVELES)
  p <- paste0(valores)
  
  p
})

output$texto_DocumentoHTML <- renderText({
  
  valores <-   data_pdi_resumen_sheet %>% 
    filter(CODIGO == pilar_seleccionado()) %>% 
    select(DOCUMENTO_HTML)
  p <- paste0(valores)
  
  p
})

output$valuebox_resultado_nivel_pilares <- renderValueBox({
  valor <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PILAR') %>%
    select(PORC_AVANCE) %>% 
    pull()
  
  valor <- round(valor,2)
  dato <- paste0(valor,"%")
  
  titulo = paste0("Resultados a nivel de Pilar de Gestión ", input$select_anio)
  
  valueBox(
    dato, titulo, icon = icon("user-gear"),
    color = clrs_box[findInterval(valor,brks())+1]
  )
})

output$valuebox_resultado_nivel_programas <- renderValueBox({
  valor <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROGRAMA') %>%
    select(PORC_AVANCE) %>% 
    pull()
  
  valor <- round(valor,2)
  dato <- paste0(valor,"%")
  
  titulo = paste0("Resultados a nivel de Programas ", input$select_anio)
  
  valueBox(
    dato, titulo, icon = icon("gear"),
    color = clrs_box[findInterval(valor,brks())+1]
  )
})

output$valuebox_resultado_nivel_proyectos <- renderValueBox({
  valor <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROYECTO') %>%
    select(PORC_AVANCE) %>% 
    pull()
  
  valor <- round(valor,2)
  dato <- paste0(valor,"%")
  
  titulo = paste0("Resultados a nivel de Proyectos ", input$select_anio)
  
  valueBox(
    dato, titulo, icon = icon("gears"),
    color = clrs_box[findInterval(valor,brks())+1]
  )
})

output$valuebox_resultado_pilar <- renderValueBox({

  valor_pilar <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PILAR') %>%
    select(PORC_AVANCE) %>% 
    pull()
  
  valor_programa <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROGRAMA') %>%
    select(PORC_AVANCE) %>% 
    pull()
  
  valor_proyecto <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROYECTO') %>%
    select(PORC_AVANCE) %>% 
    pull()
  
  valor <- round((valor_pilar*0.3 + valor_programa*0.3 + valor_proyecto*0.4),2)
  dato <- paste0(valor,"%")
  
  titulo = paste0("Cumplimiento del Pilar ", input$select_anio)
  
  valueBox(
    dato, titulo, icon = icon("building-columns"),
    color = clrs_box[findInterval(valor,brks())+1]
  )
})

output$valuebox_resultado_general_pdi <- renderValueBox({

  valor <- avances_tres_niveles %>% 
    filter(PLAN_ID == plan_seleccionado(), NODE_TYPE_ID == "NODO_PILAR") %>% 
    select(PORC_AVANCE) %>% 
    colMeans()
  
  valor <- round(valor,2)
  dato <- paste0(valor,"%")
  
  titulo = paste0("Cumplimiento General de los Pilares del PDI", input$select_anio)
  
  valueBox(
    dato, titulo, icon = icon("users-gear"),
    color = clrs_box[findInterval(valor,brks())+1]
  )
})


output$relacion_eficiencia <- renderEcharts4r({
  
  relacion <-     avances %>%
    select(PARTY_ID,
           DISPLAY_NAME,
           ADVANCE_VALUE,
           MILESTONE_VALUE,
           PORC_AVANCE_INDICADOR) %>%
    left_join(data_pdi_estructura %>%
                select(PARTY_ID,
                       ID_PILAR,
                       NODE_TYPE_ID,
                       PROGRAMA, PROYECTO,
                       PLAN_ID),
              by = "PARTY_ID") %>%
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROYECTO') %>%
    select(PARTY_ID, PROGRAMA, PROYECTO, PLAN_ID, PARTY_ID,
           INDICADOR = DISPLAY_NAME,
           AVANCE = ADVANCE_VALUE,
           META = MILESTONE_VALUE,
           PORCENTAJE_AVANCE = PORC_AVANCE_INDICADOR, ID_PILAR) %>%
    arrange(PROYECTO) %>%
    left_join(avances_proyectos, by = 'PARTY_ID') %>%
    select(PROYECTO, EFICACIA = PORC_AVANCE, PLAN_ID, PARTY_ID, ID_PILAR) %>%
    distinct() %>% 
    left_join(data_pdi_presupuesto_sheet %>% filter(PLAN_ID == plan_seleccionado(), ID_PILAR == input$select_pilar_gestion)) %>% 
    mutate(APROPIACION_DEFINITIVA = parse_number(APROPIACION_DEFINITIVA),
           COMPROMISOS = parse_number(COMPROMISOS),
           EFICIENCIA = 100*COMPROMISOS/APROPIACION_DEFINITIVA) %>% 
    select(PROYECTO, EFICIENCIA, EFICACIA) %>% 
    mutate(EFECTIVIDAD = round(.20*EFICIENCIA + .80*EFICACIA,2)) %>% 
    mutate(EFICIENCIA = round(EFICIENCIA,2)) %>% 
    mutate(EFICACIA = round(EFICACIA,2)) %>% 
    select(EFICIENCIA) %>% 
    colMeans(na.rm = TRUE) 
  
  subtitulo = paste("Resultado de avance presupuestal")
  
  e_charts() %>% 
    e_gauge(round(as.double(relacion),2), "Porcentaje", min = 0, max = 100) %>%
    e_title("Eficiencia", subtext = subtitulo,x = "center")
  
})

output$relacion_eficacia <- renderEcharts4r({
  
  relacion <- avances %>%
    select(PARTY_ID,
           DISPLAY_NAME,
           ADVANCE_VALUE,
           MILESTONE_VALUE,
           PORC_AVANCE_INDICADOR) %>%
    left_join(data_pdi_estructura %>%
                select(PARTY_ID,
                       ID_PILAR,
                       NODE_TYPE_ID,
                       PROGRAMA, PROYECTO,
                       PLAN_ID),
              by = "PARTY_ID") %>%
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROYECTO') %>%
    select(PARTY_ID, PROGRAMA, PROYECTO,
           INDICADOR = DISPLAY_NAME,
           AVANCE = ADVANCE_VALUE,
           META = MILESTONE_VALUE,
           PORCENTAJE_AVANCE = PORC_AVANCE_INDICADOR) %>%
    arrange(PROYECTO) %>%
    left_join(avances_proyectos, by = 'PARTY_ID') %>%
    select(PROYECTO, EFICACIA = PORC_AVANCE) %>%
    distinct() %>% 
    select(EFICACIA) %>% 
    colMeans(na.rm = TRUE) 
  
  subtitulo = paste("Resultado de avance físico")
  
  e_charts() %>% 
    e_gauge(round(as.double(relacion),2), "Porcentaje", min = 0, max = 100) %>%
    e_title( "Eficicacia:",  subtext = subtitulo,x = "center")
  
})

output$relacion_efectividad <- renderEcharts4r({
  
  relacion <- avances %>%
    select(PARTY_ID,
           DISPLAY_NAME,
           ADVANCE_VALUE,
           MILESTONE_VALUE,
           PORC_AVANCE_INDICADOR) %>%
    left_join(data_pdi_estructura %>%
                select(PARTY_ID,
                       ID_PILAR,
                       NODE_TYPE_ID,
                       PROGRAMA, PROYECTO,
                       PLAN_ID),
              by = "PARTY_ID") %>%
    filter(PLAN_ID == plan_seleccionado(),
           ID_PILAR == input$select_pilar_gestion,
           NODE_TYPE_ID == 'NODO_PROYECTO') %>%
    select(PARTY_ID, PROGRAMA, PROYECTO, PLAN_ID, PARTY_ID,
           INDICADOR = DISPLAY_NAME,
           AVANCE = ADVANCE_VALUE,
           META = MILESTONE_VALUE,
           PORCENTAJE_AVANCE = PORC_AVANCE_INDICADOR, ID_PILAR) %>%
    arrange(PROYECTO) %>%
    left_join(avances_proyectos, by = 'PARTY_ID') %>%
    select(PROYECTO, EFICACIA = PORC_AVANCE, PLAN_ID, PARTY_ID, ID_PILAR) %>%
    distinct() %>% 
    left_join(data_pdi_presupuesto_sheet %>% filter(PLAN_ID == plan_seleccionado(), ID_PILAR == input$select_pilar_gestion)) %>% 
    mutate(APROPIACION_DEFINITIVA = parse_number(APROPIACION_DEFINITIVA),
           COMPROMISOS = parse_number(COMPROMISOS),
           EFICIENCIA = 100*COMPROMISOS/APROPIACION_DEFINITIVA) %>% 
    select(PROYECTO, EFICIENCIA, EFICACIA) %>% 
    mutate(EFECTIVIDAD = round(.20*EFICIENCIA + .80*EFICACIA,2)) %>% 
    mutate(EFICIENCIA = round(EFICIENCIA,2)) %>% 
    mutate(EFICACIA = round(EFICACIA,2)) %>% 
    select(EFECTIVIDAD) %>% 
    colMeans(na.rm = TRUE)
  
  subtitulo = paste("20% Eficiencia * 80% Eficacia")
  
  e_charts() %>% 
    e_gauge(round(as.double(relacion),2), "Porcentaje", min = 0, max = 100) %>%
    e_title("Efectividad", subtext = subtitulo,x = "center")
  
})

output$tabla_proyectos <- renderDataTable(
  
  datatable(
    
    avances %>%
      select(PARTY_ID,
             DISPLAY_NAME,
             ADVANCE_VALUE,
             MILESTONE_VALUE,
             PORC_AVANCE_INDICADOR) %>%
      left_join(data_pdi_estructura %>%
                  select(PARTY_ID,
                         ID_PILAR,
                         NODE_TYPE_ID,
                         PROGRAMA, PROYECTO,
                         PLAN_ID),
                by = "PARTY_ID") %>%
      filter(PLAN_ID == plan_seleccionado(),
             ID_PILAR == input$select_pilar_gestion,
             NODE_TYPE_ID == 'NODO_PROYECTO') %>%
      select(PARTY_ID, PROGRAMA, PROYECTO, PLAN_ID, PARTY_ID,
             INDICADOR = DISPLAY_NAME,
             AVANCE = ADVANCE_VALUE,
             META = MILESTONE_VALUE,
             PORCENTAJE_AVANCE = PORC_AVANCE_INDICADOR, ID_PILAR) %>%
      arrange(PROYECTO) %>%
      left_join(avances_proyectos, by = 'PARTY_ID') %>%
      select(PROYECTO, EFICACIA = PORC_AVANCE, PLAN_ID, PARTY_ID, ID_PILAR) %>%
      distinct() %>% 
      left_join(data_pdi_presupuesto_sheet %>% filter(PLAN_ID == plan_seleccionado(), ID_PILAR == input$select_pilar_gestion)) %>% 
      mutate(APROPIACION_DEFINITIVA = parse_number(APROPIACION_DEFINITIVA),
             COMPROMISOS = parse_number(COMPROMISOS),
             EFICIENCIA = 100*COMPROMISOS/APROPIACION_DEFINITIVA) %>% 
      select(PROYECTO, EFICIENCIA, EFICACIA) %>% 
      mutate(EFECTIVIDAD = round(.20*EFICIENCIA + .80*EFICACIA,2)) %>% 
      mutate(EFICIENCIA = round(EFICIENCIA,2)) %>% 
      mutate(EFICACIA = round(EFICACIA,2)),
    
    
    extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 15,
      info = FALSE,
      #rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    )
  ) %>%
    formatStyle(c('EFICIENCIA','EFICACIA','EFECTIVIDAD'), backgroundColor = styleInterval(brks(), clrs))  
)


output$tabla_pilares_impulsores <- renderDataTable(
  
  datatable(
    
    avances %>%
      select(PARTY_ID,
             DISPLAY_NAME,
             ADVANCE_VALUE,
             MILESTONE_VALUE,
             PORC_AVANCE_INDICADOR, UUID) %>%
      left_join(data_pdi_estructura %>%
                  select(PARTY_ID,
                         ID_PILAR,
                         NODE_TYPE_ID,
                         PROGRAMA, PROYECTO,
                         PLAN_ID),
                by = "PARTY_ID") %>%
      filter(PLAN_ID == plan_seleccionado(),
             ID_PILAR == input$select_pilar_gestion,
             NODE_TYPE_ID == 'NODO_PILAR') %>%
      select(PARTY_ID,
             INDICADOR = DISPLAY_NAME,
             META = MILESTONE_VALUE,
             AVANCE = ADVANCE_VALUE,
             PORCENTAJE_AVANCE = PORC_AVANCE_INDICADOR, UUID, PLAN_ID, ID_PILAR) %>%
      arrange(PARTY_ID) %>%
      left_join(avances_pilar, by = 'PARTY_ID') %>% 
      left_join(data_pdi_impulsores_sheet %>% filter(PLAN_ID == plan_seleccionado(), ID_PILAR == input$select_pilar_gestion) , by = 'UUID') %>% 
      select(IMPULSOR_ESTRATEGICO = IMPULSOR, INDICADOR, META, AVANCE, PORCENTAJE_AVANCE),
    
    extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 15,
      info = FALSE,
      rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    )
  ) %>%
    formatStyle(c('PORCENTAJE_AVANCE'), backgroundColor = styleInterval(brks(), clrs))
)


output$tabla_pilares_programas <- renderDataTable(
  
  datatable(

    avances %>% 
      select(PARTY_ID,
             DISPLAY_NAME,
             ADVANCE_VALUE,
             MILESTONE_VALUE,
             PORC_AVANCE_INDICADOR) %>% 
      left_join(data_pdi_estructura %>% 
                  select(PARTY_ID, 
                         ID_PILAR,
                         NODE_TYPE_ID,
                         PROGRAMA,
                         PLAN_ID),
                by = "PARTY_ID") %>% 
      filter(PLAN_ID == plan_seleccionado(),
             ID_PILAR == input$select_pilar_gestion,
             NODE_TYPE_ID == 'NODO_PROGRAMA') %>% 
      select(PROGRAMA, 
             INDICADOR = DISPLAY_NAME,
             META = MILESTONE_VALUE,
             AVANCE = ADVANCE_VALUE,
             PORCENTAJE_AVANCE = PORC_AVANCE_INDICADOR) %>% 
      arrange(PROGRAMA),
    extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 20,
      info = FALSE,
      rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    )
  ) %>%
    formatStyle(c('PORCENTAJE_AVANCE'), backgroundColor = styleInterval(brks(), clrs))
)


output$tabla_convenciones <- renderDataTable(
  
  datatable(
    
    data.frame(
      "CUMPLIMIENTO" = c("Bajo", "Medio Bajo", "Medio", "Medio Alto", "Satisfactorio"),
      "CONVENCION" = c(brks(), 100)
    ),

    #extensions = c('Buttons', 'RowGroup'),
    options = list(
      dom='Bfrtip',
      pageLength = 15,
      info = FALSE,
      #rowGroup = list(dataSrc= c(1)),
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'),
      #buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
      pageLength = -1, paging = FALSE, searching = FALSE
    )
  ) %>%
    formatStyle(c('CONVENCION'), backgroundColor = styleInterval(brks(), clrs))  
)
