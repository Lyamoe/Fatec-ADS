algoritmo "IAL 240409 atv5"
// Função : lê dois valores lógicos e determina se são VERDADEIROS ou FALSOS.
// Autor : Lyam
// Data : 09/04/2024
// Seção de Declarações 
var
a,b:LOGICO
inicio
// Seção de Comandos 
escreva("a é verdadeiro ou falso: ")
leia(a)
escreva("b é verdadeiro ou falso: ")
leia(b)

se a = VERDADEIRO entao
   se b = VERDADEIRO entao
      escreva("ambos verdadeiros")
   senao
        escreva("apenas a é verdadeiro")
   fimse
senao
   se b = FALSO entao
      escreva("ambos falsos")
   senao
        escreva("apenas b é verdadeiro")
   fimse
fimse
fimalgoritmo
