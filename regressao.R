##### Objetos e funcoes no R #####

#link do passo a passo: https://medium.com/x8-the-ai-community/linear-regression-in-r-example-in-code-a84af29222fb

#Baixando dataset e pacotes do R para fazer uma regressao

install.packages("datarium")
install.packages("caTools")
install.packages("ggplot2") 
install.packages("GGally")

library("datarium")
library("GGally")
library("caTools")
library("ggplot2")

#Carregando o dataset "marketing" em "datarium"
data("marketing", package = "datarium")

data_size = dim(marketing)

#Observando valores estatísticos do dataset "marketing", que mostra o impacto de três mídias em vendas (YouTube, Facebook e Jornais)

summary(marketing)

#graficos

plot(marketing)

#Pareando cada elemento com as correlacoes
ggpairs(marketing)

#Modelo para regressao
Modelo <- lm(sales ~ youtube + facebook + newspaper, data = marketing)
summary(Modelo)

# Podemos observar n coeficiente "estimativas" que as mudanças nos orçamentos de publicidade do YouTube e Facebook estão significativamente associadas a mudanças nas vendas, enquanto as mudanças no orçamento de jornal, não.

