import sys

def p(string):
  print(string, end="")

def print99():
  i = 99
  while i > 0:
    print(f"{i} bottles of beer on the wall, {i} bottles of beer.")

    i -= 1

    if i != 0:
      print(f"Take one down and pass it around, {i} bottles of beer on the wall.")
      print("")
    else:
      print("Take one down and pass it around, no more bottles of beer on the wall.");
      print("");
      print("No more bottles of beer on the wall, no more bottles of beer.");
      print("Go to the store and buy some more, 99 bottles of beer on the wall.");

if len(sys.argv) < 2:
  exit()

filename = sys.argv[1]
accum = 0

with open(filename, 'r') as file:
    contents = file.read()

    for char in contents:
      if char == 'H' or char == 'h':
        p("Hello, world!")
      elif char == 'Q' or char == 'q':
        p(contents)
      elif char == '9':
        print99()
      elif char == '+':
        accum += 1
