# ========== Pacotes ==========
# install.packages(c("dplyr", "ggplot2"))

library(dplyr)
library(ggplot2)

# ========== Carregamento dos dados ==========
dados <- read.csv2(
  "ca-2022-02.csv", 
  header = TRUE, 
  sep = ";", 
  dec = ",", 
  stringsAsFactors = FALSE
)

head(dados)

# ========== Aplicação de filtros ==========
dados_gasolina <- subset(dados, Produto == "GASOLINA")

dados_gasolina$Valor.de.Venda <- as.numeric(gsub(",", ".", dados_gasolina$Valor.de.Venda, fixed = TRUE))

# ========== Média, Mínimo e Máximo ==========

# Média
media_brasil <- dados_gasolina %>%
  summarise(
    Valor = mean(Valor.de.Venda, na.rm = TRUE)
  ) %>%
  pull(Valor) # Extrai o valor do dataframe gerado

# Min e Max
dados_caragua <- dados_gasolina %>%
  filter(Municipio == "CARAGUATATUBA") %>%
  summarise(
    Minimo = min(Valor.de.Venda, na.rm = TRUE),
    Maximo = max(Valor.de.Venda, na.rm = TRUE)
  )

# ========== Criação do gráfico ==========
df_grafico <- data.frame(
  Categoria = c("Média Brasil", "Mín. Caraguatatuba", "Máx. Caraguatatuba"),
  Valor = c(media_brasil, dados_caragua$Minimo, dados_caragua$Maximo)
)

ggplot(df_grafico, aes(x = Categoria, y = Valor, fill = Categoria)) +
  geom_bar(stat = "identity") + # geom_col é o mesmo que geom_bar(stat="identity")
  geom_text(aes(label = round(Valor, 2)), vjust = -0.5) + # Valor p barra
  labs(
    title = "Preço da Gasolina",
    x = "valor por lugar",
    y = "Preço (R$)"
  )
