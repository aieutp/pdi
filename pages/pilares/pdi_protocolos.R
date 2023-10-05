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


pageId <- "page_pdi_protocolos"   # <<=== IMPORTANTE! Este id es usado en sideBarMenu
firstPageToShow <- FALSE     # <<=== IMPORTANTE! Esta variable hace que esta página sea la primera que se visualice


if (firstPageToShow) showActivate <- "show active" else showActivate <- ""

templatePDI_Protocolos <- div(  # <<=== IMPORTANTE! Esta es la variable que se debe importar desde ui.R
  class=paste("tab-pane fade", showActivate),
  id=pageId,
  role="tabpanel",
  "aria-labelledby"=paste0(pageId, "_tab"),

  div(class="section",
      div("data-aos"="fade-up", "data-aos-once"="false",
          h2(class="mb-4", "Protocolos del Pilar"),  
          fluidRow(
            column(6,
                   box(uiOutput("select_protocolo"), width = 12),
            ),
            column(6,
                   h4(class="mb-4", "Descripción:"),
                   withSpinner(htmlOutput('texto_Protocolos_Descripcion'), type=8, color="#036085", size=0.5),
            ),
            column(HTML("</br>"), width = 12),
          ),
          
          fluidRow(
            valueBoxOutput('valuebox_protocolos_Estado', width = 3),
            valueBoxOutput('valuebox_protocolos_Nivel_De_Gestion', width = 3),
            valueBoxOutput('valuebox_protocolos_unidad', width = 3),
            valueBoxOutput('valuebox_protocolos_Periodicidad', width = 3),
            column(HTML("</br>"), width = 12),
          ),
          
          fluidRow(
            column(6,
                   h4(class="mb-4", "Impulsores que aporta:"), 
                   withSpinner(htmlOutput('texto_Protocolos_Impulsores_Aporta'), type=8, color="#036085", size=0.5),
            ),
            column(3,
                   h4(class="mb-4", "Responsable de la Gestión:"), 
                   withSpinner(htmlOutput('texto_Protocolos_Responsable_Gestion'), type=8, color="#036085", size=0.5),
            ),
            column(3,
                   h4(class="mb-4", "Responsable del cálculo:"), 
                   withSpinner(htmlOutput('texto_Protocolos_Responsable_Del_Calculo'), type=8, color="#036085", size=0.5),
            ),
            
            column(HTML("</br>"), width = 12)
          ),
          
          fluidRow(
            column(6,
                   h4(class="mb-4", "Metadato:"), 
                   withSpinner(dataTableOutput('tabla_protocolos_metadato'), type=8, color="#036085", size=0.5),
            ),
            column(6,
                   h4(class="mb-4", "Formula:"), 
                   withSpinner(htmlOutput('texto_Protocolos_Formula'), type=8, color="#036085", size=0.5),
                   column(HTML("</br>"), width = 12),
                   h4(class="mb-4", "Consideraciones:"), 
                   withSpinner(htmlOutput('texto_Protocolos_Consideraciones_Calculo'), type=8, color="#036085", size=0.5),
                   column(HTML("</br>"), width = 12),
                   h4(class="mb-4", "Fuente de Datos:"), 
                   withSpinner(htmlOutput('texto_Protocolos_Fuente_De_Datos'), type=8, color="#036085", size=0.5),
            ),
            column(HTML("</br>"), width = 12)
          ),
          
          h4(class="mb-4", "Ejemplo de soporte:"), 
          fluidRow(
            column(withSpinner(dataTableOutput('tabla_protocolos_reporte_ejemplo'), type=8, color="#036085", size=0.5), width = 12),
            column(HTML("</br>"), width = 12),
          ),
          
          h4(class="mb-4", "Presentación de resultados:"), 
          fluidRow(
            withSpinner(htmlOutput('texto_Protocolos_Presentacion'), type=8, color="#036085", size=0.5),
            column(HTML("</br>"), width = 12),
          ),
          
          h4(class="mb-4", "Control de cambios:"), 
          fluidRow(
            column(withSpinner(dataTableOutput('tabla_protocolos_control_cambios'), type=8, color="#036085", size=0.5), width = 12),
            column(HTML("</br>"), width = 12),
          ),
          
          h4(class="mb-4", "Glosario:"), 
          fluidRow(
            withSpinner(htmlOutput('texto_Protocolos_Glosario'), type=8, color="#036085", size=0.5),
            column(HTML("</br>"), width = 12),
          ),
          
          h4(class="mb-4", "Fecha última modificación:"),
          fluidRow(
            withSpinner(htmlOutput('texto_Protocolos_Fecha_Ultima_Modificacion'), type=8, color="#036085", size=0.5),
            column(HTML("</br>"), width = 12),
          ),
      )
  ),
)
