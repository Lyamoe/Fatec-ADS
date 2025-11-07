algoritmo "IAL 240409 atv1"
// Função : a + b ou a * b
// Autor : Lyam
// Data : 09/04/2024
// Seção de Declarações
var
a, b, c : real

inicio
// Seção de Comandos
escreva ("Entre com o valor de A: ")
leia (a)

escreva ("Entre com o valor de B: ")
leia (b)


se a = b entao
   c <- a+b
   escreva ("a e b são iguais, logo o resultado é " , c)
senao
   c <- a*b
   escreva ("a e b são diferentes, logo o resultado é " , c)
fimse


fimalgoritmo
