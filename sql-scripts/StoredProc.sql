/*
* Jashanpreet Kaur
* November 24, 2024
* Performs an updation of the booking status. If the bookingID is not there, lets the user know by raising an error. Otherwise, updates the status as per input provided for the given bookingID.
*/

CREATE OR ALTER PROCEDURE usp_UpdateBookingStatus
    @bookingID INT,
    @newStatus VARCHAR(15),
    @success BIT OUTPUT,
    @message VARCHAR(70) OUTPUT
AS
BEGIN
    --SET NOCOUNT ON;
    -- Initialize output parameters
    SET @success = 0;  -- Default to failure
    SET @message = '';  -- Clear any previous message

    -- Start the transaction
    BEGIN TRY
        BEGIN TRANSACTION;  -- Start the transaction here

        -- Basic validation
        IF NOT EXISTS (
				SELECT 1 
				FROM Session_booking 
				WHERE bookingID = @bookingID
				)
        BEGIN
            -- If the booking does not exist, set error message and rollback
            SET @message = 'Booking not found. Please try again.';
            ROLLBACK TRANSACTION;  -- Rollback the transaction
            RETURN;  -- Exit the procedure
        END

        -- Update the status
        UPDATE Session_booking
        SET booking_status = @newStatus
        WHERE bookingID = @bookingID;

        -- Commit the transaction if everything is successful
        COMMIT TRANSACTION;  -- Commit the transaction
        SET @success = 1;    -- Indicate success
        SET @message = 'Booking updated successfully to '+ @newStatus;  -- Success message

    END TRY
    BEGIN CATCH
        -- Rollback if there was an error; check if a transaction is still open
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;  -- Rollback the transaction
        END
        
        -- Set the output parameters for error handling
        SET @success = 0;  -- Indicate failure
        SET @message = ERROR_MESSAGE();  -- Get the error message
    END CATCH;
END;


-- Declare variables for output parameters
DECLARE 
	@successRate BIT, 
	@msg VARCHAR(70);

-- Execute the stored procedure
EXEC usp_UpdateBookingStatus 
    @bookingID = 19,  
    @newStatus = 'Completed',  
    @success = @successRate OUTPUT,
    @message = @msg OUTPUT;

-- Display the result
SELECT @successRate AS Success, @msg AS Message;


--To verify
SELECT *
FROM Session_booking
WHERE bookingID = 19;
