% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_insert.R
\name{db_insert}
\alias{db_insert}
\title{Function to insert a data frame into/as a database table (R data frame to 
SQL table).}
\usage{
db_insert(con, table, df, replace = FALSE)
}
\arguments{
\item{con}{Database connection.}

\item{table}{Table in, or to be created in \code{con}.}

\item{df}{Data frame to be inserted into \code{con}.}

\item{replace}{Should the database table be replaced? Default is \code{FALSE}. 
Be cautious using this argument because it will drop the database table if it
exists.}
}
\value{
Invisible.
}
\description{
\code{db_insert} is a wrapper for \code{\link{dbWriteTable}}, but uses 
different defaults. \code{db_insert} will not replace data by default.
}
\seealso{
\code{\link{dbWriteTable}}, \code{\link{db_list_variables}},
\code{\link{db_table_names}}, \code{\link{db_arrange_variables}}
}
\author{
Stuart K. Grange
}
