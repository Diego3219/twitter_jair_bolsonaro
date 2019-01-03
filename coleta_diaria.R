################################################################
#                          pacotes                             #
library(dplyr)                                                 #
library(lubridate)                                             #
library(rtweet)                                                #
################################################################
#                        autenticacao                          #
# O nome que você deu para a sua aplicação                     #
appname <- "pacote_rtweet"                                     #
# api key (examplo fictício abaixo)                            #
key <- "y4YaumSBgIGa7dnBbgMqEwnLI"                             #
# api secret (examplo fictício abaixo)                         #
secret <- "P4X2GNxxImRza5wAcsci9jJQvtOTesnR5GwNK7NFUMPYudqlIa" #
# criando um token chamado "twitter_token"                     #
twitter_token <- create_token(                                 #
  app = appname,                                               #
  consumer_key = key,                                          #
  consumer_secret = secret)                                    #
################################################################
#                 variaveis para salvar o arquivo              #
# diretorio                                                    #
diretorio <- "dados_dias_janeiro/"                             #
# padrao do inicio do arquivo                                  #
inicio <- "tweet_dia_"                                         #
# data da coleta                                               #
dia <- Sys.Date()                                              #
# extensao que será salvo o arquivo                            #
extensao <- ".RDS"                                             #
# cria expressao para salvar o arquivo                         #
expressao <- paste0(diretorio,inicio, dia, extensao)           #
################################################################
#                       coleta tweet's                         #
# coleta 100 tweet's                                           #
coleta <- get_timeline("jairbolsonaro", 100)                   #
# cria coluna com a data do dia para filtrar                   #
coleta <- coleta %>%                                           #
  mutate(dia = lubridate::as_date(created_at))                 #
# filtra o dataset com os tweet's do dia                       #
coleta <- coleta %>%                                           #
  filter(dia == Sys.Date())                                    #
# salva o dataset com os tweet's do dia                        #
saveRDS(coleta, expressao)                                     #
################################################################
#                      limpa ambiente                          #
# limpa variaveis                                              #
rm(list = ls())                                                #
# limpa a memoria                                              #
gc(reset = T)                                                  #
################################################################