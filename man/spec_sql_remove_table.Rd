% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spec-sql-remove-table.R
\docType{data}
\name{spec_sql_remove_table}
\alias{spec_sql_remove_table}
\title{spec_sql_remove_table}
\value{
\code{dbRemoveTable()} returns \code{TRUE}, invisibly.
If the table does not exist, an error is raised.
An attempt to remove a view with this function may result in an error.

An error is raised when calling this method for a closed
or invalid connection.
An error is also raised
if \code{name} cannot be processed with \code{\link[=dbQuoteIdentifier]{dbQuoteIdentifier()}}
or if this results in a non-scalar.
}
\description{
spec_sql_remove_table
}
\section{Specification}{

A table removed by \code{dbRemoveTable()} doesn't appear in the list of tables
returned by \code{\link[=dbListTables]{dbListTables()}},
and \code{\link[=dbExistsTable]{dbExistsTable()}} returns \code{FALSE}.
The removal propagates immediately to other connections to the same database.
This function can also be used to remove a temporary table.

The \code{name} argument is processed as follows,
to support databases that allow non-syntactic names for their objects:
\itemize{
\item If an unquoted table name as string: \code{dbRemoveTable()} will do the
quoting,
perhaps by calling \code{dbQuoteIdentifier(conn, x = name)}
\item If the result of a call to \code{\link[=dbQuoteIdentifier]{dbQuoteIdentifier()}}: no more quoting is done
}
}

