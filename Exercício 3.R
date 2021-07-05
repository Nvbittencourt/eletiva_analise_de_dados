# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Exercício 3

######## 1) Extraia a base geral de covid em Pernambuco 

BaseGeral <- read.csv2(file= 'basegeral.csv')

######## 2) Corrija os NAs da coluna sintomas através de imputação randômica 

library(data.table)
library(funModeling) 
library(tidyverse) 

status(BaseGeral)
BaseGeral$sintomas <- impute(BaseGeral$sintomas, "random")

######## 3) Calcule, para cada município do Estado, o total de casos confirmados e negativos:

CaosConfirmados <- BaseGeral %>% filter(classe == "CONFIRMADO") %>% group_by(municipio) %>% count(classe)

CasosNegativos <- BaseGeral %>%  filter(classe == "NEGATIVO") %>% group_by(municipio) %>% count(classe)

######## 4) Crie uma variável binária se o sintoma inclui tosse ou não e calcule quantos casos confirmados e negativos tiveram tosse como sintoma

#Criando variável dummy
library(validate)
library(tidyverse)
library(Hmisc)
library(zoo)

BaseGeral <- BaseGeral %>% mutate(TosseSintoma = ifelse(grepl(paste("TOSSE", collapse="|"), sintomas), '1', '0'))

ConfTosse<- BaseGeral %>% filter(classe == "CONFIRMADO") %>% group_by(TosseSintoma) %>% count(classe)

NegatTosse <- BaseGeral %>% filter(classe == "NEGATIVO") %>% group_by(TosseSintoma) %>% count(classe)



######## 5) Agrupe os dados para o Estado, estime a média móvel de 7 dias de confirmados e negativos

BaseGeral <- BaseGeral %>% mutate(confMM7 = round(rollmean(x = (classe == "CONFIRMADO"), 7, align = "right", fill = NA), 2))

BaseGeral <- BaseGeral %>% mutate(negMM7 = round(rollmean(x = (classe == "NEGATIVO"), 7, align = "right", fill = NA), 2))




