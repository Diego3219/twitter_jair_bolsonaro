# pacotes
library(tidytext)
library(tm)
library(tidyverse)
library(lubridate)

#########################################################################################################
# carrega dados para analise
tweet_dia_01_01_2019 <- readRDS("C:/Users/DIEGO/Documents/R/twitter_jair_bolsonaro/dados_dias_janeiro/tweet_dia_2019-01-01.RDS")

df <- tweet_dia_01_01_2019

# removendo acentuação das palavras
df$text <- stringi::stri_trans_general(df$text,'Latin-ASCII')

# extraindo as stopwords conforme o pacote rtweet
words_pt <- stopwordslangs %>% 
  filter(lang == "pt")

texto <- df %>% 
  select(created_at,text)

texto <- texto %>% 
  unnest_tokens(word, text)

texto <- texto %>% 
  anti_join(words_pt, by = "word")



# plotando as top 15 palavras.
texto %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(x = "Contagem",
       y = "Palavras únicas",
       title = "Contagem de palavras únicas encontradas nos tweets")


# glimpse(df)

#Transformando em Corpus

df <- Corpus(VectorSource(df$text))

#Explorando o Corpus

inspect(df[4:7])


######################################################################################################
# analise de emojis

# rtweet::emojis


######################################################################################################
#Limpando os dados


#removepontuação
df <- tm_map(df, removePunctuation)
#removeespaços
df <- tm_map(df, stripWhitespace)
#removenumeros
df <- tm_map(df, removeNumbers)
#remover urls
removeURL <- function(x)gsub("http[[:alnum:]]*","",x)
df <- tm_map(df, removeURL)
#tudo em letras minúsculas
df <- tm_map(df, tolower)
#df_test <-  tm_map(df, PlainTextDocument)
df <- tm_map(df, removeWords, stopwords("en"))

#verifica as alterações
inspect(df[4:7])