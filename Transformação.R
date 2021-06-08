# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Transformacao

####### 1) Descoberta
library(tidyverse)
install.packages('funModeling')
library(funModeling)

glimpse(mtcars) # Para olhar os dados 
status(mtcars) #para ver a estrutura dos dados
freq(mtcars) # None of the input variables are factor nor character
plot_num(mtcars) # para explorar as variáveis numéricas
profiling_num(mtcars) # estatísticas das variáveis numéricas

####### 2) Estruturacao
library(data.table)
library(dplyr)
library(tidyverse)

general_data <-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv")

WesternEurope_countries <- c('France','Belgium','Germany', 'Netherlands', 'Luxembourg', 'Austria', 'Switzerland', 'Monaco', 'Lichtenstein')
WesternEurope <- general_data %>% filter(location %in% WesternEurope_countries)

mWEurope <- WesternEurope %>% group_by(location) %>% mutate(row = row_number()) %>% select(location, new_cases, row) 

result <- mWEurope %>% group_by(location) %>% filter(row == max(row))
mWEurope <- mWEurope %>% filter(row<=min(result$row)) 

# De long para wide
mWEurope_wide <- mWEurope %>% pivot_wider(names_from = row, values_from = new_cases) %>% remove_rownames %>% column_to_rownames(var="location") 

####### 3) Limpeza

WesternEurope <- WesternEurope %>% select(location, new_cases, new_deaths)
status(WesternEurope) # estrutura dos dados (missing etc)
freq(WesternEurope) # frequência das variáveis fator
plot_num(WesternEurope) # exploração das variáveis numéricas
profiling_num(WesternEurope) # estatísticas das variáveis numéricas

WesternEurope %>% filter(WesternEurope < 0)

WesternEurope <- WesternEurope %>% filter(new_cases>=0)

####### 4) Enriquecimento

# Aprendendo a usar a funcao join (inner join, outer join, left outer join, right outer join, full outer join)
library(dplyr)

id.empregado <- 1:9
nome.empregado <- c('Renato', 'Miguel', 'Paulo', 'Patrícia', 'Inês', 'Saulo', 'Diego', 'Maria', 'Jose')
idade <- c(30, 31, 29, 30, 25, 30, 30, 35, 24)
uf <- c('MG', 'DF', 'CE', 'DF', 'DF', 'DF', 'RJ', 'SP', 'RS')
id.cargo <- c(4, 4, 4, 4, 5, 4, 6, 3, 1)
(empregados <- data.frame(id.empregado, nome.empregado, idade, uf, id.cargo))
id.cargo <- 1:7
nome.cargo <- c('Técnico', 'Assistente', 'Consultor', 'Analista', 'Auditor', 'Gerente', 'Gestor')
salario <- c(7000, 4000, 15000, 11000, 10000, 13000, 20000)
(cargos <- data.frame(id.cargo, nome.cargo, salario))

merge.r.base <- merge(empregados, cargos) #funcao nativa do R

join.dplyr <- inner_join(empregados, cargos) #funcao com dplyr


####### 5) Validacao
install.packages('validate')
library(validate)

WesternEurope_regras <- validator(new_cases >= 0, new_deaths >= 0) 

WesternEurope_validacao <- confront(WesternEurope, WesternEurope_regras)
summary(WesternEurope_validacao) 

plot(WesternEurope_validacao) 

####### 6) Tipos de fatores

# Criar uma estrutura de Fatores

Covid_variantes <- factor(c("alfa", "beta", "gama", "delta"))
Covid_pais_variante <- c(Reino_Unido = 'alfa', Africa_do_Sul = 'beta', Brasil = 'gama', Índia = 'delta')
(Variantes_países <- factor(Covid_variantes, levels = Covid_pais_variante, labels = names(Covid_pais_variante)))

is.numeric(Variantes_países)
as.numeric(Variantes_países)
as.integer(Variantes_países)
as.character(Variantes_países)

###### 7) Mais fatores

# Criar processo de one hot encoding ou de discretização
# e também a transformação dos fatores de uma base de dados em 3 tipos: 
# mais frequente, segundo mais frequente e outros.

install.packages("ade4")
install.packages("arules")
installed.packages("forcats")
library(ade4)
library(arules)
library(forcats)

getwd()
facebook <- read.table("dataset_Facebook.csv", sep=";", header = T)

str(facebook) 

# conversão em fatores

for(i in 2:7) {facebook[,i] <- as.factor(facebook[,i]) }

str(facebook) 

# filtro por tipo de dado

factorsFacebook <- unlist(lapply(facebook, is.factor)) 

facebookFactor <- facebook[ , factorsFacebook] 

str(facebookFactor) 

# Hot one coding

facebookDummy <- acm.disjonctif(facebookFactor)  

# forcats - usando tidyverse para fatores

fct_count(facebookFactor$Type) 

fct_lump(facebookFactor$Type, n = 2) 

###### 8) Data Table

library(data.table)
library(dplyr)

# dados

mtcarsDT <- mtcars %>% setDT() 
class(mtcarsDT)

#Regressao Linear

mtcarsDT[ , lm(formula = mpg ~ cyl + disp + hp + drat)]

summary(mtcarsDT)
plot(mtcarsDT)

###### 9) Pacote Dplyr

library(dplyr)

count(facebook, Type) 

# sumários com agrupamentos
facebook %>% group_by(Type) %>% summarise(avg = mean(like))

### Transformação de Casos

# seleção de casos
facebook %>%  filter(Type != "Photo") %>% summarise(avg = mean(like))
facebook %>%  filter(Type != "Photo") %>% group_by(Type, Paid) %>% summarise(avg = mean(like))

# ordenar casos
arrange(facebook, like) # ascendente
arrange(facebook, desc(like)) # descendente

### Transformação de Variáveis

# seleção de colunas
facebook %>% select(like, Type, Paid) %>% arrange(like)

# novas colunas
facebook %>% mutate(likePerLifeTime = like/Lifetime.Post.Total.Reach)

# renomear
facebook %>% rename(Reach = Lifetime.Post.Total.Reach)