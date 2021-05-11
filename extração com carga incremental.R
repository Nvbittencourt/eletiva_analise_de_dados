# UFPE 
# PPGCP
# Análise de Dados
# Professor: Hugo Medeiros
# Aluna: Nathália Viviani Bittencourt
# Atividade: Extração com carga incremental

library(dplyr)

# Carregando dados de chamados para verificação de áreas de risco no recife do dia atual, em tempo Real.
sedec_chamados <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/079fd017-dfa3-4e69-9198-72fcb4b2f01c/download/sedec_chamados_tempo_real.csv', sep = ';', encoding = 'UTF-8')
View(sedec_chamados)

#Atualizando os dados
new_sedec_chamados <- read.csv2('http://dados.recife.pe.gov.br/dataset/99eea78a-1bd9-4b87-95b8-7e7bae8f64d4/resource/079fd017-dfa3-4e69-9198-72fcb4b2f01c/download/sedec_chamados_tempo_real.csv', sep = ';', encoding = 'UTF-8')
View(sedec_chamados)

chamadosTempoRealIncremento <- (!new_sedec_chamados$processo_numero %in% sedec_chamados$processo_numero)
# Não houve nenhum chamado entre a tarde do dia 10.05 até a noite deste mesmo dia