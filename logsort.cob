       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOGSORT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LOGFILE ASSIGN TO "logs.dat"
                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  LOGFILE.
       01  LOG-REC        PIC X(80).

       WORKING-STORAGE SECTION.
       77  EOF-FLAG         PIC 9 VALUE 0.
       77  ZEILEN           PIC 9(4) VALUE 0.
       77  I                PIC 9(4) VALUE 0.
       77  J                PIC 9(4) VALUE 0.
       77  J-PLUS-ONE       PIC 9(4) VALUE 0.
       77  MAX-ROWS         PIC 9(4) VALUE 500.
       77  FOUND-FLAG       PIC 9 VALUE 0.
       77  IDX              PIC 9(4) VALUE 0.
       77  SWAP-IDX1        PIC 9(4) VALUE 0.
       77  SWAP-IDX2        PIC 9(4) VALUE 0.
       77  TMP-TEXT         PIC X(80).
       77  TMP-COUNT        PIC 9(5).

       01  ENTRY-TABLE.
           05  ENTRY-ROW OCCURS 500 TIMES INDEXED BY IDX-ENTRY.
               10  ENTRY-TEXT  PIC X(80).
               10  ENTRY-COUNT PIC 9(5) VALUE 0.

       PROCEDURE DIVISION.
       BEGIN.
           OPEN INPUT LOGFILE
           PERFORM UNTIL EOF-FLAG = 1
              READ LOGFILE
                 AT END
                    MOVE 1 TO EOF-FLAG
                 NOT AT END
                    PERFORM ADD-OR-COUNT
              END-READ
           END-PERFORM

           PERFORM SORT-TABLE

           DISPLAY "Top Log-Einträge nach Haeufigkeit:"
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > MAX-ROWS
              IF ENTRY-COUNT(I) > 0
                 DISPLAY ENTRY-COUNT(I) "x " ENTRY-TEXT(I)
              END-IF
           END-PERFORM

           DISPLAY "Anzahl verschiedener Eintraege: " ZEILEN
           CLOSE LOGFILE
           STOP RUN.

      * Sucht LOG-REC in der Tabelle, erhoeht Count, ggf. neuer Eintrag
       ADD-OR-COUNT.
           MOVE 0 TO FOUND-FLAG
           PERFORM VARYING IDX FROM 1 BY 1
                   UNTIL IDX > ZEILEN OR FOUND-FLAG = 1
              IF ENTRY-TEXT(IDX) = LOG-REC
                 ADD 1 TO ENTRY-COUNT(IDX)
                 MOVE 1 TO FOUND-FLAG
              END-IF
           END-PERFORM
           IF FOUND-FLAG = 0
              ADD 1 TO ZEILEN
              MOVE LOG-REC TO ENTRY-TEXT(ZEILEN)
              MOVE 1 TO ENTRY-COUNT(ZEILEN)
           END-IF.

      * Bubble Sort nach ENTRY-COUNT absteigend
       SORT-TABLE.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > ZEILEN
              PERFORM VARYING J FROM 1 BY 1 UNTIL J > ZEILEN - I
                 COMPUTE J-PLUS-ONE = J + 1
                 IF ENTRY-COUNT(J) < ENTRY-COUNT(J-PLUS-ONE)
                    MOVE J          TO SWAP-IDX1
                    MOVE J-PLUS-ONE TO SWAP-IDX2
                    PERFORM SWAP-ROWS
                 END-IF
              END-PERFORM
           END-PERFORM.

       SWAP-ROWS.
           MOVE ENTRY-TEXT(SWAP-IDX1)   TO TMP-TEXT
           MOVE ENTRY-TEXT(SWAP-IDX2)   TO ENTRY-TEXT(SWAP-IDX1)
           MOVE TMP-TEXT                TO ENTRY-TEXT(SWAP-IDX2)
           MOVE ENTRY-COUNT(SWAP-IDX1)  TO TMP-COUNT
           MOVE ENTRY-COUNT(SWAP-IDX2)  TO ENTRY-COUNT(SWAP-IDX1)
           MOVE TMP-COUNT               TO ENTRY-COUNT(SWAP-IDX2).
