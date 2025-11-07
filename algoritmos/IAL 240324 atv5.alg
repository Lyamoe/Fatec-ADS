algoritmo "atv 5"
// Função :
// Autor : Karine Santos Peres
// Data : 24/03/2024
// Seção de Declarações 
var
n1, n2, n3, n4, n5:INTEIRO
media:REAL
faltas:INTEIRO

inicio
// Seção de Comandos
escreval("")

escreva("Insira a primeira nota: ")
leia(n1)
escreva("Insira a segunda nota: ")
leia(n2)
escreva("Insira a terceira nota: ")
leia(n3)
escreva("Insira a quarta nota: ")
leia(n4)
escreva("Insira a quinta nota: ")
leia(n5)
escreva("Insira as faltas: ")
leia(faltas)

se (n1 > n2) entao
senao
se (n1 > n3) entao
senao
se (n1 > n4) entao
senao
se (n1 > n5) entao
senao
media <- (n2 + n3 + n4 + n5)/4
fimse
fimse
fimse
fimse

se (n2 > n1) entao
senao
se (n2 > n3) entao
senao
se (n2 > n4) entao
senao
se (n2 > n5) entao
senao
media <- (n1 + n3 + n4 + n5)/4
fimse
fimse
fimse
fimse

se (n3 > n1) entao
senao
se (n3 > n2) entao
senao
se (n3 > n4) entao
senao
se (n3 > n5) entao
senao
media <- (n1 + n2 + n4 + n5)/4
fimse
fimse
fimse
fimse

se (n4 > n1) entao
senao
se (n4 > n2) entao
senao
se (n4 > n3) entao
senao
se (n4 > n5) entao
senao
media <- (n1 + n2 + n3 + n5)/4
fimse
fimse
fimse
fimse

se (n5 > n1) entao
senao
se (n5 > n2) entao
senao
se (n5 > n3) entao
senao
se (n5 > n4) entao
senao
media <- (n1 + n2 + n3 + n4)/4
fimse
fimse
fimse
fimse

escreval("")

se (faltas > 15) entao
escreval("O aluno foi reprovado por falta")
senao
se (media >= 6) entao
escreval("O aluno foi aprovado")
senao
se (media >= 4) entao
escreval("O aluno ficou de recuperação")
senao
se (media < 4) entao
escreval("O aluno foi reprovado por nota")
fimse
fimse
fimse
fimse

fimalgoritmo
