library(shiny)
library(shiny.router)
library(bslib)

home_page <- div(
  class = "home",
  titlePanel("Home page"),
  p("This is the home page!"),
  uiOutput("power_of_input"),
  
  img(src="www/logo-navbar-aps.png"),
)

painel <- div(
  class="panel",
  titlePanel("PAINEL"),
  p("This is the another page!"),
)

menu <- 
  tags$nav(
    class = "navbar navbar-expand-lg navbar-light navbar-style",
    tags$div(
      id="navbarSupportedContent",
      class = "collapse navbar-collapse justify-content-end",
      tags$ul(
      class = "navbar-nav navbar-font",
        tags$li(class = "nav-item", a(class = "nav-link", href = route_link("/"), "SOBRE")),
        tags$li(class = "nav-item", a(class = "nav-link", href = route_link("painel"), "PAINEL")),
      )
    )
  )
footer <- 
  tags$div(
    class="card-footer footer-style text-muted fixed-bottom",
    img(src="www/logo-navbar-aps.png"),
    tags$img(src="www/logo-navbar-aps.png"),
    img(src="www/logo-navbar-aps.svg"),
    tags$img(src="www/logo-navbar-aps.svg")
  )
  # 
  # HTML('<div class="card-footer footer-style text-muted fixed-bottom">
  #         <img src="img/logos-footer.png" alt="Logo dos parceiros"></img>
  #       </div>')


ui <- fluidPage(
  includeCSS("css/style.css"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
  ),
  theme = bslib::bs_theme(version = 5),
  menu,
  tags$hr(),
  tags$hr(),
  router_ui(
    route("/", home_page),
    route("painel", painel)
  ),
  footer
)

server <- function(input, output, session) {
  router_server()
  component <- reactive({
    if (is.null(get_query_param()$add)) {
      return(0)
    }
    as.numeric(get_query_param()$add)
  })
  
  output$power_of_input <- renderUI({
    HTML(paste(
      "I display input increased by <code>add</code> GET parameter from app url and pass result to <code>output$power_of_input</code>: ",
      as.numeric(input$int) + component()))
  })
}


# Run the application 
shinyApp(ui = ui, server = server)