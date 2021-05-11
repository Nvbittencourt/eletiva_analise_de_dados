# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Extração com scraping

library(rvest)
library(dplyr)

#Página sobre Billie Holiday no wikipedia
url <- "https://en.wikipedia.org/wiki/Billie_Holiday" 

#Comando para leitura das tabelas e de links
urlTables <- url %>% read_html %>% html_nodes("table")
#A tabela desejada é a de n. 2
urlLinks <- url %>% read_html %>% html_nodes("link")

#Transformando a tabela desejada em dataframe
BillienaTV <- as.data.frame(html_table(urlTables[2]))
