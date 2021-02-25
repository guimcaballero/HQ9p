use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        return;
    }

    let filename = &args[1];
    let program = fs::read_to_string(filename).expect("Something went wrong reading the file");

    execute_program(program);
}

fn execute_program(program: String) {
    #[allow(unused_variables)]
    let mut accumulator = 0;

    for char in program.chars() {
        match char {
            'h' | 'H' => print!("Hello, world!"),
            'q' | 'Q' => print!("{}", program),
            '9' => print_99(),
            '+' => accumulator += 1,
            _ => {}
        }
    }
}

fn print_99() {
    let mut count = 99;
    while count > 0 {
        println!(
            "{} bottles of beer on the wall, {} bottles of beer.",
            count, count
        );
        count -= 1;

        if count != 0 {
            println!(
                "Take one down and pass it around, {} bottles of beer on the wall.",
                count
            );
            println!("");
        } else {
            println!("Take one down and pass it around, no more bottles of beer on the wall.");
            println!("");
            println!("No more bottles of beer on the wall, no more bottles of beer.");
            println!("Go to the store and buy some more, 99 bottles of beer on the wall.");
        }
    }
}
