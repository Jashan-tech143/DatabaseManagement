/* 
* Name: Jashanpreet kaur
* Project Name: iCare4u
*/

DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Therapists;
DROP TABLE IF EXISTS Therapy_Session;

DROP TABLE IF EXISTS Session_booking;
DROP TABLE IF EXISTS Feedback;
DROP TABLE IF EXISTS Therapist_Specialization;


CREATE TABLE Therapists (
    therapistID INT IDENTITY(1,1),
    therapist_first_name NVARCHAR(30) NOT NULL,
    therapist_last_name NVARCHAR(30) NOT NULL,
    specialization NVARCHAR(45),
    contactNum NVARCHAR(10) NOT NULL,

	CONSTRAINT PK_Therapist
		PRIMARY KEY (therapistID)
);

CREATE TABLE Client (
    clientID INT IDENTITY(1,1),
	first_name NVARCHAR(35) NOT NULL,
	last_name NVARCHAR(35) NOT NULL, 
	email NVARCHAR(60) UNIQUE NOT NULL,
    phoneNum NVARCHAR(15) NOT NULL,
    gender CHAR(1) 

	CONSTRAINT PK_Client
		PRIMARY KEY (clientID),
	CONSTRAINT chk_gender CHECK (gender IN ('M', 'F', 'O'))
);

CREATE TABLE Therapy_Session (
    sessionID INT IDENTITY(1,1),
	cost DECIMAL(6,2) NOT NULL,		
    duration INT NOT NULL,		
    session_name NVARCHAR(45) NOT NULL,

	CONSTRAINT PK_Session_Therpy
		PRIMARY KEY (sessionID),
	CONSTRAINT chk_duration CHECK (duration > 0), -- in minutes basically
	CONSTRAINT chk_cost CHECK (cost >= 0),

);

CREATE TABLE Session_booking (
    bookingID INT IDENTITY(1,1),
    therapistID INT NOT NULL,
    sessionID INT NOT NULL,
    clientID INT NOT NULL,
    session_date DATETIME NOT NULL,
    booking_status NVARCHAR(12) NOT NULL 
	
    CONSTRAINT PK_booking
		PRIMARY KEY (bookingID),

	CONSTRAINT FK_Therpist_assigned
		FOREIGN KEY (therapistID) 
		REFERENCES Therapists(therapistID),

	CONSTRAINT FK_session_included
		FOREIGN KEY (sessionID) 
		REFERENCES Therapy_Session(sessionID),

	CONSTRAINT FK_client_booked
		FOREIGN KEY (clientID) 
		REFERENCES Client(clientID),

	CONSTRAINT chk_status 
	CHECK (booking_status IN ('Pending', 'Completed', 'Cancelled')),
);

CREATE TABLE Feedback (
    feedbackID INT IDENTITY(1,1),
    therapistID INT NOT NULL,
    sessionID INT NOT NULL,
    clientID INT NOT NULL,
    rating INT NOT NULL,
	comments TEXT,

	CONSTRAINT PK_feedback
		PRIMARY KEY (feedbackID),

	CONSTRAINT FK_Therapist_rates
		FOREIGN KEY (therapistID) 
		REFERENCES Therapists(therapistID),

	CONSTRAINT FK_session_rates
		FOREIGN KEY (sessionID) 
		REFERENCES Therapy_Session(sessionID),

	CONSTRAINT FK_client_submit
		FOREIGN KEY (clientID) 
		REFERENCES Client(clientID),

	CONSTRAINT chk_rating 
		CHECK (rating BETWEEN 1 AND 5),
);

CREATE TABLE Therapist_Specialization (
    specializationID INT IDENTITY(1,1),
    therapistID INT NOT NULL,
    sessionID INT NOT NULL,

	CONSTRAINT PK_spc_Therapy
		PRIMARY KEY (specializationID),

	CONSTRAINT FK_therapist_sp
		FOREIGN KEY (therapistID) 
		REFERENCES Therapists(therapistID),

	CONSTRAINT FK_TherapySession_specialization
		FOREIGN KEY (sessionID) 
		REFERENCES Therapy_session(sessionID)
);


---Indexes for better performance
CREATE NONCLUSTERED INDEX index_Therapist_spc On Therapists (specialization); --- in real world, client will search mostly by specialization to see therapists available

CREATE NONCLUSTERED INDEX index_booking_sessionDate On Session_booking (session_date); -- to filter by date of session
CREATE NONCLUSTERED INDEX index_client_name On Client (first_name, last_name); -- to filter by client's name :- by Admin & Company


-- for verifying
/*
SELECT *
FROM Therapists; 

SELECT *
FROM Therapy_session;

SELECT *
FROM Session_booking
WHERE clientID = '1';

SELECT *
FROM feedback;

SELECT *
FROM therapist_specialization;

SELECT *
FROM Client
WHERE clientID = '1';
*/