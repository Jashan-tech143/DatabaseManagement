/*
* Jashanpreet Kaur
* November 24, 2024
* To count upcoming sessions for a therapist
* Returns count of all pending/upcoming sessions after current date
*/

CREATE OR ALTER FUNCTION ufn_GetUpcomingSessions
(
    @therapistID INT
)
RETURNS INT
AS
BEGIN
    DECLARE 
		@sessionCount INT

    SELECT @sessionCount = COUNT(*)
    FROM Session_booking 
    WHERE therapistID = @therapistID
    AND session_date > GETDATE()
    AND booking_status = 'Pending'

    RETURN ISNULL(@sessionCount, 0) --- if no pending session upcoming, returns 0 
END;

--executing function to see as per provided therapistID
SELECT dbo.ufn_GetUpcomingSessions(2) AS "Upcoming Sessions";
