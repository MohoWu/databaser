#' Functions to vacuum, analyse, and optimise database tables. 
#' 
#' The PostgreSQL statement uses \code{VACUUM (VERBOSE)}, the MySQL statement
#' uses \code{OPTIMIZE}, and the SQLite statement uses \code{VACUUM} and the 
#' \code{table} argument is not used. 
#' 
#' @author Stuart K. Grange
#' 
#' @param con Database connection. 
#' 
#' @param table Database table. 
#' 
#' @return Invisible or data frame if assigned. 
#' 
#' @examples 
#' \dontrun{
#' 
#' db_vacuum(con, "model_data")
#' db_optimise(con, "air_quality_data")
#' 
#' }
#' 
#' @export
db_vacuum <- function(con, table) {
  
  # Get things pre-vacuum
  date_pre <- Sys.time()
  size_pre <- db_size(con)
  
  if (db.class(con) == "postgres")
    quiet(db_execute(con, stringr::str_c("VACUUM (VERBOSE) ", table)))
  
  if (db.class(con) == "mysql") {
    
    # Catch the reserved verbs
    table <- stringr::str_c("`", table, "`")
    
    # Optimise
    quiet(db_execute(con, stringr::str_c("OPTIMIZE TABLE ", table)))
    
  }
  
  if (db.class(con) == "sqlite") quiet(db_execute(con, "VACUUM"))
  
  # Get things post-vacuum
  date_post <- Sys.time()
  size_post <- db_size(con)
    
  df <- data.frame(
    when = c("pre_vacuum", "post_vacuum"),
    date = c(date_pre, date_post),
    size = c(size_pre, size_post),
    stringsAsFactors = FALSE
  )
  
  return(invisible(df)) 
  
}


# Use MySQL notation
#' @rdname db_vacuum
#' @export
db_optimise <- db_vacuum
