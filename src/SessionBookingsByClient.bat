@ECHO OFF
REM ***************************************************************
REM Author:       Jashanpreet Kaur
REM Date Written: November 30 2024
REM Purpose:      Generate a report for sessions booked by a client in iCare4U Platform
REM **************************************************************

REM ***************************************************************
REM Display the menu. Validate the item selected and take appropriate action.
REM **************************************************************
:DisplayMenu
CLS
ECHO.
ECHO 'iCare4u' Report Generator
ECHO.
ECHO 1. Generate Sessions Booked by Client Report
ECHO 2. Exit
ECHO.
SET choice=
SET /P choice=Enter your choice: 
IF '%choice%'=='' GOTO NothingSelected
IF '%choice%'=='1' GOTO GenerateClientSessionReport
IF '%choice%'=='2' GOTO ExitSelected
REM ***************************************************************
REM An invalid menu number was selected. Display an error then redisplay the menu.
REM ***************************************************************
ECHO.
ECHO Error - Invalid choice entered. Please choose a valid option.
ECHO.
PAUSE
GOTO DisplayMenu

REM ***************************************************************
REM The user just pressed enter. Display an error then redisplay the menu.
REM ***************************************************************
:NothingSelected
   ECHO.
   ECHO Error - No choice entered. Please choose an option displayed.
   ECHO.
   PAUSE
   GOTO DisplayMenu

REM *************************************************************
REM The user selected option 1. Generate the Sessions Report, then redisplay the menu.
REM *************************************************************
:GenerateClientSessionReport
    CLS
    IF NOT EXIST C:\iCare4U\Reports MKDIR C:\iCare4U\Reports
    SET /P clientID=Enter a valid ClientID:	
    ECHO Creating Sessions Booked by Client Report...

    REM Run the SQL query to generate the report and save it in a text file
    sqlcmd -S JASHANSRAN\MOON -i generateClientSessionReport.sql -o sessionBookingsByClient_Report.txt -E -v ClientID=%clientID%

    ECHO Sessions Booked by Client Report generated successfully.
    PAUSE
    GOTO DisplayMenu

REM **************************************************************
REM The user selected termination. End the batch script.
REM **************************************************************
:ExitSelected
    ECHO Exiting... Thank you for using the 'iCare4u' Report Generator!
    PAUSE
    EXIT
