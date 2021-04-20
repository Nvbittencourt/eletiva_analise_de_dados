# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Indexacao de objetos

#Fazendo indexacoes pelo dataframe mtcars
data.frame(mtcars) #dataframe próprio do R
View(mtcars) #viasualizando em tabela
mtcars$hp # o $ separa somente a coluna hp
mtcars[ ,'hp'] #mostra todas as linhas e somente a coluna hp
mtcars[ , -8] #mostra todas as linhas e colunas, menos a coluna 8

#Operadores logicos com o dataframe mtcars
mtcars$disp <= 70 #valores da col disp menores ou iguais a 70
which(mtcars$disp >= 70) #lnhas em que os valores da col disp são maiores ou iguais a 70
mtcars$gear
which(mtcars$gear <= 3)
match(mtcars$gear, '3')
