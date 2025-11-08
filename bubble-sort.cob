       IDENTIFICATION DIVISION.
       PROGRAM-ID. BUBBLE-SORT.
       REMARKS. program demonstrates bubble sort algorithm.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ARRAY-LENGTH PIC 9(2) VALUE 5.
       01 ARRAY        PIC 9(4) OCCURS 5 TIMES.
       01 I            PIC 9(2).
       01 J            PIC 9(2).
       01 TEMP         PIC 9(4).

       PROCEDURE DIVISION.
           MOVE 3 TO ARRAY(1)
           MOVE 6 TO ARRAY(2)
           MOVE 8 TO ARRAY(3)
           MOVE 2 TO ARRAY(4)
           MOVE 7 TO ARRAY(5)

           DISPLAY "Original Array: ".
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > ARRAY-LENGTH
              DISPLAY ARRAY(I)
           END-PERFORM

           PERFORM SORT-ARRAY

           DISPLAY "Sorted Array: ".
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > ARRAY-LENGTH
              DISPLAY ARRAY(I)
           END-PERFORM

           STOP RUN.

       SORT-ARRAY SECTION.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > ARRAY-LENGTH - 1
              PERFORM VARYING J FROM 1 BY 1 UNTIL J > ARRAY-LENGTH - I
                 IF ARRAY(J) > ARRAY(J + 1)
                    MOVE ARRAY(J) TO TEMP
                    MOVE ARRAY(J + 1) TO ARRAY(J)
                    MOVE TEMP TO ARRAY(J + 1)
                 END-IF
              END-PERFORM
           END-PERFORM
           EXIT.
