# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Extração de 3 dos seguintes dados .json, .txt,.csv, excel e .xml 

# Carregando arquivos .csv no repositório dados.recife

licitacoes_concluidas <- read.csv2('http://dados.recife.pe.gov.br/dataset/591a6ed4-7beb-4304-a2a1-2af521517a06/resource/c5d7505c-381c-4670-a0c2-1fbf56df50b1/download/dados_abertos_licitacao_concluida.csv')

# Carregando arquivos .json no repositório dados.recife

install.packages('rjson')
library(rjson)
malha_cicloviária <- fromJSON(file = 'http://dados.recife.pe.gov.br/dataset/667cb4cf-fc93-4687-bb8f-431550eeb2db/resource/985e58e2-df0b-4d29-a938-983a47e39329/download/metadados-malhacicloviariarecife.json')

# Carregando arquivos .xml em .xml data repository

install.packages('XML')
library(XML)
yahoo_auction <- xmlToDataFrame('http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/auctions/yahoo.xml')
