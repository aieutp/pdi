#library(RJDBC)

# LEER CONSULTAS SQL
getSQL <- function(script){
  
  sql.string <- ""
  
  while (TRUE){
    line <- readLines(script, n = 1)
    if ( length(line) == 0 ) break

    line <- gsub("\\t", " ", line)
    if(grepl("--",line) == TRUE) line <- paste(sub("--","/*",line),"*/")
    
    sql.string <- paste(sql.string, line)
  }
  close(script)
  return(sql.string)
}

# CONSULTA CON PERIODO
cargar_consulta <- function(consulta, periodo = ''){
  
  script <- read_file(paste0("consultas/",consulta,".txt"))
  script <- gsub('___PERIODO___' ,periodo, script)
  script <- textConnection(script, 'r')
  script <- getSQL(script)
  
  driver <-JDBC(driverClass = "oracle.jdbc.OracleDriver","client/ojdbc6.jar")
  conexion <- dbConnect(driver,"jdbc:oracle:thin:@//clusteroracle.utp.edu.co:1452/product","PLANEACION","viviana",charset = "UTF-8")
  consulta <- dbGetQuery(conexion, script)
  
  Encoding(names(consulta)) <- "UTF-8"
  names(consulta)
  
  dbDisconnect(conexion)
  consulta <- as_tibble(consulta)
  
  return(consulta)
}

# CONSULTA CON AÑO Y SEMESTRE
cargar_consulta_anio <- function(consulta, anio = '', semestre = ''){
  
  script <- read_file(paste0("consultas/",consulta,".txt"))
  script <- gsub('___ANIO___' ,anio, script)
  script <- gsub('___SEMESTRE___' ,semestre, script)
  script <- textConnection(script, 'r')
  script <- getSQL(script)
  
  driver <-JDBC(driverClass = "oracle.jdbc.OracleDriver","client/ojdbc6.jar")
  conexion <- dbConnect(driver,"jdbc:oracle:thin:@//clusteroracle.utp.edu.co:1452/product","PLANEACION","viviana",charset = "UTF-8")
  consulta <- dbGetQuery(conexion, script)
  
  Encoding(names(consulta)) <- "UTF-8"
  names(consulta)
  
  dbDisconnect(conexion)
  consulta <- as_tibble(consulta)
  
  return(consulta)
}

# IMPRIMIR PORCENTAJES
print_perc <- function(number, decimales){
  return (paste0(round(number, decimales + 2)*100,'%'))
}


## -------------------------
## GRAFICOS DE PLOTLY
## -------------------------

# GRÁFICO DE DONA AGRUPACIÓN DE UNA VARIABLE CON SUMA
grafico_torta <- function(df, variable_agrupacion, variable_conteo, titulo){
  
  x = enquo(variable_agrupacion)
  y = enquo(variable_conteo)
  
  df <- df %>% 
    group_by(!!x) %>% 
    summarize(n = sum(!!y)) %>% 
    ungroup() %>% 
    rename(x = !!x)
  
  fig <- df %>% plot_ly(labels = ~x, values = ~n) %>% 
    add_pie(hole = 0.5) %>% 
    layout(title = list(text = str_wrap(titulo, 15), y = 0.5), 
           showlegend = F,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           margin = list(l=15,r=15,b=0,t=0))
  
  return (fig)
}

### GRAFICO DE BARRAS HORIZONTALES
barras_horizontales_2c <- function(df, var_agrupacion_1, var_agrupacion_2, var_conteo, titulo, mode = 'group'){
  
  x <- enquo(var_agrupacion_1)
  y <- enquo(var_agrupacion_2)
  z <- enquo(var_conteo)
  
  plot_data <- df %>% 
    group_by(!!x, !!y) %>%
    summarise(n = sum(!!z)) %>% 
    pivot_wider(names_from = !!x, values_from = n)
  
  fig <- plot_ly(y = plot_data[,1] %>% pull(),
                 x = plot_data[,2] %>% pull(),
                 name = names(plot_data)[2],
                 type = 'bar',
                 orientation = 'h'
  )
  
  for (i in 3:ncol(plot_data)){
    name <- names(plot_data)[i] 
    values <- plot_data[,i] %>% pull()
    
    fig <- fig %>% 
      add_trace(x = values, name = name)
    
    rm(name)
    rm(values)
    
  }
  
  fig %>% 
    layout(barmode = mode, # barnorm = 'percent',
           title = titulo,
           xaxis = list(title =""),
           yaxis = list(title =""),
           showlegend = TRUE,
           legend = list(orientation = "h",
                         xanchor = "center",
                         x = 0.5)) %>% 
    config(displayModeBar = FALSE)
  
  return(fig)
  
}

### GRÁFICO DE RADAR O ARAÑA
grafico_radar <- function(df, agrupacion1, agrupacion2, valores, titulo){
  
  g1 <- enquo(agrupacion1)
  g2 <- enquo(agrupacion2)
  z <- enquo(valores)
  
  max <- round(max(df %>% pull(!!z)) + 15, -1)
  min <- round(min(df %>% pull(!!z)) - 15, -1)
  
  fig <- plot_ly(type = 'scatterpolar',fill = 'toself')
  
  for (i in df %>% distinct(!!g1) %>% pull()){
    
    temp <- df %>% filter(!!g1 == i)
    temp <- temp %>% 
      bind_rows(temp %>% head(1))
    
    n <- temp %>% pull(!!g1)
    x <- temp %>% pull(!!g2)
    y <- temp %>% pull(!!z)
    
    fig <- fig %>%
      add_trace(r = y, theta = x, name = i, fill = 'none',mode = 'lines+markers') 
    
    rm(temp)
    rm(x)
    rm(y)
  }
  
  fig <- fig %>%
    layout(polar = list(radialaxis = list(visible = T,range = c(min,max))),
           legend = list(orientation = "h",   # show entries horizontally
                         xanchor = "center",  # use center of legend as anchor
                         x = 0.5), title = titulo) %>% 
    config(displayModeBar = FALSE)
  
  return(fig)
}

### GRAFICO DE BARRAS VERTICALES
barras_verticales_2c <- function(df, var_agrupacion_1, var_agrupacion_2, var_conteo, titulo, mode = 'group'){
  
  x <- enquo(var_agrupacion_1)
  y <- enquo(var_agrupacion_2)
  z <- enquo(var_conteo)
  
  plot_data <- df %>% 
    group_by(!!x, !!y) %>%
    summarise(n = sum(!!z)) %>% 
    pivot_wider(names_from = !!x, values_from = n)
  
  fig <- plot_ly(x = plot_data[,1] %>% pull(),
                 y = plot_data[,2] %>% pull(),
                 name = names(plot_data)[2],
                 type = 'bar'
  )
  
  for (i in 3:ncol(plot_data)){
    
    name <- names(plot_data)[i] 
    values <- plot_data[,i] %>% pull()
    
    fig <- fig %>% 
      add_trace(y = values, name = name)
    
    rm(name)
    rm(values)
    
  }
  
  fig %>% 
    layout(barmode = mode, # barnorm = 'percent',
           title = titulo,
           xaxis = list(title =""),
           yaxis = list(title =""),
           showlegend = TRUE,
           legend = list(orientation = "h",
                         xanchor = "center",
                         x = 0.5)) %>% 
    config(displayModeBar = FALSE)
  return(fig)
}


### FUNCION TABLA DINAMICA

# custom function to transpose while preserving names
transpose_df <- function(df) {
  t_df <- data.table::transpose(df)
  colnames(t_df) <- rownames(df)
  rownames(t_df) <- colnames(df)
  t_df <- t_df %>%
    tibble::rownames_to_column(.data = .) %>%
    tibble::as_tibble(.)
  return(t_df)
}

funcion_tabla <- function(df, var_agrupacion_1, var_agrupacion_2, var_conteo){
  
  x <- enquo(var_agrupacion_1)
  y <- enquo(var_agrupacion_2)
  z <- enquo(var_conteo)
  
  df_out <- df %>% 
    group_by(!!x, !!y) %>%
    summarise(n = sum(!!z)) %>% 
    pivot_wider(names_from = !!x, values_from = n) %>% 
    ungroup()
  
  df_out2 <- df %>%
    group_by(!!x) %>%
    summarise(Total = sum(!!z)) %>% 
    pivot_wider(names_from = !!x, values_from = Total) %>%
    ungroup()
  
  df_out3 <- df_out %>% bind_rows(df_out2) %>% 
    mutate(Total = select(., colnames(df_out)[2:ncol(df_out)]) %>% rowSums(na.rm = TRUE)) 
    
  df_out3
  
}

### Función para generar selecciones

list_control <- function(df, id_var, var){
  
  id <- enquo(id_var)
  opt <- enquo(var)
  
  opt_var <- df %>% 
    select(!!id, !!opt) %>% 
    distinct()
  
  ids <- opt_var %>% select(!!id) %>% pull()
  options <- opt_var %>% select(!!opt) %>% pull()
  
  list_opt <- as.list(ids)
  names(list_opt) <- options
  
  list_opt
  
}
