#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void print99() {
  int i = 99;
  while (i > 0) {
    printf("%d bottles of beer on the wall, %d bottles of beer.\n", i, i);
    i--;

    if (i != 0) {
      printf("Take one down and pass it around, %d bottles of beer on the wall.\n\n", i);
    } else {
      printf("Take one down and pass it around, no more bottles of beer on the wall.\n\n");
      printf("No more bottles of beer on the wall, no more bottles of beer.\n");
      printf("Go to the store and buy some more, 99 bottles of beer on the wall.\n");
    }
  }
}

void execute_program(char* program) {
  int accum = 0;

  for (char* c = program; *c != '\0'; ++c) {
    switch (*c) {
      case 'H':
      case 'h':
        printf("Hello, world!");
        break;
      case 'Q':
      case 'q':
        printf("%s", program);
        break;
      case '9':
        print99();
        break;
      case '+':
        accum++;
        break;
    }
  }
}

int main(int argc, char *argv[])  {
  if (argc < 2) {
    exit(1);
  }
  char* filename = argv[1];

  FILE* file = fopen(filename, "r");
  if(file == NULL)
  {
    exit(1);
  }

  fseek(file, 0, SEEK_END);
  long size = ftell(file);
  fseek(file, 0, SEEK_SET);

  char* content = malloc(size + 1);
  fread(content, 1, size, file);
  content[size] = '\0';

  execute_program(content);

  fclose(file);
  return 0;
}
