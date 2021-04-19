# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Amostragem e Bootsraping

# Funcao sample sem reposicao para amostragem
sample(distnormsimul, 15, replace = FALSE)

#'distnormsimul' utilizada na atividade anterior de simulacao e repeticao

# Bootstraping com função replicate
set.seed(412)

#Funcao replicate com reposicao de 10x da amostra
bootsDistNormal10 <- replicate(10, sample(distnormsimul, 10, replace = TRUE)) 
bootsDistNormal10

# Calculo de estatística com bootstrapping (10 amostras 10 casos)
mediaBootsNormal10 <-replicate(10, mean(sample(distnormsimul, 10, replace = TRUE)))

# Comparacao da media com funcao boots (10x) e com os dados originais
mean(mediaBootsNormal10) 
mean(distnormsimul) 
