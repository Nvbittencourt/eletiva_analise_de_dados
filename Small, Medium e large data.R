# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Small, Medium e Large Data

# Atividade I: smal e medium data (otimização de processos com fread)

library(data.table)
getwd()
vacinados_maio_recife <- 'vacinados.csv'

# extração via read.csv

system.time(tempoCsv <- read.csv2(vacinados_maio_recife))
# Tempo Csv:   usuário   sistema decorrido 
#                4.44      0.33      5.80 
# ler apenas as primeiras 20 linhas
amostra <- read.csv2(vacinados_maio_recife, nrows=20) #criando amostra para leitura de 20 colunas 

amostraClasse <- sapply(amostra, class) #cerifica a classe da amostra

# fazemos a leitura passando as classes de antemão, a partir da amostra
system.time(amostraCsv <- data.frame(read.csv2('vacinados.csv', colClasses=amostraClasse) ) )  
# Tempo Csv com amostra :   usuário   sistema decorrido 
#                             2.95      0.32      3.28 

#Processo de Leitura automátia com Fread

system.time(tempoFread <- fread(vacinados_maio_recife))
# A diferença é grande!   usuário   sistema decorrido 
#                          0.75      0.06      0.63 

############################# Atividade II: Large data ############################

library(data.table)
install.packages('ff')
library(ff)
install.packages('ffbase')
library(ffbase)

library(ff)
library(ffbase)

vacinados_maio_recife <- 'vacinados.csv'

# criando o arquivo ff
system.time(Tempoffdf <- read.csv.ffdf(file=vacinados_maio_recife)) #disco e não memória Ram

class(extracaoffdf) # verifica a classe do objeto

object.size(tempoFread) # 70708056 bytes

object.size(Tempoffdf) # 121704880 bytes

sum(Tempoffdf[,3]) 

# para outras mais complexas, como a regressão, precisamos amostrar:.
Tempoffdf_Amostra <- Tempoffdf[sample(nrow(Tempoffdf), 100) , ]

lm(c ~ ., Tempoffdf_Amostra) 

