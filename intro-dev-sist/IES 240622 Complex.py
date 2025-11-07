# inserir os 8 primeiros itens da lista
lista = []
for i in range(8):
  item = input(f"Digite o {i + 1}º item: ")
  lista.append(item)

# Substituir item da lista
def changeItem():
    print(lista)
    posicao = int(input(f"Escolha a posição do item a ser deletado (1 até {len(lista)}): "))
    if  posicao > len(lista):
        print(" \nEscolha uma posição válida \n ")
        changeItem()
    else:
        del lista[posicao-1]
        item = input("Digite o novo item: ")
        lista.append(item)

# Exibir lista
def printList():
    print(lista)

# Dicionário de funções
opcoes = {
    1: changeItem,
    2: printList,
}

# Execução
while True:
    print(" \n1 - Substituir item \n2 - Exibir lista \n3 - Sair \n")
    escolha = int(input("Escolha a opção desejada: "))
    print("")

    if escolha in opcoes:
        opcoes[escolha]()
    elif escolha == 3:
        break
    else:
        print("Opção inválida. Tente novamente.")