# Rushmore-Pizzeria1
Rushmore Pizzeria database schema and cloud deployment scripts for PostgreSQL.


SELECT table_name,
       (xpath('/row/cnt/text()', xml_count))[1]::text::int AS row_count
FROM (
    SELECT table_name,
           query_to_xml(
               format('SELECT COUNT(*) AS cnt FROM %I.%I', table_schema, table_name),
               false,
               true,
               ''
           ) AS xml_count
    FROM information_schema.tables
    WHERE table_schema = 'pizzeria'
) t
ORDER BY table_name;
Rushmore Pizzeria — End-to-End Data Engineering Project

(Presentation-Ready Summary)

⸻

🔹 Project Overview

The Rushmore Pizzeria Data Engineering Project is a complete, end-to-end data solution built to simulate a real operational analytics system for a multi-store restaurant chain.

This project demonstrates:
	•	Data modeling and database design
	•	ETL pipeline engineering
	•	Synthetic data generation using Python
	•	SQL analytics and business metric calculations
	•	Interactive Power BI reporting and visualisation

It is a strong demonstration of data engineering and BI skills appropriate for professional and recruitment showcases.

⸻

🔹 Business Problem

Rushmore Pizzeria needs a modern analytics system to answer key operational questions:
	•	Which stores perform best?
	•	Who are the top customers?
	•	What items sell the most?
	•	What is the busiest order hour?
	•	What is the average order value?
	•	How are ingredients consumed across menu items?

The solution had to be scalable, maintainable, and aligned with real-world industry practices.
Technical 
Layer
Tools
Database
PostgreSQL 17, pgAdmin 4
ETL & Data Generation
Python (Faker, psycopg2)
Modeling
Lucidchart ERD
Analytics
SQL (aggregations, joins, window functions)
Reporting
Power BI Desktop
Version Control
Git & GitHub
Layer
Tools
Database
PostgreSQL 17, pgAdmin 4
ETL & Data Generation
Python (Faker, psycopg2)
Modeling
Lucidchart ERD
Analytics
SQL (aggregations, joins, window functions)
Reporting
Power BI Desktop
Version Control
Git & GitHub
Rushmore-Pizzeria/
│
├── sql/
│   ├── create_tables.sql
│   ├── analytical_queries.sql
│
├── python/
│   ├── populate.py
│
├── powerbi/
│   ├── Rushmore-Pizzeria.pbix
│
├── images/
│   ├── erd.png
│   ├── dashboard.png
│
└── README.me

Challenges Faced During the Project

1. Power BI & PostgreSQL Connection Issues
	•	Power BI repeatedly failed to connect due to:
	•	Wrong username formatting
	•	SSL requirements from Azure
	•	Incorrect database names
	•	Solution: correct the server username (rushmore_admin), enable SSL, and connect via the correct DB.

⸻

2. Navigating Azure Firewall & Network Permissions
	•	Azure PostgreSQL initially blocked all external connections.
	•	We had to enable:
	•	Firewall rule: “Allow Azure services and resources to access this server”
	•	Add client IP manually
	•	Connection succeeded only after adjusting firewall rules.

⸻

3. Schema vs Public Confusion
	•	Data inserted into schema pizzeria did not show under public, causing confusion.
	•	Power BI imported wrong schema (public) which was empty.
	•	Solution: Refresh metadata and explicitly select schema: pizzeria.

⸻

4. Power BI’s Left Panel Disappearing
	•	Power BI hid the Visualization/Fields panel due to UI collapse.
	•	This halted progress because visualisations couldn’t be created.
	•	Solution: Expand the layout + reset Power BI interface.

⸻

5. Wrong Database Name in Python Script
	•	Python threw the error:
“database ‘rushmorepizzeriadb’ does not exist”
	•	Because Azure created the default database postgres, not the server name.
	•	Solution: update dbname: postgres in config.

⸻

6. pgAdmin Showing Zero Rows
	•	pgAdmin initially showed zero rows because:
	•	Using wrong database
	•	Not refreshing the schema
	•	Viewing the wrong table (public.customers instead of pizzeria.customers)
	•	After refreshing schema + reconnecting, all rows appeared.

    8. Duplicate Data Risk After Re-running Script
	•	Running populate.py multiple times without dropping schema caused duplicates.

    ⸻

10. Power BI Values Not Matching pgAdmin
	•	AOV and revenue values in Power BI did not match SQL outputs.
	•	Cause:
	•	Power BI imported Pending, Cancelled, incomplete orders
	•	SQL query used only Completed
	•	Solution:
	•	Add filter in Power BI:
status = Completed
	•	Refresh data model

⸻

11. Query Errors in pgAdmin
	•	“ORDER BY not allowed in subquery” errors occurred.
	•	Cause:
	•	ORDER BY was inside XML query.
	•	Solution: move ORDER BY outside.

⸻

12. Learning Curve of Azure PostgreSQL
	•	First time configuring:
	•	SSL
	•	Firewall
	•	Connection strings
	•	Server roles
	•	Took multiple attempts to correctly connect pgAdmin, Python, and Power BI.