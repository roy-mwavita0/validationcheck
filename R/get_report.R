#' Generate Validation Report
#'
#' Creates an interactive validation report table.
#'
#' @param agent Validation object
#'
#' @return Interactive reactable report
#' @export

get_report <- function(agent){

  report_data <- agent$report %>%
    dplyr::mutate(
      STATUS = dplyr::case_when(
        failed_validation == 0 ~ "PASS",
        TRUE ~ "FAIL"
      )
    ) %>%
    dplyr::select(
      validation_id,
      validation_check,
      columns_checked,
      validation_rule,
      rows_checked,
      STATUS,
      failed_validation,
      failure_rate,
      severity
    ) %>%
    dplyr::rename_with(~ gsub("_", " ", .x)) %>%
    dplyr::rename_with(toupper)

  title_section <- htmltools::div(
    style = "
      background:#d1d5db;
      padding:25px;
      border-radius:12px;
      margin-bottom:20px;
      text-align:center;
      border:1px solid #9ca3af;
      width:100%;
      box-sizing:border-box;
    ",

    htmltools::div(
      style = "
        font-size:32px;
        font-weight:800;
        color:#111827;
        letter-spacing:1px;
      ",
      "VALIDATION CHECK REPORT"
    ),

    htmltools::div(
      style = "
        font-size:15px;
        color:#374151;
        margin-top:10px;
        font-weight:600;
      ",
      paste0("Generated on: ", format(Sys.time(), "%d %B %Y | %I:%M %p"))
    ),

    htmltools::div(
      style = "
        margin-top:15px;
        display:inline-block;
        background:#dbeafe;
        padding:10px 18px;
        border-radius:8px;
        font-weight:bold;
        color:#1e40af;
      ",
      paste0("Total Validations: ", nrow(report_data))
    )
  )

  htmltools::browsable(
    htmltools::tagList(
      title_section,

      reactable::reactable(

        report_data,

        bordered = TRUE,
        striped = TRUE,
        highlight = TRUE,
        compact = TRUE,
        defaultPageSize = 10,

        columns = list(

          `VALIDATION ID` = reactable::colDef(
            show = FALSE
          ),


          STATUS = reactable::colDef(
            align = "center",
            cell = function(value){

              style <- if(value == "PASS"){
                list(background = "#d4edda", color = "#155724")
              } else {
                list(background = "#f8d7da", color = "#721c24")
              }

              htmltools::div(
                style = c(style, list(
                  padding = "6px",
                  borderRadius = "6px",
                  fontWeight = "bold"
                )),
                value
              )
            }
          ),

          SEVERITY = reactable::colDef(
            align = "center",
            cell = function(value){

              bg <- dplyr::case_when(
                value == "GOOD" ~ "#dcfce7",
                value == "WARNING" ~ "#fef3c7",
                TRUE ~ "#fee2e2"
              )

              color <- dplyr::case_when(
                value == "GOOD" ~ "#166534",
                value == "WARNING" ~ "#92400e",
                TRUE ~ "#991b1b"
              )

              htmltools::div(
                style = list(
                  background = bg,
                  color = color,
                  padding = "6px",
                  borderRadius = "6px",
                  fontWeight = "bold"
                ),
                value
              )
            }
          ),

          `FAILURE RATE` = reactable::colDef(
            align = "center",
            cell = function(value){

              htmltools::div(
                style = list(
                  display = "flex",
                  alignItems = "center",
                  gap = "10px"
                ),

                htmltools::div(
                  style = list(
                    flexGrow = 1,
                    background = "#e5e7eb",
                    borderRadius = "6px",
                    height = "20px"
                  ),

                  htmltools::div(
                    style = list(
                      width = paste0(value, "%"),
                      background = dplyr::case_when(
                        value <= 2 ~ "#22c55e",
                        value <= 20 ~ "#f59e0b",
                        TRUE ~ "#dc2626"
                      ),
                      height = "100%"
                    )
                  )
                ),

                htmltools::div(
                  paste0(value, "%")
                )
              )
            }
          )
        ),

        details = function(index){

          validation_id <- report_data$`VALIDATION ID`[index]

          failed_data <- agent$failed_rows[[validation_id]]

          reactable::reactable(
            failed_data,
            bordered = TRUE,
            striped = TRUE,
            compact = TRUE,
            defaultPageSize = 5
          )
        }
      )
    )
  )
}
