const fs = require("fs");
var path = require('path');

function print(string) {
    process.stdout.write(string);
}

function print99() {
    let i = 99;
    while (i > 0) {
        print(`${i} bottles of beer on the wall, ${i} bottles of beer.\n`);
        i--;

        if (i != 0) {
            print(`Take one down and pass it around, ${i} bottles of beer on the wall.\n`);
            print("\n");
        } else {
            print("Take one down and pass it around, no more bottles of beer on the wall.\n");
            print("\n");
            print("No more bottles of beer on the wall, no more bottles of beer.\n");
            print("Go to the store and buy some more, 99 bottles of beer on the wall.\n");
        }
    }
}

function executeProgram(program) {
    let accum = 0;
    for (const char of program) {
        switch (char) {
            case 'H':
            case 'h':
                print("Hello, world!");
                break;
            case 'Q':
            case 'q':
                print(program);
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
    const filename = process.argv[2];
    if (filename == null) {
        process.exit();
    }

    const content = fs.readFileSync(path.join(__dirname, filename)).toString();

    executeProgram(content);
}

main();
