# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Extracao e Tratamento (Aula 3)

# Extraindo os dados diretamente da fonte (acidentes de transito anos 2019, 2020 e 2021)
# 2019
sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')
# Visualizar em tabela
View(sinistrosRecife2019Raw)

# 2020
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8'
)
# Visualizar em tabela
View(sinistrosRecife2020Raw)

# 2021
sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

# Visualizar em tabela
View(sinistrosRecife2021Raw) #só janeiro

# Adicionar os datasets com a funcao rbind

#Verificando as correspondências das solunas dos datasets
str(sinistrosRecife2019Raw)
names(sinistrosRecife2019Raw)
names(sinistrosRecife2020Raw)
#Ajustando o número de colunas  entre os dataframes e os seus nomes
sinistrosRecife2019novo <- sinistrosRecife2019Raw[,-(10:12)]
names(sinistrosRecife2019novo)[1] <- "data"
View(sinistrosRecife2019novo)

#Juntando os dataframes (2019, 2020, 2021) com rbind
sinistros19e20e21 <- rbind(sinistrosRecife2019novo, sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# Visualizar em tabela
View(sinistros19e20e21)
#verificando a estrutura da primeira coluna
str(sinistros19e20e21[, 1])
#transformando a primeira coluna em formato de data
sinistros19e20e21$data <- as.Date(sinistros19e20e21$data, format = '%Y-%m-%d')
str(sinistros19e20e21[, 1])

#transformando outra coluna em fator
sinistros19e20e21$natureza_acidente <- as.factor(sinistros19e20e21$natureza_acidente)
str(sinistros19e20e21$natureza_acidente)

naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# Área de Armazenamento e uso de memória

# lista de todos os objetos no R
ls() 

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}

#O que ocupa mais espaço é o sinistros19e20e21 e o sinistrosRecife2019Raw em seguida.

rm(list = c('sinistros19e20e21', 'sinistrosRecife2019novo', 'sinistrosRecife2019Raw', 'sinistrosRecife2020Raw', 'sinistrosRecife2021Raw'))
ls()
