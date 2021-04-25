# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Exercício 1

semente <- addTaskCallback(function(...) {set.seed(123);TRUE}) # atribui a tarefa a variável semente

semente # chama a semente

#Criaca de dataframe com + de 500 casos, sendo duas variaveis normais com "sd" diferentes
variav1 <- rnorm(500, sd = 1)
variav2 <- rnorm(500, sd = 1.2)

#Criaca de variavel de poissom
variavpoisson <- rpois(500, lambda = 2)

#Criacao de variavel binomial negativa
variavbinneg <- rnbinom(500, size = 0.5, prob = 0.2)

#Criacao de variavel binomial
variavbin <- rbinom(500, size = 1, prob = 0.5)

# Criacao de variavel qualit que apresenta um valor bin 0 e outro quando bin é 1  
variavquali<- ifelse(variavbin == 1, 'estude', 'descanse')

# Criação de variavel indexada
variavindex <- ifelse(variav2 < "0", "descanse", "estude")

# Criacao do dataframe com as variaveis criadas
dataframe <- data.frame(
  variav1 = variav1,
  variav2 = variav2,
  variavpoisson = variavpoisson,
 variavbinneg = variavbinneg,
  variavbin = variavbin,
  variavquali = variavquali,
  variavindex = variavindex
)
View(dataframe)

# Centralizacao das variaveis normais
centralvariav1 <- variav1 - mean(variav1)
centralvariav1 <- variav2 - mean(variav2)

# Troca dos zeros por um nas variáveis de contagem (variavpoisson, variavbinneg)
dataframe$variavpoisson[dataframe$variavpoisson == 0] <- 1

dataframe$variavbinneg[dataframe$variavbinneg == 0] <- 1

# Amostra de 100 casos
Amostra100 <- dataframe[sample(nrow(dataframe), 100), ]
View(Amostra100)

removeTaskCallback(semente)
