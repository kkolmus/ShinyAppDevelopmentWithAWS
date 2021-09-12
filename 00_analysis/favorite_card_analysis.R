# BUSINESS SCIENCE ----
# DS4B 202-R ----
# STOCK ANALYZER APP - FAVORITE CARD ANALYSIS -----
# Version 1

# APPLICATION DESCRIPTION ----
# - The user will select 1 stock from the SP 500 stock index
# - [DONE] The functionality is designed to pull the past 180 days of stock data 
# - We will conver the historic data to 2 moving averages - short (fast) and long (slow)
# - We will make a function to generate the moving average cards

# SETUP ----
library(tidyquant)
library(tidyverse)

source("00_scripts/stock_analysis_functions.R")
source("00_scripts/info_card.R")


stock_list_tbl <- get_stock_list("SP500")

favorite_list_on_start <- c("AAPL", "GOOG", "NFLX")

# 1.0 Get Stock Data for Each Favorite ----


# 2.0 Get Moving Average Data for Each Stock History ----


# 3.0 Generate Favorite Card ----


# 4.0 Generate All Favorite Cards in a TagList ----



# 5.0 Save Functions ----
dump(c("get_stock_mavg_info", "generate_favorite_card", 'generate_favorite_cards'), 
     file = "00_scripts/generate_favorite_cards.R", append = FALSE)