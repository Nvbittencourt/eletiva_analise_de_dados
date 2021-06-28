# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividades da aula 10

########## 1) Introdução a datas e tempos

# Conversão para data
(str(minhaData1 <- as.Date(c("1990-08-25 17:55", "1998-01-07 14:15")) ) )

# Conversão para POSIXct
(str(minhaData2 <- as.POSIXct(c("1990-08-25 17:55", "1998-01-07 14:15")) ) )
unclass(minhaData2) # observamos o POSIXct no formato original (segundos)

# Conversão para POSIXlt
(str(minhaData3 <- as.POSIXlt(c("1990-08-25 17:55", "1998-01-07 14:15")) ) )
unclass(minhaData3) # observamos o POSIXlt no formato original (componentes de tempo)

### Extrações de Componentes
library(lubridate)

year(minhaData3) # ano

month(minhaData3) # mês

month(minhaData3, label = T) # mês pelo nome usando label = T

wday(minhaData2, label = T, abbr = T) # dia da semana abreviado

year(minhaData2)

########## 2) Datas na Prática 

url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' # passar a url para um objeto
covidBR = read.csv2(url, encoding='latin1', sep = ',') # baixar a base de covidBR

covidPE <- subset(covidBR, state == 'PE') # filtrar para Pernambuco

str(covidPE) # observar as classes dos dados

covidPE$date <- as.Date(covidPE$date, format = "%Y-%m-%d") # modificar a coluna data de string para date

str(covidPE) # observar a mudança na classe

covidPE$dia <- seq(1:length(covidPE$date)) # criar um sequencial de dias de acordo com o total de datas para a predição

predDia = data.frame(dia = covidPE$dia) # criar vetor auxiliar de predição
predSeq = data.frame(dia = seq(max(covidPE$dia)+1, max(covidPE$dia)+180)) # criar segundo vetor auxiliar 

predDia <- rbind(predDia, predSeq) # juntar os dois 

install.packages("drc")
library(drc) # pacote para predição

fitLL <- drm(recovered ~ dia, fct = LL2.5(),
             data = covidPE, robust = 'mean') # fazendo a predição log-log com a função drm

plot(fitLL, log="", main = "Log logistic") # observando o ajuste

predLL <- data.frame(predicao = ceiling(predict(fitLL, predDia))) # usando o modelo para prever para frente, com base no vetor predDia
predLL$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(predDia$dia)) # criando uma sequência de datas para corresponder aos dias extras na base de predição

predLL <- merge(predLL, covidPE, by.x ='data', by.y = 'date', all.x = T) # juntando as informações observadas da base original 

library(plotly) # biblioteca para visualização interativa de dados

plot_ly(predLL) %>% add_trace(x = ~data, y = ~predicao, type = 'scatter', mode = 'lines', name = "Recuperados - Predição") %>% add_trace(x = ~data, y = ~totalCases, name = "Casos - Observados", mode = 'lines') %>% layout(
  title = 'Predição de Pessoas recuperadas de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Pessoas Recuperadas por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

library(zoo) # biblioteca para manipulação de datas e séries temporais

covidPE <- covidPE %>% mutate(recuperadosMM7 = round(rollmean(x = recovered, 7, align = "right", fill = NA), 2)) # média móvel de 7 dias

covidPE <- covidPE %>% mutate(recuperadosL7 = dplyr::lag(recovered, 7)) # valor defasado em 7 dias

# gráfico de médio móvel de 7 dias do número de pessoas recuperadas
plot_ly(covidPE) %>% add_trace(x = ~date, y = ~recovered, type = 'scatter', mode = 'lines', name = "Recuperados") %>% add_trace(x = ~date, y = ~recuperadosMM7, name = "Recuperados MM7", mode = 'lines') %>% layout(
  title = 'Pessoas recuperadas de COVID19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Pesoas recuperadas por Dia', showgrid = FALSE),
  hovermode = "compare") # plotando tudo junto, para comparação

install.packages("xts")
library(xts)

(covidPETS <- xts(covidPE$recovered, covidPE$date)) # transformar em ST
str(covidPETS)

autoplot(covidPETS)
acf(covidPETS)




