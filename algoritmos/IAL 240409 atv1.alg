algoritmo "IAL 240409 atv1"
// Função : a + b é maior ou menor que c
// Autor : Lyam
// Data : 09/04/2024
// Seção de Declarações 
var
a, b, c : real
soma : real

inicio
// Seção de Comandos 
escreva ("Entre com o valor de A: ")
leia (a)

escreva ("Entre com o valor de B: ")
leia (b)

escreva ("Entre com o valor de C: ")
leia (c)
soma <- a+b

se soma < c entao
escreva ("o valor da soma é menor que o valor de" , c)
senao
escreva ("o valor da soma é maior que o valor de" , c)
fimse
fimalgoritmo
