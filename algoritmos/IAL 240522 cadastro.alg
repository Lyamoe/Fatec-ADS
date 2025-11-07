algoritmo "Cadastro"
// Função : Melhorar o código abaixo
// Autor : Lyam
// Data : 23/05/2024
// Seção de Declarações

Var
   pessoas : vetor [1..2, 1..3] de caractere
   desempenho : vetor [1..2, 1..5] de real
   Op, mais,UsuaDes,UsuaRemover: caractere
   Encontrado, posi, atual: inteiro
   
//-----------------------sub-programas------------------------------
//-----------funções---------
funcao cadastrados(): inteiro
// Seção de Declarações das variáveis internas da função
var
   rpt, cadastros: inteiro
inicio
      para rpt de 1 ate 2 faca
           se pessoas[rpt,1] = "" entao
              cadastros <- rpt-1
              interrompa
           senao
                cadastros <- rpt
           fimse
      fimpara
      retorne cadastros
fimfuncao

funcao buscarPessoa(nome: caracter):inteiro
   var
      linha: inteiro
      Indice: inteiro
   inicio
       para linha de 1 ate 2 faca
            se(nome = pessoas[linha, 1]) entao
               Indice <- linha
               interrompa
            fimse
       fimpara
       se(Indice > 0) entao
          se op = "4" entao
             escreval(" ")
             escreval("Usuario encontrado na posição", Indice)
          senao
             escreval(" ")
             escreval("Usuario encontrado na posição", Indice)
             saida()
          fimse
       senao
            escreval(" ")
            escreval("Usuario não encontrado")
            saida()
       fimse

       retorne Indice
       Indice <- 0
fimfuncao

//--------procedimentos---------
procedimento exibir()
var
rpt, quant, notas:inteiro
inicio
      quant <- cadastrados()
      se quant = 0 entao
         escreval("Não há usuarios cadastrados.")
      senao
           escreval("Usuarios Cadastrados:")
           para rpt de 1 ate quant faca
                escreval(" ")
                escreval(pessoas[rpt]," - ",pessoas[rpt,2]," anos")
                escreva("Notas:")
                para notas de 1 ate 3 faca
                     escreva(desempenho[rpt,notas],",")
                fimpara
                escreval(desempenho[rpt,4])
                escreval("Faltas:",desempenho[rpt,5])
                escreval("Situação: ",pessoas[rpt,3])
                escreval("")
           fimpara
      fimse
      escreval(" ")
      saida()
fimprocedimento

procedimento removerPessoa(linha: inteiro)
var
rpt:inteiro
inicio
            se linha <> 0 entao
               pessoas[linha, 1] <- ""
               pessoas[linha, 2] <- ""
               pessoas[linha, 3] <- ""
               para rpt de 1 ate 5 faca
                    desempenho[linha,rpt] <- 0
               fimpara
               posi <- posi-1
               escreval("Pessoa removida com sucesso!")
               escreval("Agora você pode criar um novo cadastro")
               escreval("")
               saida()
            fimse
            Encontrado <- 0
fimprocedimento

procedimento cadastrar()
var
chave:logico
media:real
inicio
      repita
            mais <- "1"
            atual <- 1
            se posi<=2 entao
               se pessoas[posi,1] = "" entao
                  escreval("Digite o nome:")
                  leia (pessoas[posi,1])
                  escreval("Digite a idade")
                  leia (pessoas[posi,2])
                  enquanto atual <= 4 faca
                    chave <- falso
                    escreval("Digite a",atual,"° nota")
                    leia(desempenho[posi,atual])
                    se desempenho[posi,atual] > 10 entao
                       chave <- verdadeiro
                    senao
                         se desempenho[posi,atual] < 0 entao
                            chave <- verdadeiro
                         senao
                              media <- media + desempenho[posi,atual]
                         fimse
                    fimse
                    se chave = verdadeiro entao
                       escreval("")
                       escreval("Insira uma nota de 0 a 10")
                       escreval("")
                    senao
                         atual <- atual + 1
                    fimse
                  fimenquanto
                  escreval("Digite as faltas")
                  leia (desempenho[posi,5])
                  media <- media/4
                  se desempenho[posi,5] > 10 entao
                     pessoas[posi,3] <- "reprovado por falta"
                  senao
                     se media >= 6 entao
                       pessoas[posi,3] <- "aprovado"
                     senao
                         pessoas[posi,3] <- "reprovado"
                     fimse
                  fimse
                  media <- 0
                  posi<-posi+1
                  escreval("")
                  escreval("Deseja cadastrar mais usuarios (1.SIM / 2.NÃO)?") // COLOCAR MENSAGEM EM CASO DE OPÇÃO INVÁLIDA
                  leia (mais)
                  se mais <> "2" entao
                     se mais <> "1" entao
                        mais <- "2"
                        escreval("")
                        escreval("Opção inválida. Sendo redirecionado ao menu")
                        saida()
                     fimse
                  fimse
                  limpatela
               senao
                    posi<-posi+1
               fimse
            senao
                 escreval("Cadastro lotado!")
                 escreval("Para adicionar outro, remova um dos cadastrados")
                 escreval("")
                 saida()
                 mais<-"2"
            fimse
      ate mais = "2"
fimprocedimento

procedimento saida()
var
x:caractere
inicio
escreval("")
escreva("Pressione enter para retornar ao menu")
leia(x)
fimprocedimento

//---------------------fim sub-programas-------------------------

//------------------------principal------------------------------
Inicio
posi<-1
repita
      limpatela
      escreval("--------------------------------------------------")
      escreval("Digite o numero da opção desejada:")
      escreval("1 - Cadastrar novo usuário:")
      escreval("2 - Listar todos os usuários cadastrados:")
      escreval("3 - Buscar usuário pelo nome:")
      escreval("4 - Remover usuário da lista")
      escreval("5 - Sair do sistema:")
      escreval("--------------------------------------------------")
      escreva("Entre com a opção desejada: ")
      leia (Op)
      escreval(" ")
      escolha Op
      caso "1"
           cadastrar()
      caso "2"
           exibir()
      caso "3"
         escreval("Qual usuario deseja buscar?")
         leia(UsuaDes)
         Encontrado <- buscarPessoa(UsuaDes)
         Encontrado <- 0
      caso= "4"
         escreval("Qual usuário deseja Remover?")
         leia(UsuaRemover)
         Encontrado <- buscarPessoa(UsuaRemover)
         removerPessoa(Encontrado)
      caso= "5"
            escreval("Saindo do programa!")
      outrocaso
          escreval("Opção invalida")
          saida()
      fimescolha
ate Op = "5"
Fimalgoritmo
