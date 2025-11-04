       IDENTIFICATION DIVISION.
       PROGRAM-ID. simple-hello.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NAME PIC X(12) VALUE 'Kai'.
       01 AGE  PIC 99 VALUE 38.

       PROCEDURE DIVISION.
           DISPLAY "Enter your name: "
           ACCEPT NAME
           DISPLAY "Enter your age: "
           ACCEPT AGE
           ADD 1 TO AGE
           SUBTRACT 1 FROM AGE
           DISPLAY "Hello, " NAME " - you are " AGE " years old."

           STOP RUN.
