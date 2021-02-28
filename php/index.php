<?php

// Parse command line args into GET
if (!empty($argv)) {
  parse_str(implode('&', array_slice($argv, 1)), $_GET);
}

// Exit if filename is not set
if(!isset($_GET['file'])) {
  return;
}

$filename = $_GET['file'];
$contents = file_get_contents($filename);
$program = str_split($contents);

$accum = 0;

foreach ($program as $char) {
  switch ($char) {
    case 'H':
    case 'h':
      echo 'Hello, world!';
      break;
    case 'Q':
    case 'q':
      echo $contents;
      break;
    case '9':
      print99();
      break;
    case '+':
      $accum++;
      break;
  }
}

function print99() {
  $i = 99;
  while ($i > 0) {
    echo "$i bottles of beer on the wall, $i bottles of beer.\n";

    $i--;

    if ($i != 0) {
        echo "Take one down and pass it around, $i bottles of beer on the wall.\n\n";
    } else {
      echo "Take one down and pass it around, no more bottles of beer on the wall.\n\n";
      echo "No more bottles of beer on the wall, no more bottles of beer.\n";
      echo "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
    }
  }
}
