#objetivo: listar arquivos na pasta
#criação 2024-03-10


# bibliotecas -------------------------------------------------------------

require(tidyverse)


# parametros --------------------------------------------------------------

extratos_folder <- "C:/Users/diego/OneDrive/Documentos/finanças/investimentos/corretagem/tesouro direto"
arq_nome_ini <- "ExtratoConsolidado_DIEGO MOURA SILVA GUIMARAES_"


# dependencias ------------------------------------------------------------

source("../src/read_excel.R")


# lista arquivos ------------------------------------------------------------

file_paths <- fs::dir_ls(extratos_folder,
                         all = FALSE,
                         type = "file",
                         #glob = "*.xlsx$",
                         regexp = glue::glue("{arq_nome_ini}.*\\.xlsx$"))

files <- fs::path_file(file_paths) |>
  fs::path_ext_remove() |>
  str_remove_all(arq_nome_ini)

extratos_df <- tibble(path = file_paths,
                      file = files) |>
  separate_wider_delim(file,
                       delim = "_",
                       names = c("mes_ref", NA, "save_date", "save_time"),
                       too_few = "align_start",
                       too_many = "drop") |>
  mutate(mes_ref = ym(mes_ref),
         save_date = ymd(save_date) + hm(str_replace(save_time, "-", ":"))) |>
  arrange(mes_ref, desc(save_date)) |>
  distinct(mes_ref, .keep_all = TRUE) |>
  mutate(content = map(path, read_extrato)) |>
  select(-c(path, save_time)) |>
  unnest_wider(content) |>
  unnest_longer(papel:qt_bloqueada) |>
  group_by(papel, vencimento) |>
  mutate(mov = sign(vr_aplicado - lag(vr_aplicado)),
         var_bruta = vr_bruto - lag(vr_bruto),
         var_perc = ( vr_bruto / lag(vr_bruto) - 1 ) * 100,
         var_bruta_acum = vr_bruto - lag(vr_aplicado),
         var_perc_acum = ( vr_bruto / lag(vr_aplicado) - 1 ) * 100,
         var_liq = vr_liquido - lag(vr_liquido),
         var_liq_acum = vr_liquido - lag(vr_aplicado))

atualizacao <- list(
  mes = max(extratos_df$mes_ref),
  data = max(extratos_df$save_date)
)
tz(atualizacao$data) <- Sys.timezone(location = TRUE)
