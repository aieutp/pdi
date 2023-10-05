FooterImports <- fluidPage(
   # footer external scripts
  tags$script(
    type="text/javascript",
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js",
    integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf",
    crossorigin="anonymous"
  ),
  tags$script(type="text/javascript", src="https://unpkg.com/aos@next/dist/aos.js"),
  tags$script(type="text/javascript", src="assets/config/config.js"),
  tags$script(type="text/javascript", src="assets/js/app.min.js"),
  tags$script(type="text/javascript", src="assets/js/shinydashboard.js"),
  tags$script(type="text/javascript", src="assets/js/scripts.js")
)
