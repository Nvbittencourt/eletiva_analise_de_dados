# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Exercício 1

######## Questão 1: Extraia em padrão ff todas as bases de situação final de alunos disponíveis neste endereço: http://dados.recife.pe.gov.br/dataset/situacao-final-dos-alunos-por-periodo-letivo
library(ff)
library(ffbase)

ResultadoFinal_2020 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/9dc84eed-acdd-4132-9f1a-a64f7a71b016/download/situacaofinalalunos2020.csv'
ResultadoFinal_2019 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/3b03a473-8b20-4df4-8628-bec55541789e/download/situacaofinalalunos2019.csv'
ResultadoFinal_2018 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/8f3196b8-c21a-4c0d-968f-e2b265be4def/download/situacaofinalalunos2018.csv'
ResultadoFinal_2017 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/70c4e6fc-91d2-4a73-b27a-0ad6bda1c84d/download/situacaofinalalunos2017.csv'
ResultadoFinal_2016 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/f42a3c64-b2d7-4e2f-91e5-684dcd0040b9/download/situacaofinalalunos2016.csv'
ResultadoFinal_2015 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/264f0a37-ad1c-4308-9998-4f0bd3c6561f/download/situacaofinalalunos2015.csv'
ResultadoFinal_2014 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/0a2aec2f-9634-4408-bbb4-37e1f9c74aa1/download/situacaofinalalunos2014.csv'
ResultadoFinal_2013 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/95eb9ea8-cd75-4efa-a1ba-ba869f4e92b9/download/situacaofinalalunos2013.csv'
ResultadoFinal_2012 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/f6633c26-be36-4c27-81cb-e77d90316cff/download/situacaofinalalunos2012.csv'
ResultadoFinal_2011 <- 'http://dados.recife.pe.gov.br/dataset/ce5168d4-d925-48f5-a193-03d4e0f587c7/resource/9a694ab5-99ab-4ff1-ac6b-c97917c6a762/download/situacaofinalalunos2011.csv'

# Salvando em disco e vez da memória ram por meio da função read.csv.ffdf
extracao2020 <- read.csv.ffdf(file=ResultadoFinal_2020)
extracao2019 <- read.csv.ffdf(file=ResultadoFinal_2019)
extracao2018 <- read.csv.ffdf(file=ResultadoFinal_2018)
extracao2017 <- read.csv.ffdf(file=ResultadoFinal_2017)
extracao2016 <- read.csv.ffdf(file=ResultadoFinal_2016)
extracao2015 <- read.csv.ffdf(file=ResultadoFinal_2015)
extracao2014 <- read.csv.ffdf(file=ResultadoFinal_2014)
extracao2013 <- read.csv.ffdf(file=ResultadoFinal_2013)
extracao2012 <- read.csv.ffdf(file=ResultadoFinal_2012)
extracao2011 <- read.csv.ffdf(file=ResultadoFinal_2011)

######## Questao 2: Junte todas as bases extraídas em um único objeto ff

library(ffbase)

BasesJuntas <- ffdfrbind.fill(extracao2020, extracao2019, extracao2018, extracao2017
      , extracao2016, extracao2015, extracao2014, extracao2012
      , extracao2011)
head(BasesJuntas)

######## Questao 3: Limpe sua staging area

rm(BasesJuntas)


######## Questao 4: Exporte a base única em formato nativo do R
getwd()
saveRDS(BasesJuntas, "BasesTratadas/BasesJuntas.rds")
