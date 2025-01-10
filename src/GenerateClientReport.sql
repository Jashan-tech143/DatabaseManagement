USE FinalTerm; --database name

SET NOCOUNT ON

--  for troubleshooting purposes
--  PRINT $(ClientID)
--  Query to get sessions booked by a specific client
SELECT 
    c.first_name AS FirstName,
    c.last_name AS  LastName,
    ts.session_name AS Session,
    sb.session_date AS Date,
    sb.booking_status AS Status
    
FROM 
    Client c
JOIN 
    Session_booking sb ON c.clientID = sb.clientID
JOIN 
    Therapy_Session ts ON sb.sessionID = ts.sessionID
WHERE 
    c.clientID = $(ClientID) -- This parameter will be substituted from the batch file
ORDER BY 
    sb.session_date;
