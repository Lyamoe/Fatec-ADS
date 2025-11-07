import random
goal = random.randint(0, 100000)
chances = 20
higher = 100000 
lower = 0

def trials (less,high):
  guess = random.randint(less+1, high-1)
  print(f"Eu acho que é {guess}")
  return guess

while chances > 0:
  guess = trials(lower,higher)

  if guess > goal:
    print("Tente um número menor!")
    higher = guess
  elif guess < goal:
    print("Tente um número maior!")
    lower = guess
  elif guess == goal:
    print("===========================================")
    print(f"Parabéns, você acertou em {20-chances} chances!")
    print("===========================================")
    break
  
  chances -= 1

if chances == 0:
  print("===========================================")
  print(f"Acabaram as chances! O número era {goal}")
  print("===========================================")