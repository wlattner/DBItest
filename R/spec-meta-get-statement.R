#' spec_meta_get_statement
#' @usage NULL
#' @format NULL
#' @keywords NULL
spec_meta_get_statement <- list(
  get_statement_formals = function(ctx) {
    # <establish formals of described functions>
    expect_equal(names(formals(dbGetStatement)), c("res", "..."))
  },

  #' @return
  #' `dbGetStatement()` returns a string, the query used in
  get_statement_query = function(ctx) {
    with_connection({
      query <- "SELECT 1 as a"
      with_result(
        #' either [dbSendQuery()]
        dbSendQuery(con, query),
        {
          s <- dbGetStatement(res)
          expect_is(s, "character")
          expect_identical(s, query)
        }
      )
    })
  },

  get_statement_statement = function(ctx) {
    with_connection({
      name <- random_table_name()

      with_connection({
        with_remove_test_table(name = name, {
          query <- paste0("CREATE TABLE ", name, " (a integer)")
          with_result(
            #' or [dbSendStatement()].
            dbSendQuery(con, query),
            {
              s <- dbGetStatement(res)
              expect_is(s, "character")
              expect_identical(s, query)
            }
          )
        })
      })
    })
  },

  get_statement_error = function(ctx) {
    with_connection({
      res <- dbSendQuery(con, "SELECT 1")
      dbClearResult(res)
      #' Attempting to query the statement for a result set cleared with
      #' [dbClearResult()] gives an error.
      expect_error(dbGetStatement(res))
    })
  },

  NULL
)
