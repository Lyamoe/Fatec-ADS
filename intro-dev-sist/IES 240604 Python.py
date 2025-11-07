import random
goal = random.randint(0, 100000)
chances = 20

while chances > 0:
  guess = int(input(f"Digite um número ({chances} chances restantes): "))

  if guess > goal:
    print("Tente um número menor!")
  elif guess < goal:
    print("Tente um número maior!")
  elif guess == goal:
    print("===========================================")
    print(f"Parabéns, você acertou! O número era {goal}")
    print("===========================================")
    break

  chances -= 1

if chances == 0:
  print("===========================================")
  print(f"Acabaram as chances! O número era {goal}")
  print("===========================================")
