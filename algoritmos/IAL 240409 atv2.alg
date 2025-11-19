algoritmo "IAL 240409 atv2"
// Função : Se for F e casada, pergunte por quantos anos
// Autor : Lyam
// Data : 09/04/2024
// Seção de Declarações 
var
nome , sexo, estciv : caractere
anos : real

inicio
// Seção de Comandos

escreva("Digite seu nome: ")
leia(nome)
escreva("Digite seu sexo, F para feminino M para masculino: ")
leia(sexo)
escreva ("Digite seu estado civil: ")
leia(estciv)

se sexo = "F" entao
   se estciv = "casada" entao
      escreval("Há quantos anos é casada?")
      leia(anos)
fimse
Fimse

escreva("Obrigado por participar da pesquisa")

fimalgoritmo
