#objetivo: ler o arquivo excel
#criação 2024-03-10


# bibliotecas -------------------------------------------------------------

require(tidyverse)


# parametros --------------------------------------------------------------

colunas <- c("papel", "vencimento", "vr_aplicado", "vr_bruto", "vr_liquido", "qt", "qt_bloqueada")
tipos <- c("text", "date", "numeric", "numeric", "numeric", "numeric", "numeric")

# lê arquivo ------------------------------------------------------------

read_extrato <- function(file_path) {
  col_names <- c("papel", "vencimento", "vr_aplicado", "vr_bruto", "vr_liquido", "qt", "qt_bloqueada")
  col_types <- c("text", "date", "numeric", "numeric", "numeric", "numeric", "numeric")
  readxl::read_xlsx(path = file_path,
                    progress = T,
                    skip = 4,
                    col_names = col_names,
                    col_types = col_types) |>
    suppressWarnings() |>
    drop_na() |>
    mutate(vencimento = as_date(vencimento)) %>%
    bind_rows(summarise(., across(where(is.numeric), sum),
                        across(where(is.character), ~'Total')))
}
