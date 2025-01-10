# 3NF
Created csv files with required coloums data after removing all duplicates and have it in Third normal form.

Ensure each non-key column is only dependent on the primary key, and remove any transitive dependencies.

# Import Instructions for iCare4U Database

This document provides step-by-step instructions for importing normalized CSV files into the iCare4U database using SQL Server Management Studio (SSMS) Import and Export Wizard.

# Prerequisites

1. Install SQL Server Management Studio (SSMS).
2. Ensure you have access to the database where the data will be imported.
3. Place the normalized CSV files in an accessible folder.

# Steps to Import CSV Files
Follow these steps for each table:

1. Open the Import Wizard
    Launch SQL Server Management Studio (SSMS).
    Right-click on the target database (e.g., iCare4U) in the Object Explorer.
    Select Tasks > Import Data... to open the Import and Export Wizard.
    Choose Data Source

2. In the wizard:
    Set Data Source to Flat File Source.
    Click Browse... to locate the corresponding CSV file (e.g., clients.csv).
    Ensure the file format matches the CSV settings:
    Delimiter: Comma (,)
    First row has column names: Check this box.

3. Configure Destination

    Set Destination to SQL Server Native Client or Microsoft OLE DB Provider for SQL Server as required.
    Enter your Server Name (ServerName\InstanceName)  and select the target database (e.g., iCare4U).
    Use Windows Authentication.


4. Map Columns

    Use the Column Mapping screen to map CSV fields to the target table's columns.
    Verify that all fields are correctly matched.

5. Preview and Run

    Preview the data to confirm the mapping is correct.
    Click Next and then Finish to start the import process.

6. Verify Data

After importing, run a SELECT query in SSMS to verify that the data is correctly loaded into the target table.


SELECT * FROM clients;
OR
Right-click on any table after refreshing and select show top 1000 rows, and modify code as reuired to show all by removing top[1000] from first line of code.

# Order of Import
Import tables in the correct sequence to respect foreign key relationships. Follow this order for the iCare4U platform:

clients.csv
therapists.csv
therapy_sessions.csv
specializations.csv (bridge table for many-to-many relationships)
feedback.csv 
bookings.csv


# Troubleshooting Data Format Issues

Ensure appropriate size for all fields such as CHAR(1) is emough for gender column.
Validate numeric fields and remove invalid characters.

# Column Mapping Errors

Double-check that the CSV headers match the table column names.

# Foreign Key Constraints

Ensure related tables are imported first to avoid violating foreign key constraints.

# Sample Files
Place the CSV files in the /data/ folder for convenience. Example:

clients.csv
therapists.csv
bookings.csv
specializations.csv
feedback.csv
therapy_sessions.csv

# For further assistance, feel free to contact the me at jashanpreetkaur110424@gmail.com or connect with me on [Linkedin](https://www.linkedin.com/in/jashanpreetkaursran/)