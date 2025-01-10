/* 
 * Name: Jashanpreet kaur
 * Project Name: iCare4u
 */
--Retrieve therapist and session details for booked sessions(recent first). Joining to get session_name through session_Booking table
SELECT
    t.therapistID,
    t.therapist_first_name,
    t.therapist_last_name,
    ts.session_name,
    ts.cost,
    sb.session_date
FROM
    Therapists t
    INNER JOIN Session_booking sb ON t.therapistID = sb.therapistID
    INNER JOIN Therapy_Session ts ON sb.sessionID = ts.sessionID
ORDER BY
    session_date DESC;

--Retrieve detailed booking information from 3 tables
SELECT
    c.clientID,
    c.first_name AS client_first_name,
    c.last_name AS client_last_name,
    t.therapist_first_name,
    t.therapist_last_name,
    ts.session_name,
    sb.session_date,
    sb.booking_status --fb.comments as well
FROM
    Session_booking sb
    INNER JOIN Client c ON sb.clientID = c.clientID
    INNER JOIN Therapists t ON sb.therapistID = t.therapistID
    INNER JOIN Therapy_Session ts ON sb.sessionID = ts.sessionID;

--Show all therapy sessions, including those without bookings or feedback
SELECT
    ts.sessionID,
    ts.session_name,
    ts.cost,
    sb.bookingID,
    sb.session_date,
    f.rating
FROM
    Therapy_Session ts
    LEFT OUTER JOIN Session_booking sb ON ts.sessionID = sb.sessionID
    LEFT OUTER JOIN Feedback f ON ts.sessionID = f.sessionID;

/*
INSERT INTO Therapy_Session (cost, duration, session_name)
VALUES  (129.04, 60, 'Dog Therapy');
 */
--Shows clients who have booked sessions more expensive than the average session cost(Subquery does not depend on any values from the outer query for its execution. It executes independently and provides a result that is then used in the WHERE clause of the outer query)
SELECT
    c.clientID,
    c.first_name,
    c.last_name
FROM
    Client c
WHERE
    c.clientID IN (
        SELECT DISTINCT
            clientID
        FROM
            Session_booking sb
            INNER JOIN Therapy_Session ts ON sb.sessionID = ts.sessionID
        WHERE
            ts.cost > (
                SELECT
                    AVG(cost)
                FROM
                    Therapy_Session
            )
    );

-- Find clients who have booked more than one session. Using c.clientID in subquery
SELECT
    c.clientID,
    c.first_name,
    c.last_name,
    (
        SELECT
            COUNT(*)
        FROM
            Session_booking sb
        WHERE
            sb.clientID = c.clientID
    ) AS total_bookings
FROM
    Client c
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            Session_booking sb
        WHERE
            sb.clientID = c.clientID
    ) > 1;

--Data aggregation
SELECT
    t.therapistID,
    t.therapist_first_name,
    t.therapist_last_name,
    COUNT(sb.sessionID) AS total_sessions,
    SUM(ts.cost) AS total_revenue,
    AVG(ts.duration) AS avg_session_duration_in_minutes
FROM
    Therapists t
    LEFT JOIN Session_booking sb ON t.therapistID = sb.therapistID
    LEFT JOIN Therapy_Session ts ON sb.sessionID = ts.sessionID
GROUP BY
    t.therapistID,
    t.therapist_first_name,
    t.therapist_last_name
ORDER BY
    total_revenue DESC;

/*
## TO Verify

SELECT *
FROM 
Therapists t
LEFT JOIN 
Session_booking sb ON t.therapistID = sb.therapistID
LEFT JOIN 
Therapy_Session ts ON sb.sessionID = ts.sessionID
WHERE
t.therapistID = 1;
 */