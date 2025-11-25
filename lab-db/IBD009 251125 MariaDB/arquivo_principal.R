# Download scripts
install.packages("DBI")
install.packages("RMariaDB")

# Rodar a partir disso
library(DBI)
library(RMariaDB)

conn <- dbConnect(RMariaDB::MariaDB(),
                  user = "root",
                  password = "",
                  dbname = "loonaverse",
                  host = "127.0.0.1",
                  port = 3306)

tabela1 <- dbGetQuery(conn, "SELECT * FROM membros")
View(tabela1)

tabela2 <- dbGetQuery(conn, "SELECT nome FROM membros WHERE forma = 'Quadrado'")
View(tabela2)

tabela3 <- dbGetQuery(conn, "SELECT nome FROM membros WHERE ano_debut = 2017")
View(tabela3)