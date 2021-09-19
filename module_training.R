# BUSINESS SCIENCE ----
# DS4B 202-R ----
# AUTHENTICATION & MODULE TRAINING -----
# Version 1

# APPLICATION DESCRIPTION ----
# - Render a Login Dialog Page
# - Dynamically render a UI upon authentication
# - Create a module to produce the login
# - Use the shinyauthr package

library(shiny)
library(shinythemes)
library(tidyverse)
library(shinyjs)

library(shinyauthr) # devtools::install_github("business-science/shinyauthr", force = TRUE)

ui <- navbarPage(
    title = "Module Training", 
    theme = shinytheme("flatly"),
    collapsible = TRUE,
    
    tabPanel(
        useShinyjs(),
        title = "Login Module",
        
        h2("No Module"),
        
        div(
          id = "login",
          style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
          div(
            class = "well",
            h2(class = "text-center", "Please Login"),
            
            textInput(
              inputId = "user_input",
              label = tagList(icon("user"), "User name"),
              placeholder = "Enter User Name"
            ),
            passwordInput(
              inputId = "password",
              label = tagList(icon("unlock-alt"), "Password"),
              placeholder = "Enter Password"),
            
            div(
              class = "text-center",
              
              actionButton(
                inputId = "login_button",
                label = "Log in",
                class = "btn-primary",
                style = "color:white;")
            )
          )
        ),
        
        uiOutput(
          outputId = "display_content"
        ),
        
        h2("Using A Module"),
        
        # TODO
        
        h2('Using Shiny Auth')
    )
)

server <- function(input, output, session) {
    
    user_base_tbl <- tibble(
        user_name = "user1",
        password  = "pass1"
    )
    
    # NO MODULE ----
    
    validate_password <- eventReactive(input$login_button, {
      
      validate <- FALSE
      if (input$user_input == user_base_tbl$user_name && input$password == user_base_tbl$password) {
        validate <- TRUE
      }
      
      validate
      
    })
    
    output$display_content <- renderUI({
      
      req(validate_password())
      
      div(
        id = "success",
        class = "well",
        h1(
          class = "page-header", 
          "Stock Analyzer",
          tags$small("by Business Science")),
        p(class = "lead",
          "Page content")
      )
      
    })
    
    # MODULE ----
    
    
    # SHINYAUTHR ----
    
    
}

shinyApp(ui, server)