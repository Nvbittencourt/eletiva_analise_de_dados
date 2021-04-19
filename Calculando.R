# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Calculando

#Simulacao de distribuicao normal
distnormsimul<- rnorm(100)

# O summary já indica os valores estatísticos em relação à media, 1 e 3 qrt, etc
summary(distnormsimul)

#cálculo variância
var(distnormsimul)

#histograma de uma distribuição normal perfeita
hist(distnormsimul)

#criando objeto para distribucao de poisson
distpoiss <- rpois(1000, 3)
hist(distpoiss)

#Centralizacao do objeto distpoiss
distpoisscentraliz <- distpoiss - mean(distpoiss)

#Forçou para distribuição ficar normal
hist(distpoisscentraliz)
