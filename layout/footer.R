Footer <- div(class="footer-container",
  div(class="row",
    div(class="col-sm",
      tags$span(class="footer-title", "Contacto"),
      tags$span(class="footer-subtitle", "Llámanos"),
      tags$span(class="footer-text", "Tel: (57) (6) 313 7565"),
      tags$span(class="footer-text", "Conmutador: (57) (6) 313 7300"),

      tags$span(class="footer-subtitle", "Correos:"),
      tags$span(class="footer-text", "comunicaciones@utp.edu.co"),

      tags$span(class="footer-subtitle", "Direccion:"),
      tags$span(class="footer-text", "Universidad Tecnológica de Pereira"),
      tags$span(class="footer-text", "Carrera 27 #10-02 Barrio Alamos Pereira, Risaralda"),
      tags$span(class="footer-text", "Edificio 7B - Oficina 108"),
    ),
    div(class="col-sm",
      tags$span(
        class="footer-subtitle",
        "© 2023 - Universidad Tecnológica de Pereira - Reacreditada institucionalmente en 2021, 
        con vigencia de 10 años - Sujeta a inspección y vigilancia"
      ),
      tags$span(
        class="footer-subtitle",
        "Carrera 27 #10-02 Barrio Alamos - Risaralda - Colombia - AA: 97 - Código postal: 660003"
      ),
      tags$span(
        class="footer-subtitle",
        "PBX: +57 6 3137300 - Fax: +57 6 3213206 - Línea gratuita de Quejas y Reclamos: 018000966781 - contactenos@utp.edu.co"
      ),
      tags$span(
        class="footer-subtitle",
        "Horario de atención: Lunes a Viernes de 8:00am a 12:00m y de 2:00pm a 6:00pm"
      ),
      tags$span(
        class="footer-subtitle",
        "Institución de Educación Superior vigilada por MinEducación"
      ),
      tags$span(
        class="footer-text",
        "Políticas de Seguridad de la Información - Notificaciones Judiciales"
      )
    )
  ),
  div(class="row",
    div(class="social-icons",
      a(target="_blank", href="https://www.facebook.com/utpereira/", img(class="img-social", src="assets/media/social/facebookg.png")),
      a(target="_blank", href="https://twitter.com/UTPereira", img(class="img-social", src="assets/media/social/twitterg.png")),
      a(target="_blank", href="https://www.youtube.com/user/utpereira", img(class="img-social", src="assets/media/social/youtubeg.png")),
      a(target="_blank", href="https://www.instagram.com/UTPereira/", img(class="img-social", src="assets/media/social/instagramg.png")),
      a(target="_blank", href="https://co.linkedin.com/school/universidad-tecnol-gica-de-pereira/", img(class="img-social", src="assets/media/social/linkeding.png")),
      a(target="_blank", href="https://www.utp.edu.co/atencionalciudadano/herramientas-y-ayuda.html", img(class="img-social", src="assets/media/social/portalg.png")),
    )
  )
)
