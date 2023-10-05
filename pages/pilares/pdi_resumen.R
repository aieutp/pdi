# CONTRUCCIÓN DE UNA NUEVA PÁGINA
#
# Para construir una nueva página es necesario realizar 3 acciones:
#
#   - Crear el item en el menú "sideBarMenu" que está en config.R
#   - Inicializar la variable "pageId" con el mismo identificador utilizado en "sideBarMenu"
#   - Inicializar la variable booleana "firstPageToShow" para definir si se debe mostrar
#     en la primera carga de la página (solo una página puede tener este variable en TRUE)
#
# El contenido de la página puede ser variable dependiendo de las necesidades del proyecto,
# por esta razón la creación de una nueva página no es tan configurable como otras secciones.
#
# A continuación se muestra un posible ejemplo de una nueva página que puede ser usada como
# referencia. Este template tiene varios puntos importantes a tener en cuenta:
#
#   - Está divido en secciones y cada sección debe tener: div(class="section".
#   - Cada sección tiene un elemento h2 para agregar un título (es opcional)
#   - Para conservar la animación de entrada de cada sección, es necesario que exista:
#     div("data-aos"="fade-up", "data-aos-once"="false".
#   - El interior de cada sección es de libre desarrollo y está a entera responsabilidad
#     de quién use la plantilla.
#
# Después de terminar el contenido de la sección, es necesario guardar este código en
# una variable que debe ser importada en el archivo ui.R,


pageId <- "page_pdi_resumen"   # <<=== IMPORTANTE! Este id es usado en sideBarMenu
firstPageToShow <- TRUE     # <<=== IMPORTANTE! Esta variable hace que esta página sea la primera que se visualice


if (firstPageToShow) showActivate <- "show active" else showActivate <- ""

templatePDI_Resumen <- div(  # <<=== IMPORTANTE! Esta es la variable que se debe importar desde ui.R
  class=paste("tab-pane fade", showActivate),
  id=pageId,
  role="tabpanel",
  "aria-labelledby"=paste0(pageId, "_tab"),
  
  div(class="section",
      div("data-aos"="fade-up", "data-aos-once"="false",
          h2(class="mb-4", htmlOutput('texto_Resumen_Nombre')),  
          h3(class="mb-4", "Resumen del Pilar"),  
          fluidRow(
            column(HTML("</br>"), width = 12),
            column(withSpinner(htmlOutput('texto_Resumen_DocumentoHTML'), type=8, color="#036085", size=0.5), width = 8)
          ),
          
          fluidRow(
            h3(class="mb-4", "Mapa de actores"), 
            column(HTML("</br>"), width = 12),
            column(withSpinner(htmlOutput('texto_Resumen_IMG_ACTORES'), type=8, color="#036085", size=0.5), width = 8)
          ),
          
          h3(class="mb-4", "Estructura del Pilar"),
          fluidRow(
            column(withSpinner(collapsibleTreeOutput("collapsibleTreePDI"), type=8, color="#036085", size=0.5), width = 9),
          ),
          
          h3(class="mb-4", "Portafolio de Proyectos"),  
          fluidRow(
            column(HTML("</br>"), width = 12),
            column(withSpinner(htmlOutput('texto_Resumen_PortafolioProyectos_DocumentoHTML'), type=8, color="#036085", size=0.5), width = 8)
          ),
      )
  ),
)
