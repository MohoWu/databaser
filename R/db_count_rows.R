#' Function to get row counts from database tables. 
#' 
#' The \code{row_count} variable will be a numeric value rather than an integer 
#' to avoid integer overflow issues for large tables. 
#' 
#' @author Stuart K. Grange
#' 
#' @param con Database connection.
#' 
#' @param table Table name in \code{con}. If \code{table} is unknown, all tables
#' in \code{con} will be queried. 
#' 
#' @param estimate Only for PostgreSQL, should the table count estimate be used? 
#' Default is \code{FALSE}. 
#' 
#' @param progress Type of progress bar to display. Default is \code{"none"}. 
#' 
#' @export
db_count_rows <- function(con, table = NA, estimate = FALSE, progress = "none") {
  
  # If no table is selected, do them all
  if (is.na(table[1])) table <- db_list_tables(con)
  
  # Check
  if (length(table) == 0) stop("Database has no tables...", call. = FALSE)
  
  # Only some tables
  df <- plyr::ldply(
    table, function(x) db_count_rows_worker(
      con, 
      x, 
      estimate
    ), 
    .progress = progress)
  
  return(df)
  
}


# Function to get the row counts
db_count_rows_worker <- function(con, table, estimate) {
  
  if (estimate) {
    
    # Will only work for postgres
    sql <- stringr::str_c(
      "SELECT reltuples::bigint AS row_count 
      FROM pg_class 
      WHERE relname = '", table, "'"
    )

  } else {
    
    # Create statement, use real so 32 bit integers are not a limitation
    sql <- stringr::str_c(
      "SELECT CAST(COUNT(*) AS REAL) AS row_count 
      FROM ", 
      table
    )
    
    # Do not use the cast function here
    if (grepl("mysql", class(con)[1], ignore.case = TRUE)) {
      
      sql <- stringr::str_c(
        "SELECT COUNT(*) AS row_count 
         FROM ", table
      )
      
    }
      
  }
  
  # Use statement
  df <- tryCatch({
    
    db_get(con, sql)
    
  }, error = function(e) {
    
    data.frame(
      row_count = NA,
      stringsAsFactors = FALSE
    )
    
  })

  # Add table and order variables
  df <- data.frame(
    table, 
    row_count = df$row_count,
    stringsAsFactors = FALSE
  )
  
  return(df)
  
}
