source("config.R", local = TRUE)

Sidebar <- tags$div(id="sidebar",
  div(class="sidebar-main-content", "data-aos"="slide-right",
    div(
      class="sidebar-title",
      img(class="sidebar-title-logo", src="assets/media/aie_logo_slogan.png")
    ),
    div(class="sidebar-content p-4",
      tags$ul(class="list-unstyled components mb-5",
        lapply(sideBarMenu, function(i) {
          if (i[[2]] == "submenu") {
            if (i[[5]] == "open") showSubMenu <- "show" else showSubMenu <- ""
            tags$li(
              a(href=paste0("#", i[[3]]), "data-toggle"="collapse", "aria-expanded"="true",
                class="dropdown-toggle collapsed",
                tags$i(class=paste("fa", i[[4]])),
                tags$span(class="dropdown-option", i[[1]])
              ),
              tags$ul(class=paste("list-unstyled collapse", showSubMenu), id=i[[3]], role="tablist",
                lapply(i[[6]], function(j) {

                  if (j[[4]] == "active") showPage <- "active" else showPage <- ""

                  tags$li(class=paste("nav-item", showPage),
                    a(class=paste("nav-link", showPage),
                      id=paste0(j[[2]], "_tab"),
                      "data-toggle"="tab",
                      href=paste0("#", j[[2]]),
                      role="tab",
                      "aria-controls"=j[[2]],
                      "aria-selected"="true",
                      tags$i(class=paste("fa", j[[3]])),
                      tags$span(class="dropdown-option", j[[1]]))
                  )
                })
              )
            )
          } else {
            tags$li(
              a(class="nav-link",
                id=paste0(i[[3]], "_tab"),
                "data-toggle"="tab",
                href=paste0("#", i[[3]]),
                role="tab",
                "aria-controls"=i[[3]],
                "aria-selected"="true",
                tags$i(class=paste("fa", i[[4]])),
                tags$span(class="dropdown-option", i[[1]]))
            )
          }
        }),
        tags$li(
          a(
            class = "nav-link",
            href = "http://aie.utp.edu.co/protocolos",
            target = "_blank",
            tags$i(class = "fa fa-book"),
            tags$span(class = "dropdown-option", "Protocolos")
          )
        )
      )
    ),
    div(class="sidebar-footer",
      p(class="sidebar-footer-text", "Administración de la Información Estratégica - Oficina de Planeación")
    )
  )
)
