install.packages("readxl")

library(readxl)

dados_time <- read_excel("tabelas/elenco_times_sp.xlsx")
View(dados_time)

minimo <- min(dados_time$Idade)
maximo <- max(dados_time$Idade)
media <- mean(dados_time$Idade)

print(minimo)
print(maximo)
print(media)