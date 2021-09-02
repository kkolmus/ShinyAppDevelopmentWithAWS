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
             hr(),
             sliderInput(inputId = "mavg_short", label = "Short moving average",
                         min = 5, max = 40, value = 20),
             sliderInput(inputId = "mavg_long", label = "Long moving average",
                         min = 50, max = 120, value = 50)),
           ),
    column(width = 8,
           div(
             div(h4(textOutput(outputId = "plot_header")),
                 plotlyOutput(outputId = "plot_plotly")
                 )
             ))
    ),
  
  # 3.0 ANALYST COMMENTARY ----
  
  div(
    column(
      width = 12,
      div(
        div(h4("Analyst Commentary")),
        div(textOutput(outputId = "analyst_commentary"))
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
  
  # GET STOCK DATA ----
  
  stock_data_tbl <- reactive(
    stock_symbol() %>% 
      get_stock_data(
        from = today() - days(180),
        to = today(),
        mavg_short = input$mavg_short, # eventReactive if we want to trigger the update via the Analyze button
        mavg_long = input$mavg_long # eventReactive if we want to trigger the update via the Analyze button
      )
  )
  
  # PLOT TITLE ----
  
  plot_header <- eventReactive(
    eventExpr = input$analyze,
    {
      get_symbol_from_user_input(input$stock_selection)
    },
    ignoreNULL = FALSE
  )
  
  output$plot_header <- eventReactive(
    eventExpr = input$analyze,
    input$stock_selection,
    ignoreNULL = FALSE
  )
  
  # PLOT ----
  
  output$plot_plotly <- renderPlotly({
    stock_data_tbl() %>% plot_stock_data()
  })
  
  # ANALYST COMMENTARY ----
  
  output$analyst_commentary <- renderText({
    generate_commentary(data = stock_data_tbl(), user_input = plot_header())
  })
  
}

# RUN APP ----

shinyApp(ui = ui, server = server)