# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt

# Atividade: Criando dataframes

install.packages('eeptools')
library(eeptools)

# Vetores
nome <- c('julia', 'Paula', 'Maria Clara', 'Renata')
signo <- c('cancer','cancer', 'aries', 'virgem')
nascim <- as.Date(c('1990-06-24', '1990-06-30', '1992-04-14', '1989-09-02'))

# Cálculo da idade com base no vetor 'idade
idade <- round( age_calc(nascim, units = 'years'))

#Criação do data frame lista_sign, que categoriza os signos das amigas
lista_sign <- data.frame(amigas = nome,
     zodiaco = signo,
     nascimento = nascim,
     idades = idade)

#Visualização do data.frame
View(lista_sign)
