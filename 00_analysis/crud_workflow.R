# 1.0  WORKFLOW FOR CRUD OPERARTIONS USING BASE R----

user_base_tbl[user_base_tbl$user == "user1", ]["last_symbol"] <- "MA"

user_base_tbl[user_base_tbl$user == "user1", ][["favorites"]] <- list(c("AAPL", "GOOG", "NFLX", "MA"))

user_base_tbl[user_base_tbl$user == "user1", ][["user_settings"]] <- list(user_settings)
    
user_settings <- tibble(
    mavg_short = 15,
    mavg_long = 50,
    time_window = 365
)        

write_rds(user_base_tbl, "00_data_local/user_base_tbl.rds")

# 2.0 MODULARIZE FOR LOCAL STORAGE ----

read_user_base <- function() {
    user_base_tbl <<- read_rds("00_data_local/user_base_tbl.rds")
    }

read_user_base()

update_user_base <- function(user_name, column_name, assign_input) {
    user_base_tbl[user_base_tbl$user == user_name, ][column_name] <<- assign_input
}

# update_user_base("user1", "last_symbol", "V")
# update_user_base("user1", "last_symbol", "MA")

write_user_base <- function() {
    write_rds(user_base_tbl, "00_data_local/user_base_tbl.rds")
}

write_user_base()

update_and_write_user_base <- function(user_name, column_name, assign_input) {
    user_base_tbl[user_base_tbl$user == user_name, ][column_name] <<- assign_input
    write_rds(user_base_tbl, "00_data_local/user_base_tbl.rds")
}


# 3.0 CHECK WORKFLOW ----

read_user_base()

update_and_write_user_base("user1", "last_symbol", "V")

rm(user_base_tbl)

read_user_base()

# SAVE FUNCTIONS ----

dump(c("read_user_base", "update_and_write_user_base"), file = file.path("00_analysis/crud_operations.R"))
