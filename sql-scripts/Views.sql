/*
* Jashanpreet Kaur
* November 24, 2024
* Shows all current active sessions with necessary details. Only shows 'Pending' and 'Completed' sessions, restricting cancelled ones.
*/

CREATE OR ALTER VIEW vw_TherapistActiveSessions AS
SELECT 
    b.bookingID,
    t.therapist_first_name + ' ' + t.therapist_last_name AS therapist_name,
    c.first_name + ' ' + c.last_name AS client_name,
    ts.session_name,
    ts.cost,
    b.session_date,
    b.booking_status

FROM Session_booking b
JOIN Therapists t 
	ON b.therapistID = t.therapistID
JOIN Client c 
	ON b.clientID = c.clientID
JOIN Therapy_Session ts 
	ON b.sessionID = ts.sessionID

WHERE b.booking_status 
	IN ('Pending', 'Completed');

--To verify
SELECT *
FROM vw_TherapistActiveSessions;

/*
* Shows therapist ratings and feedback counts. Only shows therapists who have received feedbacks.
*/

CREATE OR ALTER VIEW vw_TherapistFeedbackRatings AS
SELECT 
    t.therapistID,
    t.therapist_first_name + ' ' + t.therapist_last_name AS therapist_name,
    t.specialization,
    COUNT(f.feedbackID) AS total_feedback,
    CAST(ROUND(AVG(CAST(f.rating AS DECIMAL(3,2))), 2) AS DECIMAL(3,1)) AS average_rating

FROM Therapists t
JOIN Feedback f ON t.therapistID = f.therapistID

GROUP BY 
    t.therapistID,
    t.therapist_first_name,
    t.therapist_last_name,
    t.specialization ; --- calculates for each Therapist


SELECT *
FROM vw_TherapistFeedbackRatings;