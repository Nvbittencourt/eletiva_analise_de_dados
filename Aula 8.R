# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividades da aula 8

##### 1) Valores ausentes

library(data.table)
library(funModeling) 
library(tidyverse) 
# NA randômico ou não?
# Shadow matrix e teste de aletoriedade

RedeSaudeRec <- fread('http://dados.recife.pe.gov.br/dataset/40638fd0-418e-4eeb-8871-b4ed92a973c2/resource/d05f6ffa-304b-4a28-bd03-1ffb26cbf866/download/20210411_rede_saude_dados_abertos.csv')
status(RedeSaudeRec)

dim(RedeSaudeRecCompleto <- na.omit(RedeSaudeRec))

dim(RedeSaudeRecCompleto <- RedeSaudeRec %>% filter(!is.na(cnes)))

## Shadow Matrix da nossa base de covid19 com adaptações

RedeSaudeRecNA <- as.data.frame(abs(is.na(RedeSaudeRec))) # cria a matriz sombra da base de covid19

RedeSaudeRecNA <- RedeSaudeRecNA[which(sapply(RedeSaudeRecNA, sd) > 0)] # mantém variáveis com NA
round(cor(RedeSaudeRecNA), 3) # calcula correlações

# modificação já que  temos uma base numérica
RedeSaudeRecNA <- cbind(RedeSaudeRecNA, bairro = RedeSaudeRec$bairro) # trazemos uma variável de interesse (nesse caso, o bairro) de volta pro frame
RedeSaudeRecNA_bairro <- RedeSaudeRecNA %>% group_by(bairro) %>% summarise(across(everything(), list(sum))) # em quais bairros NA se concentra mais


##### 2) Outliers

library(dplyr)
library(data.table)
install.packages('plotly')
library(plotly)

RedeSaudeRecBair <- RedeSaudeRec %>% count(bairro, sort = T, name = 'unidades') %>% mutate(casos2 = sqrt(unidades), casosLog = log10(unidades))
plot_ly(y = RedeSaudeRecBair$casos, type = "box", text = RedeSaudeRecBair$bairro, boxpoints = "all", jitter = 0.3)


##### 3) Imputação

library(data.table)

# NA aleatórios
mtcarsDT <- mtcars %>% setDT() #copia base mtcars, usando a data.table

(mtcarsNASeed <- round(runif(10, 1, 50))) # criamos 10 valores aleatórios

(mtcarsDT$cyl[mtcarsNASeed] <- NA) # imputamos NA nos valores aleatórios

# tendência central
library(Hmisc) # biblio que facilita imputação de tendência central
mtcarsDT$cyl <- impute(mtcarsDT$cyl, fun = mean) # média
mtcarsDT$cyl <- impute(mtcarsDT$cyl, fun = median) # mediana

is.imputed(mtcarsDT$cyl) # teste se o valor foi imputado
table(is.imputed(mtcarsDT$cyl)) # tabela de imputação por sim / não

# predição
mtcarsDT$cyl[mtcarsNASeed] <- NA # recolocamos os NA

regMtcars <- lm(cyl ~ ., data = mtcarsDT) # criamos a regressão
MtcarsNAIndex <- is.na(mtcarsDT$cyl) # localizamos os NA
mtcarsDT$cyl[MtcarsNAIndex] <- predict(regMtcars, newdata = mtcarsDT[MtcarsNAIndex, ]) # imputamos os valores preditos

## Hot deck
# imputação aleatória
mtcarsDT$cyl[mtcarsNASeed] <- NA # recolocamos os NA

(mtcarsDT$cyl <- impute(mtcarsDT$cyl, "random")) # fazemos a imputação aleatória

# imputação por instâncias
mtcarsDT$cyl[mtcarsNASeed] <- NA # recolocamos os NA

install.packages('VIM')
library(VIM)
mtcarsDT2 <- kNN(mtcarsDT)

view(iris)
