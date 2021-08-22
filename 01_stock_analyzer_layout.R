# BUSINESS SCIENCE ----
# DS4B 202-R ----
# STOCK ANALYZER APP - LAYOUT -----
# Version 1

# APPLICATION DESCRIPTION ----
# - Create a basic layout in shiny showing the stock dropdown, interactive plot and commentary


# LIBRARIES ----
library(shiny)
library(shinyWidgets)

library(plotly)
library(tidyquant)
library(tidyverse)

source(file = "00_scripts/stock_analysis_functions.R")

stock_list_tbl <- get_stock_list("SP500")
# stock_data_tbl <- get_stock_data("AAPL",
#                                  from = "2019-01-01",
#                                  to = "2019-06-30")

# UI ----

ui <- fluidPage(
  title = "Stock Analyzer",
  
  # 1.0 HEADER ----
  
  div(
    h1("Stock Analyzer", 
       "by Business Science"),
    p("This is the first app developed within the",
      "Expert Shiny Application Course (DS4B 202-R)")
  ),
  
  
  # 2.0 APPLICATION UI ----
  div(
    column(width = 4,
           wellPanel(
             pickerInput(
               inputId = "stock_selection",
               label = "Stock List (Pick One to Analyze)",
               multiple = FALSE,
               choices = stock_list_tbl$label,
               selected = stock_list_tbl %>% 
                 filter(label %>% str_detect(pattern = "AAPL")) %>% 
                 pull(label),
               options = pickerOptions(
                 actionsBox = FALSE,
                 liveSearch = TRUE,
                 size = 10
               )),
             actionButton(
               inputId = "analyze",
               label = "Analyze",
               icon = icon("download")
               ),
             textOutput(outputId = "selected_symbol")
             )
           ),
    column(width = 8,
           div(
             div(h4("The selected stock is ...",
                    textOutput(
                      outputId = "plot_header"
                    )), #,
                 # stock_data_tbl %>% plot_stock_data()
                 verbatimTextOutput(
                   outputId = "stock_data_tbl"
                 )
                 )
           ))
  ),
  
  # 3.0 ANALYST COMMENTARY ----
  
  div(
    column(
      width = 12,
      div(
        div(h4("Analyst Commentary")),
        div(
          # stock_data_tbl %>% generate_commentary(user_input = "Placeholder")
          )
      )
    )
  )
  
  ) 

# SERVER ----

server <- function(input, output, session) {
  
  # STOCK SYMBOL ----
  
  stock_symbol <- eventReactive(
    eventExpr = input$analyze,
    {
      get_symbol_from_user_input(input$stock_selection)
    },
    ignoreNULL = FALSE
  )
  
  output$selected_symbol <- renderText(stock_symbol())
  
  # PLOT TITLE ----
  
  plot_header <- eventReactive(
    eventExpr = input$analyze,
    {
      get_symbol_from_user_input(input$stock_selection)
    },
    ignoreNULL = FALSE
  )
  
  output$plot_header <- renderText(plot_header())
  
  # GET STOCK DATA ----
  
  stock_data_tbl <- reactive(
    stock_symbol() %>% 
      get_stock_data(
        from = today() - days(180),
        to = today(),
        mavg_short = 20,
        mavg_long = 50
    )
  )
  
  output$stock_data_tbl <- renderPrint(stock_data_tbl())
  
}

# RUN APP ----

shinyApp(ui = ui, server = server)