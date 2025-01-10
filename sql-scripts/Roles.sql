/*
* Jashanpreet Kaur
* November 24, 2024
*/

-- Create roles for different user types
CREATE ROLE ClientRole;           
CREATE ROLE TherapistRole;        
CREATE ROLE PlatformManagerRole;  

-- Create corresponding logins and users for each role
CREATE LOGIN ClientUser WITH PASSWORD = 'Client_Pass123!';
CREATE LOGIN TherapistUser WITH PASSWORD = 'Therapist_Pass123!';
CREATE LOGIN ManagerUser WITH PASSWORD = 'Manager_Pass123!';

USE FinalTerm;

-- Create database users linked to logins
CREATE USER Jashan FOR LOGIN ClientUser;
CREATE USER Mike FOR LOGIN TherapistUser;
CREATE USER MichaelK FOR LOGIN ManagerUser;

-- Define role permissions

-- Client Role: View personal details, book sessions, and provide feedback
GRANT SELECT ON Client TO ClientRole; 
GRANT SELECT, INSERT ON Session_booking TO ClientRole; 
GRANT SELECT, INSERT ON Feedback TO ClientRole;

-- Therapist Role: Manage therapy sessions and view feedback
GRANT SELECT, INSERT, UPDATE ON Therapy_Session TO TherapistRole; 
GRANT SELECT ON Feedback TO TherapistRole; 
GRANT SELECT ON Session_booking TO TherapistRole; 

-- Platform Manager Role: Oversee platform data and operations (read/write access to most tables)
GRANT SELECT, UPDATE, DELETE ON Client TO PlatformManagerRole; 
GRANT SELECT, UPDATE ON Therapist_Specialization TO PlatformManagerRole; 
GRANT SELECT, INSERT, UPDATE ON Session_booking TO PlatformManagerRole; 
GRANT SELECT ON Therapy_Session TO PlatformManagerRole; 
GRANT SELECT, UPDATE, DELETE ON Feedback TO PlatformManagerRole;

-- Assign users to respective roles
EXEC sp_addrolemember 'ClientRole','Jashan';
EXEC sp_addrolemember 'TherapistRole','Mike';
EXEC sp_addrolemember 'PlatformManagerRole','MichaelK';


SELECT USER;
EXECUTE AS USER = 'Jashan';
SELECT USER;

--To Verify
SELECT * FROM Client; --aloowed
INSERT INTO Client (first_name, last_name, email, phoneNum, gender)
	VALUES ('Jashan', 'Sran', 'jashan3556@hmksnl', 292739272910, 'F')

REVERT;
SELECT USER;
EXECUTE AS USER = 'Mike';
SELECT * FROM Client; -- denied

