#include <iostream>
#include <fstream>

using namespace std;

void print99() {
  int i = 99;
  while (i > 0) {
    cout << i << " bottles of beer on the wall, " << i << " bottles of beer.\n";

    i--;

    if (i != 0) {
      cout << "Take one down and pass it around, " << i << " bottles of beer on the wall.\n\n";
    } else {
      cout << "Take one down and pass it around, no more bottles of beer on the wall.\n\n";
      cout << "No more bottles of beer on the wall, no more bottles of beer.\n";
      cout << "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
    }
  }
}

void execute_program(string program) {
  int accum = 0;

  for(char& c : program) {
    switch (c) {
      case 'H':
      case 'h':
        cout << "Hello, world!";
        break;
      case 'Q':
      case 'q':
        cout << program;
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

int main(int argc, char* argv[]) {
  if (argc < 2) {
    return -1;
  }

  string filename = argv[1];

  fstream file;
	file.open(filename, ios::in);
	if (!file) {
    return -1;
	}

  string content((istreambuf_iterator<char>(file)), istreambuf_iterator<char>());

  execute_program(content);

  return 0;
}
