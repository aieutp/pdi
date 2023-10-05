Modal <- div(
  id="initModal", class="modal fade", tabindex="-1", role="dialog",
  "aria-labelledby"="exampleModalLongTitle", "aria-hidden"="true",
  div(class="modal-dialog", role="document",
    div(class="modal-content",
    div(class="modal-header",
      tags$h5(class="modal-title font-regular", "Modal title"),
        tags$button(type="button", class="close modal-btn-close", "data-dismiss"="modal", "aria-label"="Close",
          tags$span("aria-hidden"="true", "x")
        )
      ),
      div(class="modal-body",
        div(id="modal-text font-regular", "Párrafo de prueba")
      ),
      div(class="modal-footer",
        tags$button(type="button", class="btn btn-secondary font-regular modal-btn-cancel", "data-dismiss"="modal"),
        tags$button(type="button", class="btn btn-primary font-regular modal-btn-ok"),
      )
    )
  )
)
