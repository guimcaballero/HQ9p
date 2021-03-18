import gleam/list
import gleam/result
import gleam/string
import gleam/io
import gleam/int

pub external type CharList

external fn char_list_to_string(CharList) -> String =
  "erlang" "list_to_binary"

external fn read_file(String) -> Result(String, String) =
  "file" "read_file"

pub fn main(args: List(CharList)) {
  let arg = list.map(args, char_list_to_string)
    |> list.head
  case arg {
    Ok(filename) -> open_file(filename)
    _ -> Nil
  }
}

pub fn open_file(filename: String) {
  case read_file(filename) {
    Ok(txt) -> execute(txt)
    _ -> Nil
  }
}

pub fn execute(contents: String) {
  let _accum = list.fold(
    over: string.to_graphemes(contents),
    from: 0,
    with: fn (letter, accum) { execute_letter(letter, contents, accum) }
  )
  Nil
}

pub fn execute_letter(letter: String, contents: String, accum: Int) -> Int {
  case letter {
    "H" | "h" -> {
      io.print("Hello, world!")
      accum
    }
    "Q" | "q" -> {
      io.print(contents)
      accum
    }
    "9" -> {
      print99()
      accum
    }
    "+" -> accum + 1
      _ -> accum
  }
}

pub fn print99() {
  list.range(99, 0)
    |> list.each(fn(idx) {
        case idx {
          1 -> {
            io.println("1 bottle of beer on the wall, 1 bottle of beer.")
            io.println("Take one down and pass it around, no more bottles of beer on the wall.")
            io.println("")
            io.println("No more bottles of beer on the wall, no more bottles of beer.")
            io.println("Go to the store and buy some more, 99 bottles of beer on the wall.")
          }
          val -> {
            io.println(string.concat([
              int.to_string(val),
              " bottles of beer on the wall, ",
              int.to_string(val),
              " bottles of beer."
            ]))
            io.println(string.concat([
              "Take one down and pass it around, ",
              int.to_string(val - 1),
              " bottles of beer on the wall."
            ]))
            io.println("")
          }
        }
      })
  Nil
}
