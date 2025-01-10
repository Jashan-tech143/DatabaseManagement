# iCare4U - SSRS Reports Documentation

This section describes the creation, deployment, and access of SQL Server Reporting Services (SSRS) reports in the iCare4U project. SSRS is used to generate reports that provide insights into client sessions, bookings, therapist details, and other key metrics. The reports are created in Visual Studio and deployed to the SSRS web portal for browser-based access.

# Prerequisites
SQL Server Reporting Services (SSRS): Installed and configured on your server.
Visual Studio: Installed with the SSRS reporting extension.
SQL Server Database: The FinalTerm database, containing client, therapist, session, and booking data.
Report Creation

# Set Up Report Project in Visual Studio:

Open Visual Studio and create a new Report Server Project.
Define the data source connection to the FinalTerm database.
Design datasets using SQL queries to retrieve the necessary data, such as:
Sessions booked by clients
Therapist details and session history
Booking status and revenue analytics

# Design Reports:

Use Report Designer to add tables, charts, and visuals.
Create parameterized reports to allow for dynamic filtering (e.g., by ClientID or date).
Customize the report layout, format, and style to meet project requirements.

Example SQL query used in reports (might need to change accordingly):

SELECT 
    c.first_name AS FirstName,
    c.last_name AS LastName,
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
    c.clientID = @ClientID
ORDER BY 
    sb.session_date;

# Test Reports Locally:

Use Visual Studio’s preview option to test the reports before deployment.
Ensure data displays correctly and the report’s interactive features work as expected.
Report Deployment

# Deploy to SSRS Web Portal:

Right-click the project title in Visual Studio and select Deploy.
The deployment will push the reports to the configured SSRS Web Portal.
Set up appropriate folder structure on the SSRS server to store reports.

# Configure Security and Permissions:

Set up user roles in SSRS to control access to the reports.
Ensure that only authorized users can access sensitive client and session data.

# Verify Report Accessibility:

Open a web browser and navigate to the SSRS web portal (typically http://<server>/reports).
Verify that the reports are listed and accessible by authorized users.
Check that filters and parameters function correctly when accessing reports.

# Accessing Reports via Browser
Log in to SSRS Web Portal
Open a browser and navigate to the SSRS portal URL (http://<server>/reports).
Enter login credentials if required.

Navigate to the Report:

Browse to the folder where the reports are deployed.
Select the desired report from the list.

View and Interact with Reports:

Users can view detailed session data, booking status, therapist performance, etc.
Filters can be applied to generate customized views (e.g., by client or date).
Reports can be exported to various formats such as PDF, Excel, or Word for further analysis.

Here's how it would look in browser:
![SQL Server Reporting Services](<Reporting Services Folder.png>)