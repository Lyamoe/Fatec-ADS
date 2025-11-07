algoritmo "IAL 240409 atv4"
// Função : dobro do número se positivo, triplo se negativo
// Autor : Lyam
// Data : 09/04/2024
// Seção de Declarações 
var
a:REAL

inicio
// Seção de Comandos
escreva("Insira o valor de a: ")
leia(a)

se a >= 0 entao
   escreval(a, " é positivo, logo seu dobro é ", a*2)
senao
   escreval(a, " é negativo, logo seu triplo é ", a*3)
fimse
fimalgoritmo
