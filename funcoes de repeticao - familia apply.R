# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: funcoes de repeticao - família apply

data.frame(mtcars)
# média de cada variável do data frame mtcars
apply(mtcars[ , ], 2, mean) #1 para linha, 2 para colunas 
lapply(mtcars[, ], mean) 
sapply(mtcars[, ], mean) 

par(mfrow = c(2, 2)) # prepara a área de plotagem para receber 4 plots

sapply(mtcars[ , 1:4], hist)
mapply(hist, mtcars[ , 1:4], MoreArgs=list(main='Histograma',
                                           xlab = 'Valores', 
                                           ylab = 'Frequência'))
