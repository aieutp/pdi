source("config.R", local = TRUE)

NavBar <- tags$nav(class="navbar main-navbar navbar-expand-lg navbar-light bg-light",
  div(class="container-fluid",
    tags$button(type="button", id="sidebarCollapse", class="btn btn-primary",
      tags$i(class=paste("fa", iconSubHeader)),
      tags$span(class="sr-only", "Toggle Menu")
    ),
    tags$button(
      class="btn btn-dark d-inline-block d-lg-none ml-auto btn-menu-sections",
      type="button", "data-toggle"="collapse",
      "data-target"="#navbarSupportedContent",
      "aria-controls"="navbarSupportedContent", "aria-expanded"="false",
      "aria-label"="Toggle navigation",
      tags$i(class="fa fa-filter")
    ),
    div(class="collapse navbar-collapse", id="navbarSupportedContent",
      filtersSubHeader
    )
  )
)
