source("config.R", local = TRUE)

HeadMetaSEO <- div(
  suppressDependencies("bootstrap"),

  # <head></head>
  tags$html(lang="es"),
  tags$head(
    # meta data for CEO purposes
    tags$meta(charset="UTF-8"),
    tags$title(titleApp),
    tags$meta(name="description", content=descriptionSEO),
    tags$meta(name="keywords", content=keywordsSEO),
    tags$meta(name="viewport", content="width=device-width, initial-scale=1.0"),

    # favicon
    tags$link(rel="icon", type="image/png", size="32x32", href="assets/media/icons/favicon-32x32.png"),
    tags$link(rel="icon", type="image/png", size="16x16", href="assets/media/icons/favicon-16x16.png"),
    tags$link(rel="shortcut icon", type="image/x-icon", href=favicon),
    tags$link(rel="icon", type="image/x-icon", href=favicon),

    # header external fonts
    tags$link(
      rel="stylesheet",
      href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900",
    ),

    # header external styles
    tags$link(
      rel="stylesheet",
      type="text/css",
      href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css",
      integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p",
      crossorigin="anonymous"
    ),
    tags$link(rel="stylesheet", type="text/css", href="https://unpkg.com/aos@next/dist/aos.css"),
    tags$link(rel="stylesheet", type="text/css", href="assets/css/styles-template.css"),
    tags$link(rel="stylesheet", type="text/css", href="assets/css/AdminLTE.min.css"),
    tags$link(rel="stylesheet", type="text/css", href="assets/css/_all-skins.min.css"),
    tags$link(rel="stylesheet", type="text/css", href="assets/css/shinydashboard.css"),
    tags$link(rel="stylesheet", type="text/css", href="assets/css/styles.css"),

    # header external scripts
    tags$script(
      type="text/javascript",
      src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js",
      integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1",
      crossorigin="anonymous"
    ),
    tags$script(
      type="text/javascript",
      src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js",
      integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM",
      crossorigin="anonymous"
    )
  ),

  div(class="main-header",
    a(href="https://www.utp.edu.co/", target="_blank",
      img(class="logo-utp", src=logo1Header),
    ),
    a(href="https://www.mineducacion.gov.co/portal/", target="_blank",
      img(class="logo_min", src=logo2Header)
    )
  ),
)
