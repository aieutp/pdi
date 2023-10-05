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


pageId <- "page_pdi_resultados"   # <<=== IMPORTANTE! Este id es usado en sideBarMenu
firstPageToShow <- FALSE     # <<=== IMPORTANTE! Esta variable hace que esta página sea la primera que se visualice


if (firstPageToShow) showActivate <- "show active" else showActivate <- ""

templatePDI_Resultados <- div(  # <<=== IMPORTANTE! Esta es la variable que se debe importar desde ui.R
  class=paste("tab-pane fade", showActivate),
  id=pageId,
  role="tabpanel",
  "aria-labelledby"=paste0(pageId, "_tab"),
  
  fluidRow(
    column(12,
           h2(class="mb-4", htmlOutput('texto_Nombre')),
           fluidRow(
             column(9,
                    fluidRow(
                      column(HTML("<b>OBJETIVO:</b> "), width = 12),
                      column(withSpinner(htmlOutput('texto_Objetivo'), type=8, color="#036085", size=0.5), width = 12),
                      column(HTML("</br>"), width = 12),
                      column(HTML("<b>IMPULSORES ESTRATÉGICOS A LOS QUE APUNTA:</b> "), width = 12),
                      column(withSpinner(htmlOutput('texto_Impulsores'), type=8, color="#036085", size=0.5), width = 12),
                      column(HTML("</br>"), width = 12),
                      column(HTML("<b>DESCRIPCIÓN:</b> "), width = 12),
                      column(withSpinner(htmlOutput('texto_Descripcion'), type=8, color="#036085", size=0.5), width = 12),
                    ),
             ),
             column(width = 3,
                    fluidRow(
                      column(HTML("<b>CONVENCIONES:</b> "), width = 12),
                      column(withSpinner(dataTableOutput('tabla_convenciones'), type=8, color="#036085", size=0.5), width = 12),
                      valueBoxOutput('valuebox_resultado_general_pdi', width = 12),
                    ),
             )
           )
    )
  ),
  
  
  
  div(class="section",
      div("data-aos"="fade-up", "data-aos-once"="false",

          h3(class="mb-4", "Resultados generales del pilar"), 
          fluidRow(
            column(HTML("</br>"), width = 12),
            valueBoxOutput('valuebox_resultado_nivel_pilares', width = 3),
            valueBoxOutput('valuebox_resultado_nivel_programas', width = 3),
            valueBoxOutput('valuebox_resultado_nivel_proyectos', width = 3),
            valueBoxOutput('valuebox_resultado_pilar', width = 3),
          ),

          h3(class="mb-4", "Resultados a nivel de pilares"),
          fluidRow(
            column(withSpinner(htmlOutput('texto_PilaresImpulsores'), type=8, color="#036085", size=0.5), width = 12),
            column(withSpinner(dataTableOutput('tabla_pilares_impulsores'), type=8, color="#036085", size=0.5), width = 12),
          ),
          h3(class="mb-4", "Resultados a nivel de programas"),
          fluidRow(
            column(withSpinner(htmlOutput('texto_Programas'), type=8, color="#036085", size=0.5), width = 12),
            column(withSpinner(dataTableOutput('tabla_pilares_programas'), type=8, color="#036085", size=0.5), width = 12),
          ),
          h3(class="mb-4", "Resultados a nivel de proyectos"),
          fluidRow(
            column(withSpinner(htmlOutput('texto_Proyectos'), type=8, color="#036085", size=0.5), width = 12), column(HTML("</br>"), width = 12),
            column(withSpinner(echarts4rOutput('relacion_eficiencia'), type=8, color="#036085", size=0.5), width = 4),
            column(withSpinner(echarts4rOutput('relacion_eficacia'), type=8, color="#036085", size=0.5), width = 4),
            column(withSpinner(echarts4rOutput('relacion_efectividad'), type=8, color="#036085", size=0.5), width = 4),
            column(withSpinner(dataTableOutput('tabla_proyectos'), type=8, color="#036085", size=0.5), width = 12),
          ),

      )
  ),
)
