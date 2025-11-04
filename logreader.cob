       IDENTIFICATION DIVISION.
      *Programm liest ein Logfile und zeigt es an
       PROGRAM-ID. LOGREADER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LOGFILE ASSIGN TO "logs.dat"
                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  LOGFILE.
       01  LOG-ENTRY.
           05  LOG-DATE        PIC X(10).
           05  FILLER          PIC X.
           05  LOG-LEVEL       PIC X(7).
           05  FILLER          PIC X.
           05  LOG-MESSAGE     PIC X(30).

       WORKING-STORAGE SECTION.
       01  EOF                 PIC X VALUE "N".
       01  LINE-COUNT          PIC 9(4) VALUE 0.

       PROCEDURE DIVISION.
           PERFORM BEGIN
           STOP RUN.

       BEGIN.
           OPEN INPUT LOGFILE
           PERFORM UNTIL EOF = "Y"
              READ LOGFILE
                 AT END
                    MOVE "Y" TO EOF
                 NOT AT END
                    IF LOG-LEVEL = "LEVEL-0"
                       DISPLAY "# [" LOG-DATE "] " LOG-MESSAGE
                       ADD 1 TO LINE-COUNT
                    END-IF
              END-READ
           END-PERFORM
           CLOSE LOGFILE
           DISPLAY "Anzahl der ausgegebenen Zeilen: " LINE-COUNT
           GOBACK.
