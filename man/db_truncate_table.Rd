% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db_truncate_table.R
\name{db_truncate_table}
\alias{db_truncate_table}
\title{Function to run a \code{TRUNCATE TABLE} statement for a database table.}
\usage{
db_truncate_table(con, table)
}
\arguments{
\item{con}{Database connection.}

\item{table}{Table to remove all data from.}
}
\value{
Invisible.
}
\description{
Beware that this function will remove the contents of a database table so use
with caution.
}
\author{
Stuart K. Grange
}
