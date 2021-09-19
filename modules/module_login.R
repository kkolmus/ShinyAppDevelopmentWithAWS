login_ui <- function(id, title) {
    
    ns <- NS(id)
    
    div(
        id = ns("login"),
        style = "width: 500px; max-width: 100%; margin: 0 auto; padding: 20px;",
        div(
            class = "well",
            h2(class = "text-center", title),
            
            textInput(
                inputId = ns("user_input"),
                label = tagList(icon("user"), "User name"),
                placeholder = "Enter User Name"
            ),
            passwordInput(
                inputId = ns("password"),
                label = tagList(icon("unlock-alt"), "Password"),
                placeholder = "Enter Password"),
            
            div(
                class = "text-center",
                
                actionButton(
                    inputId = ns("login_button"),
                    label = "Log in",
                    class = "btn-primary",
                    style = "color:white;")
            )
        )
    )
}




validate_pwd <- function(input, output, session, data, user_col, pwd_col) {
    
    user <- data %>% dplyr::pull(!! enquo(user_col))
    pwd <- data %>% dplyr::pull(!! enquo(pwd_col))
    
    validate_password <- eventReactive(input$login_button, {
        
        validate <- FALSE
        if (input$user_input == user && input$password == pwd) {
            validate <- TRUE
        }
        
        if (validate) {shinyjs::hide(id = "login")}
        
        validate
        
    })
}
