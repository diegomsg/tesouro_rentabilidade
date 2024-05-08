# Objetivo: Gerar relatório em quarto


# quarto render ------------------------------------------------------------

report_quarto_file <- "report/report.qmd"

system(command = paste0("quarto render ", report_quarto_file),
       intern = FALSE,
       wait = TRUE,
       show.output.on.console = TRUE,
       invisible = TRUE,
       timeout = 200)


# parameters --------------------------------------------------------------

last_month <- lubridate::today() + lubridate::dmonths(-1)
date_ref <- lubridate::as_date(last_month) |>
  stringr::str_replace_all("-", "") |>
  stringr::str_sub(1, 6)

input_filepath <- fs::path("report/report.html")
output_path <- fs::path("output")
output_filepath <- fs::path(output_path,
                            paste0("Tesouro_analise_", date_ref, ".html"))


# output ------------------------------------------------------------------

fs::file_copy(path = input_filepath,
              new_path = output_filepath,
              overwrite = TRUE)


# apaga temp --------------------------------------------------------------

fs::file_delete(input_filepath)
