# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Simulacoes e sequencias_ criação de variávem normal, binomial 
#e de index

# Verificando orgem do arquivo
getwd()

# Funcao addtaskcallback para deixar a a função set.seed fixa
# Assim, as simulacoes permanecem as mesmas
TarefaSemente <- addTaskCallback(function(...) {set.seed(123); TRUE})
TarefaSemente

#Simulacao de distribuicao normal
distnormsimul<- rnorm(100)
summary(distnormsimulacao)

#Simulacao de distribuicao binomial simulada
distbinomsimul <- rbinom(100, 1, 0.7)

#Indexando uma sequencia
index_sim <- seq(1, length(distnormsimul))
summary(index_sim)

# Funcao removeTaskCallBack para remover a tarefa criada
removeTaskCallback(TarefaSemente)
