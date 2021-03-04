const fs = require("fs");
var path = require('path');

function p(val: string) {
    process.stdout.write(val);
}

function print99() {
    let i = 99;
    while (i > 0) {
        p(`${i} bottles of beer on the wall, ${i} bottles of beer.\n`);
        i--;

        if (i != 0) {
            p(`Take one down and pass it around, ${i} bottles of beer on the wall.\n`);
            p("\n");
        } else {
            p("Take one down and pass it around, no more bottles of beer on the wall.\n");
            p("\n");
            p("No more bottles of beer on the wall, no more bottles of beer.\n");
            p("Go to the store and buy some more, 99 bottles of beer on the wall.\n");
        }
    }
}

function executeProgram(program: string) {
    let accum = 0;
    for (const char of program) {
        switch (char) {
            case 'H':
            case 'h':
                p("Hello, world!");
                break;
            case 'Q':
            case 'q':
                p(program);
                break;
            case '9':
                print99();
                break;
            case '+':
                accum++;
                break;
            default:
                break;
        }
    }
}

function main() {
    const filename: string|null = process.argv[2];
    if (filename == null) {
        process.exit();
    }

    const content = fs.readFileSync(path.join(__dirname, filename)).toString();

    executeProgram(content);
}

main();

declare var process : {
  exit();
  stdout: {
    write(string);
  };

  argv: any[];
}
declare var __dirname : string;
declare function require(name:string);
