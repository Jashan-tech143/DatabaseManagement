/*
* Jashanpreet Kaur
* November 24, 2024
* Prevents the double-booking for a Therapist. Does not allow another booking for a Therapist at the same time unless the previous record has been cancelled.
*/


CREATE OR ALTER TRIGGER PreventDoubleBooking
ON Session_booking
AFTER INSERT, UPDATE  -- after operation has been applied to the data table
AS
BEGIN
    IF EXISTS (
        SELECT 1														----presence of any row
        FROM inserted i
        INNER JOIN Session_booking sb 
            ON i.therapistID = sb.therapistID
            AND i.session_date = sb.session_date

            AND i.bookingID != sb.bookingID
            AND sb.booking_status != 'Cancelled'
    )
    BEGIN
        RAISERROR ('This therapist is already booked for this time slot.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS PreventDoubleBooking;

