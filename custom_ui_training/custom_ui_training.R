# BUSINESS SCIENCE ----
# DS4B 202-R ----
# CUSTOM UI TRAINING -----
# Version 1

# APPLICATION DESCRIPTION ----
# - Make custom shiny functions for  Bootstrap 3 components: Jumbotron, Info Card, and Thumbnail

# LIBRARIES ----
# Shiny
library(shiny)
library(shinythemes)

# Core
library(tidyverse)

# CUSTOM FUNCTIONS ----

jumbotron <- function(..., 
                      background_img = NULL, 
                      ui_box_bg_color = "rgba(0,0,0,0.5)",
                      ui_box_text_color = "white",
                      padding_size = "25px") {
    
    if (is.null(background_img)) {
        style_jumbotron = ""
    } else {
        style_jumbotron = str_glue(
        "background-image:url({background_img});
         background-size:'cover';")
    }
    
    div( # component
        class = "jumbotron",
        # style = "background-image:url('data_science_team.jpg');
        #              background-size:'cover';",
        style = style_jumbotron,
        div(
            class = "jumbotron-ui-box;text-default bg-primary",
            style = str_glue("color: {ui_box_text_color};
                     background-color: {ui_box_bg_color};
                     padding: {padding_size};"),
            # User input goes here:
            ...
        )
    )
}

info_card <- function(title,
                      value,
                      sub_value = "20%",
                      main_icon = "chart-line",
                      text_info = "success",
                      bg_color = "default",
                      text_color = "default",
                      icon_symbol = "arrow-up") {
    div(
        class = "panel panel-default",
        div(
            class = str_glue("panel-body bg-{bg_color} text-{text_color}"),
            p(class = "pull-right", icon(class = "fa-3x", main_icon)),
            h4(title),
            h5(value),
            p(
                class = str_glue("text-{text_info}"),
                icon(icon_symbol),
                tags$small(sub_value)
            )
        )
    )
}

thumbnail <- function(..., img = NULL, text_align = "center") {
    div(
        class = str_glue("thumbnail text-{text_align}"),
        tags$image(src = img),
        div(
            class = "caption",
            # USER INPUT
            ...
        )
    )
}

# UI ----
ui <- fixedPage(
    title = "Custom UI Components",
    
    themeSelector(),
    
    h1(class = "page-header", "Custom UI Training"),
    
    # JUMBOTRON COMPONENT ----
    div(
        class = "container",
        id = "jumbotron",
        h2("Jumbotron Component")
    ),
    
    column( # structure
        width = 12,
        div( # component
            class = "jumbotron",
            style = "background-image:url('data_science_team.jpg');
                     background-size:'cover';",
            div(
                class = "jumbotron-ui-box;text-default bg-primary",
                style = "color: white;
                         background-color:rgba(0,0,0,0.5);
                         padding: 25px;",
                # User input goes here:
                h1("Why learn Shiny?", style = "color: white;"),
                a(href = "#", class = "btn btn-default btn-primary", "learn more")
            )
        )
    ),
    
    column(
        width = 12,
        jumbotron(
            background_img = "data_science_team.jpg",
            ui_box_bg_color = "rgba(0,125,250,0.35)",
            ui_box_text_color = "black",
            # User input goes here:
            h1("Why learn Shiny?"),
            a(href = "#", class = "btn btn-default btn-primary", "learn more")
            )
    ),
    
    # CARD COMPONENT ----
    div(
        class = "container",
        id = "cards",
        h2("Info Card"),
        
        column(
            width = 4,
            div(
                class = "panel panel-default",
                div(
                    class = "panel-body bg-default text-default",
                    p(class = "pull-right", icon(class = "fa-3x", "chart-line")),
                    h4("AAPL"),
                    h5(
                        "20-day <small>vs. 50-day</small>" %>% HTML()
                    ),
                    p(
                        class = "text-success",
                        icon("arrow-up"),
                        tags$small("20%")
                    )
                )
            )
        ),
        
        column(
            width = 4,
            info_card(
                title = "NFLX",
                value = HTML("20-day <small>vs. 50-day</small>"),
                sub_value = "-10%",
                icon_symbol = "arrow-down",
                text_info = "danger"
            )
        )
        
    ),
    
    # THUMBNAIL CHALLENGE ----
    
    div(
        class = "container",
        id    = "thumbnails",
        h2("Thumbnails"),
        
        column(
            width = 4,
            div(
                class = "thumbnail text-center",
                tags$image(src = "data_science_team.jpg"),
                div(
                    class = "caption",
                    # USER INPUT
                    h3("Learn data science in weeks not years"),
                    p("These students apply this rule!"),
                    a(class = "btn btn-primary btn-small", href = "#", "Learn more")
                )
            )
        ),
        
        column(
            width = 4,
            thumbnail(
                img = "data_science_team.jpg",
                text_align = "left",
                #USER INPUT
                h3("Learn data science in weeks not years"),
                p("These students apply this rule!"),
                a(class = "btn btn-primary btn-small", href = "#", "Learn more")
            )
        )
    ),
    
    div(style = "height:400px;")
    
    
)

# SERVER ----
server <- function(input, output, session) {
    
}

shinyApp(ui, server)