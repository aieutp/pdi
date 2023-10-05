# PARÁMETROS ####
data_id_plan <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT3p4vO0oJo-efGC4M1eZ4vOgITQ4zf2ac7otuq6fuWtEYD8WsLVho0Aiq0VuYZJwreKYHDgv4l1ieY/pub?gid=561692160&single=true&output=csv")

data_parametros <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT3p4vO0oJo-efGC4M1eZ4vOgITQ4zf2ac7otuq6fuWtEYD8WsLVho0Aiq0VuYZJwreKYHDgv4l1ieY/pub?gid=1702636767&single=true&output=csv")
parametros <- as.list(data_parametros)


id_plan <- data_id_plan %>% 
  mutate(consulta = paste0("'", id_plan, "'"))

plan_seleccionado <- reactive({
  
  id_plan %>% 
    filter(anio == input$select_anio_pilar) %>% 
    pull(id_plan)
  
})

corte_seleccionado <- reactive({
  
  id_plan %>% 
    filter(anio == input$select_anio_pilar) %>% 
    pull(corte)
  
})

# CARGAR DATOS ####
data_pdi_estructura <- cargar_consulta_anio('pdi_estructura', id_plan %>% pull(consulta) %>% toString())

data_pdi_resumen_sheet <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT3p4vO0oJo-efGC4M1eZ4vOgITQ4zf2ac7otuq6fuWtEYD8WsLVho0Aiq0VuYZJwreKYHDgv4l1ieY/pub?gid=0&single=true&output=csv")
data_pdi_presupuesto_sheet <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT3p4vO0oJo-efGC4M1eZ4vOgITQ4zf2ac7otuq6fuWtEYD8WsLVho0Aiq0VuYZJwreKYHDgv4l1ieY/pub?gid=653464016&single=true&output=csv")
data_pdi_impulsores_sheet <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vT3p4vO0oJo-efGC4M1eZ4vOgITQ4zf2ac7otuq6fuWtEYD8WsLVho0Aiq0VuYZJwreKYHDgv4l1ieY/pub?gid=2049628386&single=true&output=csv")
data_pdi_protocolos <- read_xlsx('data/TB_EXTERNO_PDI_PROTOCOLOS.xlsx', sheet = "PROTOCOLOS") %>% 
  mutate(FECHA_CREACION = as.character(FECHA_CREACION)) %>% 
  mutate(FECHA_ULTIMA_MODIFICACION = as.character(FECHA_ULTIMA_MODIFICACION))
data_pdi_protocolos_cambios <- read_xlsx('data/TB_EXTERNO_PDI_PROTOCOLOS.xlsx', sheet = "CONTROL_CAMBIOS") %>% 
  mutate(FECHA_MODIFICACION = as.character(FECHA_MODIFICACION))

data_pdi_avances_historico <- read_xlsx('data/TB_EXTERNO_PDI_AVANCES_HISTORICO.xlsx') %>% select(-contains("DATE"))

data_pdi_avances_actual <- cargar_consulta_anio('pdi_avances', id_plan %>%
                                                  filter(anio == lubridate::year(Sys.Date())) %>%
                                                  pull(consulta) %>%
                                                  toString()) %>% select(-contains("DATE"))

data_pdi_avances <- bind_rows(data_pdi_avances_actual, data_pdi_avances_historico)

# CALCULAR AVANCES
avances <- data_pdi_avances %>% 
  filter(MILESTONE_VALUE != 0) %>% 
  mutate(PORC_AVANCE_INDICADOR = if_else(ADVANCE_VALUE/MILESTONE_VALUE > 1, 100, round((ADVANCE_VALUE/MILESTONE_VALUE)*100,2)))

# AVANCES PROYECTOS Y PLANES OPERATIVOS
avances_plan_operativo <- avances %>% 
  filter(NODE_TYPE_ID == 'NODO_PLAN_OPERATIVO') %>% 
  group_by(PARTY_ID) %>% 
  mutate(PORC_AVANCE_PLAN_OPERATIVO = sum(PORC_AVANCE_INDICADOR)/n()) %>% 
  ungroup() %>% 
  distinct(PARTY_ID, PORC_AVANCE_PLAN_OPERATIVO) 

avances_proyectos <- avances_plan_operativo %>% 
  left_join(data_pdi_estructura %>% 
              filter(NODE_TYPE_ID == 'NODO_PLAN_OPERATIVO') %>% 
              select(PARTY_ID, ID_PROYECTO, PROYECTO) %>% 
              distinct(), by = "PARTY_ID") %>% 
  group_by(ID_PROYECTO) %>% 
  mutate(PORC_AVANCE = sum(PORC_AVANCE_PLAN_OPERATIVO)/n()) %>% 
  ungroup() %>% 
  distinct(ID_PROYECTO, PORC_AVANCE) %>% 
  rename(PARTY_ID = ID_PROYECTO) 

# AVANCES PROGRAMAS
avances_programas <- avances %>% 
  filter(NODE_TYPE_ID == 'NODO_PROGRAMA') %>% 
  group_by(PARTY_ID) %>% 
  mutate(PORC_AVANCE = sum(PORC_AVANCE_INDICADOR)/n()) %>% 
  ungroup() %>% 
  distinct(PARTY_ID, PORC_AVANCE) 

# AVANCES PILAR
avances_pilar <- avances %>% 
  filter(NODE_TYPE_ID == 'NODO_PILAR') %>% 
  left_join(data_pdi_estructura %>% 
              select(PARTY_ID, ID_PILAR, PILAR) %>% 
              distinct(), by = "PARTY_ID") %>% 
  group_by(PARTY_ID) %>% 
  mutate(PORC_AVANCE = sum(PORC_AVANCE_INDICADOR)/n()) %>% 
  ungroup() %>% 
  distinct(PARTY_ID, PORC_AVANCE) 

# AVANCES TRES NIVELES
avances_tres_niveles <- bind_rows(avances_proyectos, avances_programas, avances_pilar) %>% 
  left_join(data_pdi_estructura %>% 
                        select(PLAN_ID, PARTY_ID, NODE_TYPE_ID, ID_PILAR, PILAR) %>% 
                        distinct(), by = "PARTY_ID") %>% 
  group_by(PLAN_ID, NODE_TYPE_ID, PILAR) %>% 
  mutate(PORC_AVANCE = sum(PORC_AVANCE)/n()) %>% 
  ungroup() %>% 
  distinct(PLAN_ID, ID_PILAR, PILAR, NODE_TYPE_ID, PORC_AVANCE) %>% 
  select(PLAN_ID, ID_PILAR, PILAR, NODE_TYPE_ID, PORC_AVANCE) %>% 
  arrange(PLAN_ID, NODE_TYPE_ID, PILAR)
  
avances_consolidados_tres_niveles <- avances_tres_niveles %>% 
  group_by(PLAN_ID, NODE_TYPE_ID) %>% 
  summarise(PORC_AVANCE = sum(PORC_AVANCE)/n()) %>% 
  ungroup()


### SELECTOR DEL PILAR DE GESTION
output$select_pilar_gestion <- renderUI({
  
  valores <- data_pdi_estructura %>% 
    filter(PLAN_ID == plan_seleccionado(),
           NODE_TYPE_ID == 'NODO_PILAR') %>% 
    distinct(DISPLAY_NAME, ID_PILAR) %>% 
    arrange(DISPLAY_NAME)
  
  lista <- list_control(valores, ID_PILAR, DISPLAY_NAME)
  
  selectInput('select_pilar_gestion',
              'Seleccione el pilar de gestión:',
              choices = lista,
              width = 550)
  
})

pilar_seleccionado <- reactive({
  
  data_pdi_estructura %>% 
    filter(PLAN_ID == plan_seleccionado(),
           NODE_TYPE_ID == 'NODO_PILAR',
           ID_PILAR == input$select_pilar_gestion) %>% 
    mutate(CODIGO_PDI = paste0('PDI-',substr(DISPLAY_NAME, 1, 1))) %>% 
    pull(CODIGO_PDI)
  
})