
############################  Carrega funções ############################### 

configs <- function() {

    library(readxl)
    library(dplyr)
    diretorio <- getwd()
    
   #localização das Bases históricas
   dir_desp_ate2024 <- paste0(diretorio,"/Orçamento_Publico/Despesas-LN-2008-atual.xlsx")
   dir_rec_ate2024  <- paste0(diretorio,"/Orçamento_Publico/Receitas-LN-2008-atual.xlsx")
   
  
   ### Define municipios de interesse            
   dir_rmvale <- paste0(diretorio,"/Tabelas/Municipios_RMVale.xlsx")
   lista_mun_rmvale <- read_excel(
                       path =  dir_rmvale,
                       sheet = "municipios_rmvale" ) # 39 municipios da RM_Vale
   
   lista_mun_rmvale <- lista_mun_rmvale |> 
                       filter(CD_SUB_REG == "SR5")
   
   lista_municipios <- lista_mun_rmvale$nm_mun       # separa apenas o nome do Municipio minusculo

  } #  FUNÇÃO: configs (configurações)

#______________________________________________________________________________________________________________
load_packages <- function() {
  
  install.packages(c('readxl', 'dplyr'))  # pacotes minimos para executar a função
  library('readxl')
  library('dplyr')
  
  pacotes_df <- read_xlsx("Tabelas/pacotes.xlsx")    #le planilha de pacotes e grava data frame
  pacotes_df <- filter(pacotes_df, carregar == "S")
  pacotes    <- as.vector( pacotes_df$pacote)
  
  print (pacotes)
  
  if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){ # retorna matriz pacotes ja instalados
    instalador <- pacotes[!pacotes %in% installed.packages()]   # isola os pacotes não instalados 
    for(i in 1:length(instalador)) {
      install.packages(instalador, dependencies = T)
      break()}
    sapply(pacotes, require, character = T) 
  } else {
    sapply(pacotes, require, character = T)  # opção: lapply(carregar, require, character.only = TRUE)   
  }
  
  # O pacote rayshader que está no CRAN, no momento, possui alguns bugs. A versão
  # que está no GitHub do autor do pacote já é mais funcional. Para instalá-la: (responder 3 na console)
  # devtools::install_github("tylermorganwall/rayshader")  #(só a primeira vez)
  
  # Para carregar o rayshader  (faz graficos tridimensionais - barras sobre o mapa)
  # library(rayshader)
  
} # FUNÇÃO: carrega pacotes
#______________________________________________________________________________________________________________
rm_accent <- function(str,pattern="all") {
  # FUNÇÃO: rm_accent - Remove acentuações
  # Rotinas e funções úteis V 1.0
  # rm.accent - REMOVE ACENTOS DE PALAVRAS
  # Função que tira todos os acentos e pontuações de um vetor de strings.
  # Parâmetros:
  # str - vetor de strings que terão seus acentos retirados.
  # patterns - vetor de strings com um ou mais elementos indicando quais acentos deverão ser retirados.
  #            Para indicar quais acentos deverão ser retirados, um vetor com os símbolos deverão ser passados.
  #            Exemplo: pattern = c("´", "^") retirará os acentos agudos e circunflexos apenas.
  #            Outras palavras aceitas: "all" (retira todos os acentos, que são "´", "`", "^", "~", "¨", "ç")
  if(!is.character(str))
    str <- as.character(str)
  
  pattern <- unique(pattern)
  
  if(any(pattern=="Ç"))
    pattern[pattern=="Ç"] <- "ç"
  
  symbols <- c(
    acute = "áéíóúÁÉÍÓÚýÝ",
    grave = "àèìòùÀÈÌÒÙ",
    circunflex = "âêîôûÂÊÎÔÛ",
    tilde = "ãõÃÕñÑ",
    umlaut = "äëïöüÄËÏÖÜÿ",
    cedil = "çÇ"
  )
  
  nudeSymbols <- c(
    acute = "aeiouAEIOUyY",
    grave = "aeiouAEIOU",
    circunflex = "aeiouAEIOU",
    tilde = "aoAOnN",
    umlaut = "aeiouAEIOUy",
    cedil = "cC"
  )
  
  accentTypes <- c("´","`","^","~","¨","ç")
  
  if(any(c("all","al","a","todos","t","to","tod","todo")%in%pattern)) # opcao retirar todos
    return(chartr(paste(symbols, collapse=""), paste(nudeSymbols, collapse=""), str))
  
  for(i in which(accentTypes%in%pattern))
    str <- chartr(symbols[i],nudeSymbols[i], str)
  
  return(str)
}  # FUNÇÃO: rm_accents - Remove acentuações
#______________________________________________________________________________________________________________
std_str <- function(str2) {
  # FUNÇÃO std_str - Padronização dos caracteres
  str2 <- tolower(str2)                             # coloca tudo em lowercase - para Uppercase seria toupper(str_origem) 
  str2 <- rm_accent(str2)                           # Remove todas acentuações 
  str2 <- str_replace_all(str2, "[^[:alnum:]]", "") # remove non alphanumeric characters
  return(str2)
} # FUNÇÃO: std_str - Padronização dos caracteres especiais, uppercase, etc.
#______________________________________________________________________________________________________________
download_receitas <- function(anos_f, lista_municipios_f) {
  
  dir_rec_ate2024  <- paste0(diretorio,"/Orçamento_Publico/Receitas-LN-2008-atual.xlsx")
  
  tipo = "receitas"
  receitas_acum <- read.csv(file = "receitas_vazia.csv", sep = ";", header = T, encoding = "latin1")
  # receitas_acum <- read_xlsx("Receitas-Ilhabela-2008-2022.xlsx") # opção de juntar antigo 
  
  
  for(ano in anos_f) {
    
    for(mun in lista_municipios_f) {
      
      print (paste("baixando", tipo, "de:", mun, "ano:", ano))
      
      url_baixar <- paste("https://transparencia.tce.sp.gov.br/sites/default/files/csv/", tipo, "-", mun, "-", ano, ".zip",sep = "")
      
      df_name_zip   <- paste(tipo, "-", mun, "-", ano, ".zip",sep = "")
      df_name_csv   <- paste(tipo, "-", mun, "-", ano, ".csv",sep = "")
      df_name_pasta <- paste(tipo, "-", mun, "-", ano,        sep = "")
      
      download.file(url_baixar, df_name_zip)               #traz para meu diretorio (vem zipado)
      unzip(df_name_zip, files = df_name_csv)              #Unzipa           
      
      file.remove(df_name_zip)
      #file.remove(df_name_pasta)
      
      receitas <- read.csv(file = df_name_csv, sep = ";", header = T, 
                           encoding = "latin1",dec = ",")
      receitas$dt_atlz    <- ''
      receitas$categoria  <- ''
      
      receitas_acum <- rbind.data.frame(receitas_acum, receitas)
      
      rm (receitas)
      file.remove (df_name_csv)
      
    }  # Fim do loop de município  
  }  # Fim do loop de ano
  
  colnames(receitas_acum) <- 
    c('Identificação da Receita',	
      'Ano',	
      'Municipio',	
      'Orgão',	
      'Mês',	
      'Mês extenso',	
      'Poder',	
      'Fonte de Recurso',	
      'Código aplicacao fixo',	
      'Código aplicação variavel',	
      'Categoria Econômica',	
      'Sub Categoria',	
      'Fonte',	
      'Rubrica',	
      'Alínea',	
      'Sub Alínea',	
      'Valor arrecadacao',
      'Data Atualização',
      'Categoria'
    )
  
  # save(receitas_acum, file = "Receitas_municipios.Rdata") # grava resultado em formato RData
  
  write_xlsx(receitas_acum, "Receitas_municipios.xlsx") #grava data frame em formato *.xlsx
  
} # FUNÇÃO download_receitas do TCE  - municípios da lista_mun_minusculas
#______________________________________________________________________________________________________________
download_despesas <- function(anos_f, lista_municipios_f) {
  
  {
    # Ler historico das despesas pelo NOME da planilha 
    #dir_desp_ate2024 <- paste0(diretorio,"/Orçamento_Publico/Despesas-LN-2008-atual.xlsx")
    #despesas_hist <- read_excel(
    #                 path =  dir_desp_ate2024,
    #                 sheet = "Receitas_Caraguatatub_2014-2024"  )  # Substitua pelo nome da planilha
  } # Opção A: Ler pelo NOME da planilha - histórico das despesas
  
  # FUNÇÃO: Baixar DESPESAS dos municípios da lista_mun_minusculas ########################## 
  
  tipo = "despesas"
  despesas_acum <- read.csv(file = "despesas_vazia.csv", sep = ";", header = T, encoding = "latin1")
  # despesas_acum <- read_xlsx("Despesas-Ilhabela_2008-2022.xlsx") # opção para juntar base até 2022dados 
  
  for(ano in anos_f) {
    
    for(mun in lista_municipios_f) {
      
      print (paste("baixando", tipo, "de:", mun, "ano:", ano))
      
      url_baixar <- paste("https://transparencia.tce.sp.gov.br/sites/default/files/csv/", tipo, "-", mun, "-", ano, ".zip",sep = "")
      
      df_name_zip   <- paste(tipo, "-", mun, "-", ano, ".zip",sep = "")
      df_name_csv   <- paste(tipo, "-", mun, "-", ano, ".csv",sep = "")
      df_name_pasta <- paste(tipo, "-", mun, "-", ano,        sep = "")
      
      download.file(url_baixar, df_name_zip)               #traz para meu diretorio (vem zipado)
      unzip(df_name_zip, files = df_name_csv)              #Unzipa           
      
      file.remove(df_name_zip)
      
      file.remove(df_name_pasta)
      
      despesas <- read.csv(file = df_name_csv, sep = ";", header = T, 
                           encoding = "latin1", dec = ",")
      
      # Cria Novas Colunas
      despesas$historico_std     <- ''
      despesas$categoria         <- ''
      despesas$subcategoria      <- ''
      despesas$eventos           <- ''
      despesas$selecao           <- ''
      despesas$otmu              <- ''
      
      
      despesas_vl <- filter(despesas, tp_despesa == "Valor Liquidado")
      
      despesas_acum <- rbind.data.frame(despesas_acum, despesas_vl)
      
      rm (despesas, despesas_vl)
      
      file.remove (df_name_csv)
      
    }  # Fim do loop de município  
  }  # Fim do loop de ano
  
  # colnames(despesas_acum) <- c('identificação da despesa detalhe',
  #                               'ano exercicio',
  #                               'municipio',
  #                               'Orgão',
  #                               'mês',
  #                               'mês extenso',
  #                               'tipo despesa',	
  #                               'Num. Empenho (interno)',	
  #                               'identificador despesa',
  #                               'destino da despesa (Fornecedor)',
  #                               'data emissao despesa',
  #                               'Valor',
  #                               'funcao de governo',
  #                               'subfuncao governo',
  #                               'codigo do programa',
  #                               'descrição do programa',	
  #                               'cód Ação',	
  #                               'descrição da acao',	
  #                               'Fonte de Recurso',	
  #                               'código da aplicacao fixo',	
  #                               'modalidade de licitação',
  #                               'Categoria Econômica e Descrição  da Despesa',	
  #                               'Histórico da despesa',
  #                               'historico_std',
  #                               'categoria',
  #                               'sub_categoria',
  #                               'eventos',
  #                               'selecão',
  #                               'otmu')
  
  
  # save(despesas_acum, file = "Despesas_municipios.Rdata") # grava resultado em formato RData
  
  dsname <- "Despesas_municipios.xlsx" # Substituir DSN do arquivo de despesas a ser trabalhado 
  
  write_xlsx(despesas_acum, dsname) #grava data frame em formato *.xlsx
  
  std_histdesp(dsname) # cria campo histórico padronizado (sem acentuação)
  
} # FUNÇÃO: Download Receitas do TCE  - municípios da lista_mun_minusculas
#______________________________________________________________________________________________________________

#________________________________  Executa as funções ##_____________________________________________________

configs()       # executa função configurações 
load_packages() # executa função carregar pacotes
