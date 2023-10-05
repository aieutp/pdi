# HEAD Y META TAGS
#
# A continuación se declaran las variables a metatags y configuración general de la
# plantilla

titleApp <- "Tablero PDI 2020-2028"
favicon <- "assets/media/icons/favicon.ico"
descriptionSEO <- "Cuadro de control PDI 2020-2028"
keywordsSEO <- "Cuadro de control, Plan de Desarrollo, Avances PDI"



# HEADER Y SUBHEADER
#
# A continuación se declaran las variables ligadas a la multimedia que se muestra en
# header y subheader, al igual que los filtros generales del proyecto.
#
# NOTA: La configuración de colores está en www/assets/config/congif.css

logo1Header <- "assets/media/logoutp.png"
logo2Header <- "assets/media/ministerioeducacion.png"
iconSubHeader <- "fa-bars"


filtersSubHeader <- tags$ul(class="nav navbar-nav ml-auto",

  tags$li(class="nav-item active",
          uiOutput('select_pilar_gestion')
  ),
                            
  tags$li(class="nav-item active",
          sliderInput("select_anio_pilar", "", min = 2020, max = 2023, value = 2023, sep = "",step = 1)
  )
)

# MENU LATERAL IZQUIERDO
#
# A continuación se declara la variable "sideBarMenu" encargada de almacenar en forma
# de lista las diferentes opciones del menú. Existen 2 tipos de menú:
#
#   1. "simple":
#         - No tiene opciones internas y posee un link a una página
#         - Es una lista con 5 items obligatorios:
#             - Texto del ítem
#             - Tipo de menú (simple)
#             - Identificador único (sin caracteres especiales ni espacios), el cuál
#               debe ser el mismo identificador de la página asociada.
#             - Icono lateral (se pueden encontrar aquí: https://fontawesome.com/icons)
#             - Mostrar como activo o inactivo en el menu lateral sideBarMenu en la primera cargar
#
#   2. "submenu":
#         - Tiene opciones internas con links a otras páginas
#             - Texto del ítem
#             - Tipo de menú (submenu)
#             - Identificador único (sin caracteres especiales ni espacios)
#             - Icono lateral (se pueden encontrar aquí: https://fontawesome.com/icons)
#             - Visualización del submenú (cerrado o abierto)
#             - Lista de items del submenu que a su vez contienen:
#                 - Texto del subitem
#                 - Identificador único (sin caracteres especiales ni espacios), el cuál
#                   debe ser el mismo identificador de la página asociada.
#                 - Icono lateral (se pueden encontrar aquí: https://fontawesome.com/icons)
#                 - Mostrar como activo o inactivo en el menu lateral sideBarMenu en la primera carga

sideBarMenu <- list(
  list("Resumen del Pilar", "simple", "page_pdi_resumen", "fa-landmark", "active"),
  list("Resultados",  "simple", "page_pdi_resultados", "fa-chart-line", "inactive"),
  list("Protocolos",  "simple", "page_pdi_protocolos", "fa-book", "inactive")
)
