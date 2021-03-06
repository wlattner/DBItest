#' spec_result_create_table_with_data_type
#' @usage NULL
#' @format NULL
#' @keywords NULL
spec_result_create_table_with_data_type <- list(
  #' @section Specification:
  #' All data types returned by `dbDataType()` are usable in an SQL statement
  #' of the form
  data_type_create_table = function(ctx) {
    with_connection({
      check_connection_data_type <- function(value) {
        with_remove_test_table({
          #' `"CREATE TABLE test (a ...)"`.
          query <- paste0("CREATE TABLE test (a ", dbDataType(con, value), ")")
          eval(bquote(dbExecute(con, .(query))))
        })
      }

      expect_conn_has_data_type <- function(value) {
        eval(bquote(
          expect_error(check_connection_data_type(.(value)), NA)))
      }

      expect_conn_has_data_type(logical(1))
      expect_conn_has_data_type(integer(1))
      expect_conn_has_data_type(numeric(1))
      expect_conn_has_data_type(character(1))
      expect_conn_has_data_type(Sys.Date())
      expect_conn_has_data_type(Sys.time())
      if (!isTRUE(ctx$tweaks$omit_blob_tests)) {
        expect_conn_has_data_type(list(as.raw(1:10)))
      }
    })
  },

  NULL
)
