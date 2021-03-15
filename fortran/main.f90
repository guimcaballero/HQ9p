program main
  implicit none

  integer :: num_args, ix
  character(len=50) :: filename
  character(len=:), allocatable :: contents

  integer :: iunit,istat,filesize
  character(len=1) :: c

  num_args = command_argument_count()
  if (num_args < 1) then
    call exit(1)
  end if

  ! Get filename
  call get_command_argument(1, filename)

  ! Open file
  open(newunit=iunit,file=filename,status='OLD',&
    form='UNFORMATTED',access='STREAM',iostat=istat)

  ! Read file
  if (istat==0) then
    inquire(file=filename, size=filesize)
    if (filesize>0) then
      allocate( character(len=filesize) :: contents )
      read(iunit,pos=1,iostat=istat) contents

      if (istat==0) then
        read(iunit,pos=filesize+1,iostat=istat) c
        if (.not. IS_IOSTAT_END(istat)) &
          call exit(1)
          ! 'Error: file was not completely read.'
      else
        call exit(1)
        ! 'Error reading file.'
      end if

      call execute(filesize, contents)

      close(iunit, iostat=istat)
    else
      call exit(1)
      ! 'Error getting file size.'
    end if
  else
    call exit(1)
    ! 'Error opening file.'
  end if

contains
  subroutine execute(len, contents)
    implicit none
    character :: contents(len)
    integer :: i, len, accum

    accum = 0

    do i = 1, len
      select case (contents(i))
        case ('H', 'h')
          write (*, "(A)", advance="no") "Hello, world!"
        case ('Q', 'q')
          write (*, "(1000A)", advance="no") contents
        case ('9')
          call print99()
        case ('+')
          accum = accum + 1
      end select
    end do
  end subroutine execute

  subroutine print99()
    implicit none
    integer :: i
    character(len=100) :: string

    i = 99

    do while (i > 0)
      ! Turn index to string
      write(string, '(i0)') i

      write (*, "(A)") trim(string)//" bottles of beer on the wall, "//trim(string)//" bottles of beer."
      i = i - 1

      if (i /= 0) then
        write (*, "(A)") "Take one down and pass it around, "//trim(string)//" bottles of beer on the wall."
        write (*, "(A)") ""
      else
        write (*, "(A)") "Take one down and pass it around, no more bottles of beer on the wall."
        write (*, "(A)") ""
        write (*, "(A)") "No more bottles of beer on the wall, no more bottles of beer."
        write (*, "(A)") "Go to the store and buy some more, 99 bottles of beer on the wall."
      end if
    end do
  end subroutine print99
end program main

! Help from: https://community.intel.com/t5/Intel-Fortran-Compiler/Text-file-to-allocatable-string/td-p/1033082
