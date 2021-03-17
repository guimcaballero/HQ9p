       >>source format free
identification division.
program-id. hq9p.

environment division.
       input-output section.
           file-control.
           select w-file assign to filename
               organization is line sequential.

data division.
       file section.
           fd w-file.
           01 linecontents pic x(1000).

       working-storage section.
           01 filename pic x(100).
           01 contents pic x(1000).
           01 wseof pic a(1) value space.
           01 currentchar pic x(1) value space.
           01 accum pic 99999 value 0.
           01 idx pic 99999 value 1.
           01 bottlecounter pic 99 value 99.
           01 bottlecounter-minus1 pic 99 value 98.
           01 filelength pic 99999 value 0.
           01 formatted-integer pic z9.

procedure division.
       accept filename from command-line.
      *>  read file
       open input w-file.
       perform until wseof='y'
           read w-file into linecontents
              at end move 'y' to wseof
              not at end
                      *> append line to contents
                      string contents delimited by space
                          linecontents delimited by space
                          into contents
                      end-string
           end-read
       end-perform
       close w-file.


      *>  Get file length
       compute filelength = 1 + function length(function trim(contents)).
      *>  Loop through file
       perform a-para varying idx from 1 by 1 until idx = filelength.
       stop run.

       a-para.
      *>  Get current character
       move contents(idx:1) to currentchar.
       if currentchar = 'h' or currentchar = 'H' then
           display "Hello, world!" with no advancing
       end-if.
       if currentchar = 'q' or currentchar = 'Q' then
           display function trim(contents)
       end-if.
       if currentchar = '9' then
           perform 99-para varying bottlecounter from 99 by -1 until bottlecounter = 0
       end-if.
       if currentchar = '+' then
           compute accum = accum + 1
       end-if.

       99-para.
       if bottlecounter > 1 then
           move bottlecounter to formatted-integer
           display function trim(formatted-integer) " bottles of beer on the wall, " function trim(formatted-integer) " bottles of beer."

           compute bottlecounter-minus1 = bottlecounter - 1
           move bottlecounter-minus1 to formatted-integer
           display "Take one down and pass it around, " function trim(formatted-integer) " bottles of beer on the wall."
           display " "
       end-if.
       if bottlecounter = 1 then
           display "1 bottle of beer on the wall, 1 bottle of beer."
           display "Take one down and pass it around, no more bottles of beer on the wall."
           display " "
           display "No more bottles of beer on the wall, no more bottles of beer."
           display "Go to the store and buy some more, 99 bottles of beer on the wall."
       end-if.

