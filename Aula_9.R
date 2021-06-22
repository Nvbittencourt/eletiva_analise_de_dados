# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividades da aula 9

##### 1)Juntando e buscando textos
install.packages("fuzzyjoin")
library(fuzzyjoin)
library(dplyr)
library(tidyr)

# Base 1

nome <- c("Nathi", "Paula", "Carol", "Bebella", "Fernanda", "Galvão", "Renatinho")
signo <- c("Virgem", "Câncer", "Gêmeos", "Escorpião", "Peixes", "Libra", "Capricórnio")

Horóscopo_1 <- data.frame(nome, signo)

# Base 2

nome <- c("Nathi", "Paula", "Carol", "Bebella", "Fernanda", "Galvão", "Renatinho")
ascendente <- c("Peixes", "Aquário", "Câncer", "Escorpião", "Virgem", "Capricórnio", "Touro")

Horóscopo_2 <- data.frame(nome, ascendente)          

# juntando base 1 e 2

Horóscopo <- stringdist_join(Horóscopo_1, Horóscopo_2, mode = 'left')


compatíveis <- c("Paula", "Galvão", "Renatinho")

Horóscopo_3 <- Horóscopo %>% mutate(tag_nome = ifelse(grepl(paste(compatíveis, collapse="|"), nome), 'compatível', "incompatível"))

##### 2) Trabalhando com textos

install.packages("pdftools")
library(pdftools)
install.packages("textreadr")
library(textreadr)
library(dplyr)
install.packages("stringr")
library(stringr)

setwd("C:/Users/Pc/OneDrive/Área de Trabalho/analise dados/Aula_9")
getwd()

documento <- read_pdf("doc.pdf", ocr = T)

(datas_mod <- str_replace_all(string = documento, pattern = "/", replacement = "-"))

(datas <- str_extract_all(datas_mod, "\\d{2}/\\d{2}"))
