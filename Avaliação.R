# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Avaliação

######## 1) 1. Extraia a base geral de covid em Pernambuco disponível em
######## https://dados.seplag.pe.gov.br/apps/corona_dados.html.

covidPE <- read.csv("https://dados.seplag.pe.gov.br/apps/basegeral.csv", sep = ";", na.strings = "")


######## 2) Calcule, para cada município do Estado, o total de casos confirmados 
######## e o total de óbitos por semana epidemiológica [atenção, você terá de 
######## criar uma variável de semana epidemiológica com base na data].

library(zoo)
library(lubridate)
library(tidyverse)

# 2.1 data

covidPE$dt_notificacao <- as.Date(covidPE$dt_notificacao, format = "%Y-%m-%d") 
class('dt_notificacao')

confirmado <- c("CONFIRMADO")
obito <- c("OBITO")
covidPE$epiweek <- epiweek(covidPE$dt_notificacao)
covidPEconfirmados <- covidPE %>% filter(classe %in% confirmado)
covidPEobitos <- covidPE %>% filter(evolucao %in% obito)

# por semana epidemiológica (epiweek)
covidPEconfirmados %>% group_by(municipio) %>% count(epiweek)
covidPEobitos %>% group_by(municipio) %>% count(epiweek)

##### 2.2 semana
epiweek(covidPE$dt_notificacao)
covidPE_Semana <- covidPE %>% mutate("CasosSemana" = epiweek(covidPE$dt_notificacao))

# 2.3 casos confirmados por semana
Confirmados <- covidPE_Semana %>% filter(classe == "CONFIRMADO") %>% group_by(municipio) %>% count(`CasosSemana`) 

# 2.4 óbitos confirmados por semana
Obitos <- covidPE_Semana %>% filter(evolucao == "OBITO") %>% group_by(municipio) %>% count(`CasosSemana`)


######## 3) Enriqueça a base criada no passo 2 com a população de cada município
######## , usando a tabela6579 do sidra ibge.

# 3.1

library(readxl)
ibge <- read_excel("tabela6579.xlsx")
# Retirar primeiras linhas e transformar nome da variavel

ibge <- ibge[-(1:4), ] #Retirar linha

ibge <- rename(ibge, municipio = `Tabela 6579 - População residente estimada`) #Renomear
ibge <- rename(ibge, populacao = `...2`) #Renomear
ibge$populacao <- as.numeric(ibge$populacao) # Transformar em numerico

# Corrigir espaco, letra maiscula e retirar os acentos das variaveis ===#

# Funcao para remover espaco em branco
trim <- function (x) gsub("^\\s+|\\s+$", "", x) 
ibge$municipio <- trim(ibge$municipio)

# Funcao para colocar em maiscula
ibge$municipio <- toupper(ibge$municipio) # coloca maiscula

# Listar todos os acentos

unwanted_array <- list(    'S'='S', 's'='s', 'Z'='Z', 'z'='z', 'À'='A', 'Á'='A', 'Â'='A', 'Ã'='A', 'Ä'='A', 'Å'='A', 'Æ'='A', 'Ç'='C', 'È'='E', 'É'='E',
                           'Ê'='E', 'Ë'='E', 'Ì'='I', 'Í'='I', 'Î'='I', 'Ï'='I', 'Ñ'='N', 'Ò'='O', 'Ó'='O', 'Ô'='O', 'Õ'='O', 'Ö'='O', 'Ø'='O', 'Ù'='U',
                           'Ú'='U', 'Û'='U', 'Ü'='U', 'Ý'='Y', 'Þ'='B', 'ß'='Ss', 'à'='a', 'á'='a', 'â'='a', 'ã'='a', 'ä'='a', 'å'='a', 'æ'='a', 'ç'='c',
                           'è'='e', 'é'='e', 'ê'='e', 'ë'='e', 'ì'='i', 'í'='i', 'î'='i', 'ï'='i', 'ð'='o', 'ñ'='n', 'ò'='o', 'ó'='o', 'ô'='o', 'õ'='o',
                           'ö'='o', 'ø'='o', 'ù'='u', 'ú'='u', 'û'='u', 'ý'='y', 'ý'='y', 'þ'='b', 'ÿ'='y' )

# Funcao para retirar os acentos 
for(i in seq_along(unwanted_array))
ibge$municipio <- gsub(names(unwanted_array)[i],unwanted_array[i],ibge$municipio)

# Copiar os ultimos caracteres para criar UF
ibge$UF <- str_sub(ibge$municipio,-4, -1) # "-" indica que serao os ultimos caracteres
ibge_pe <- subset(ibge, UF =="(PE)")

#Retirar os Ultimos digitos da coluna
ibge$municipio <- str_sub(ibge$municipio, 1, str_length(ibge$municipio)-4)

status (ibge)

# Tirando os parentesis
ibge$uf <- gsub("[()]", " ", ibge$uf)

# Juntando as bases


######## 4) Calcule a incidência (casos por 100.000 habitantes) e letalidade 
######## (óbitos por 100.000 habitantes) por município a cada semana epidemiológica

covidPEconfirmados %>% group_by(municipio) %>% count(epiweek) %>% mutate(n = n/100000)
covidPEobitos %>% group_by(municipio) %>% count(epiweek) %>% mutate(n/100000)

