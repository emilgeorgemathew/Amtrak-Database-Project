# DataForge: Analyzing Amtrak Performance Data 🚆
DataForge is a comprehensive SQL database project that designs a normalized, referentially-integrated database to analyze Amtrak operations across U.S. states. Through advanced data modeling and interactive Business Intelligence visualizations, this project delivers actionable insights on ridership trends, procurement distribution, on-time performance, and employment budgets to support strategic decision-making.

# Getting Started 🚀

To set up and explore the Amtrak Performance Database, follow these steps:

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/emilgeorgemathew/Amtrak-Database-Project.git
    cd Amtrak-Database-Project
    ```
2.  **Database Setup (Microsoft SQL Server):**
    * Open **Microsoft SQL Server Management Studio (SSMS)**.
    * Connect to your SQL Server instance.
    * Execute the `BUDT703_Project_0507_13_DDL.sql` script. This script will create the necessary database, tables, and populate them with initial data.
3.  **Run Analysis Queries:**
    * Execute the queries in `BUDT_Project_0507_13_DML.sql` within SSMS to extract key business insights from the populated database.
4.  **Explore Visualizations (Tableau):**
    * Open `BUDT_Project_0507_13_Tableau.twb` using **Tableau Desktop**.
    * Ensure Tableau is connected to your SQL Server database where you set up the project. You may need to update the connection details within Tableau to point to your local database.


# Table of contents

1. [Overview](#overview)
2. [Data Source and Pre-processing](#data-source-and-pre-processing)
3. [Project Objectives](#project-objectives)
4. [Database Design](#database-design)
5. [Contents](#contents)
6. [Key Insights](#key-insights)
7. [SQL Query, visualizations, findings and impact](#sql-query-visualizations-findings-and-impact)
8. [Recommendations](#recommendations)
9. [Tech Stack](#tech-stack)
10. [Credits](#credits)


## Overview
This project models Amtrak data - Ridership, Guest Rewards, Stations, On-Time Performance and Employees to analyze:

1. Performance of Amtrak stations using various performance metrics like ridership, on-time performance, and budgeting across different stations in various states.
2. Amtrak's last 3 years of data to provide insights and recommendations on budgeting and costs using on-time performance and ridership for various stations across cities.
3. Performance, recommendations, and storytelling using intuitive visualizations to make recommendations and data-driven decisions to Amtrak stakeholders.

![Pictures](https://github.com/emilgeorgemathew/Amtrak-Database-Project/blob/main/Project%20Diagram.png)

# Project Objectives 🎯
- Design a normalized and referentially-integrated SQL database.
- Analyze ridership trends, procurement distribution, on-time performance by route types, and employment budgets.
- Create interactive visualizations to convey insights from the raw data by connecting the database to Tableau for Business Intelligence(BI). 
- Provide actionable recommendations for Amtrak stakeholders by storytelling and presenting the visualizations.
- Present insights on budget allocations (Design, Construction, Deployment) over time and their impact.

# Data Source and Pre-processing
1. **Amtrak Data**:
- Merged from real Amtrak references and [fact sheets](https://www.amtrak.com/state-fact-sheets).
- Sourced and merged data from multiple data sources like Amtrak stats and supplementary info (state codes, station codes and city).
- All supplementary sources were merged onto the main dataset to handle missing data points like station codes or city names.
- Reformatted and standardized into a single Excel file: Amtrak.xlsx.

2. **Schema Design**:
- Designed a normalized schema with 8 main tables: State, Station, Route, Budget, OnTimePerformance, AllocatedBudget, StateMetrics, StationMetrics.
- Used primary/foreign keys and cascading referential integrity rules.

3. **Import to SQL**:
- Each sheet in the final Excel file was a table in the database.
- Used DML, DCL queries to create tables for data and management.

# Entity-Relationship Diagram(ERD)
Here's a visual representation of the final schema design:
![ERD](https://github.com/emilgeorgemathew/Amtrak-Database-Project/blob/main/ERD.png)

- **State**: Central dimension table with stateCode as primary key, containing state-level geographic data
- **Station**: Connected to State via "Located" relationship, contains station-level operational data
- **Route**: Dimension table with route classifications (routeType) for performance analysis
- **Budget**: Financial planning data with budget types and yearly allocations
- **On Time Performance**: Fact table linking Route and Station with temporal performance metrics (otpYear, otpValue)
- **Allocated Budget**: Bridge table connecting Budget to Station for resource allocation tracking
- **Station Metrics**: Comprehensive fact table containing station-level performance metrics over time
- **State Metrics**: Aggregated state-level metrics for high-level analysis and reporting

# Database Design 🧩
The project is based on a well-structured relational model with the following key entities:

State(stateCode, stateName) 

Station(stationCode, stationName, stateCode)

Route(routeID, routeName, routeType)

OnTimePerformance(routeID, stationCode, otpYear, otpValue)

Budget(budgetYearID, budgetType, budgetPlanYear, budgetTotal)

AllocatedBudget(stationCode, budgetYearID, allocatedBudgetYear, allocatedBudget)

StateMetrics(stateCode, stateMetric, stateMetricYear, stateMetricValue)

StationMetrics(stationCode, stationMetric, stationMetricYear, stationMetricValue)

Referential integrity and cascading rules are enforced to maintain data consistency during updates and deletions.

# Contents 📁

BUDT703_Project_0507_13_DDL.sql	SQL script for creating and populating the Amtrak database schema.

BUDT_Project_0507_13_DML.sql	SQL analysis queries for extracting key business insights.

BUDT703_Project_0507_13_Design.docx	Project proposal with design rationale, schema, and use case documentation.

BUDT703_Project_0507_13_Slides.pptx	Final presentation with insights, observations, and recommendations.

BUDT_Project_0507_13_Tableau.twb	Tableau workbook with interactive dashboards and visualizations.

# Key Insights 📌
Top Ridership States: New York and California lead Amtrak ridership, indicating crucial hubs.

On-Time Performance: Northeast Corridor has the highest OTP, while Long-Distance routes lag.

Budget Allocation: Construction budgets dominate year-over-year; Design remains underfunded.

Procurement Trends: California, New York, and Pennsylvania account for the highest spending.

Employment Spend: Varies widely by state, with implications for workforce optimization.

# SQL Query, visualizations, findings and impact 📊

Our interactive Tableau dashboards provide key insights into Amtrak's performance:

**1. Budget Allocation by Type (2016-2023):**

**Query**:
```sql
WITH YearlyBudget AS
( SELECT b.budgetPlanYear AS Budget_Year,
b.budgetType AS Budget_Type,
SUM(ab.allocatedBudget) AS Total_Allocated_Budget
FROM [Amtrak.Budget] b JOIN [Amtrak.AllocatedBudget] ab
ON b.budgetYearID = ab.budgetYearID
GROUP BY b.budgetPlanYear, b.budgetType ),
HighestBudgetPerYear AS
( SELECT Budget_Year, Budget_Type, Total_Allocated_Budget,
RANK() OVER (PARTITION BY Budget_Year ORDER BY Total_Allocated_Budget DESC) AS BudgetRank
FROM YearlyBudget )
SELECT Budget_Year, Budget_Type,
Total_Allocated_Budget
FROM HighestBudgetPerYear
WHERE BudgetRank = 1
ORDER BY Budget_Year ASC;
```
**Visualization**:

![viz1](https://github.com/user-attachments/assets/a9b91754-983b-477b-9de5-0747373bccee)

* **Insights:**
    * Budget allocations vary significantly year-over-year.
    * "Construction" dominated the highest allocated budget from 2020 to 2023, peaking notably in 2022 with $95.77 million, indicating a strong focus on infrastructure projects.
    * "Design" consistently received lower allocations across most years, with a high of $2.379 million in 2016 and a low of $1.0 million in 2023.
    * "Deployment" showed a peak in 2019 at $8.636 million, but declined in later years, suggesting a shift in strategic priorities.
* **Significance:** Understanding these historical allocation trends is crucial for strategic financial planning, optimizing resource distribution between different project phases (construction, deployment, design), and ensuring future budgets align with long-term strategic goals for efficiency and cost-effectiveness.

**2. Average On-Time Performance (OTP) by Route Type:**

**Query**:
```sql
SELECT r.routeType AS 'Route Type', ROUND(AVG(o.otpValue),4) AS 'Average OTP'
FROM [Amtrak.Route] r
INNER JOIN [Amtrak.OnTimePerformance] o
ON r.routeId = o.routeId
GROUP BY r.routeType
ORDER BY ROUND(AVG(o.otpValue),2) DESC
```
**Visualization**:

![viz2](https://github.com/emilgeorgemathew/Amtrak-Database-Project/blob/main/viz2.png)

* **Insights:**
    * The "Northeast Corridor" consistently exhibits the highest average OTP at 0.8349.
    * "State Supported" routes perform well with an average OTP of 0.7872, only slightly below the Northeast Corridor.
    * "Long Distance" routes significantly lag behind, showing a low average OTP of 0.4896, indicating considerable delays.
* **Significance:** This breakdown highlights critical areas for operational improvement. Addressing the low OTP in Long-Distance routes is essential for enhancing customer satisfaction and operational efficiency, while the success of the Northeast Corridor offers best practices that can be explored for replication.

**3. Top 5 States with Highest Ridership:**

**Query**:
```sql
SELECT TOP 5 t.stateCode AS State_Code, s.stateName AS State_Name, SUM(m.stationMetricValue) AS Total_Ridership
FROM [Amtrak.StationMetrics] m
JOIN [Amtrak.Station] t ON m.stationCode = t.stationCode
JOIN [Amtrak.State] s ON t.stateCode = s.stateCode
WHERE m.stationMetric = 'Ridership'
GROUP BY t.stateCode, s.stateName
ORDER BY Total_Ridership DESC
```
**Visualization**:

![viz2](https://github.com/emilgeorgemathew/Amtrak-Database-Project/blob/main/viz3.png)

* **Insights:**
    * New York leads by a significant margin with over 27.5 million total ridership, followed by California with approximately 18.1 million.
    * Pennsylvania (approx. 11.9 million), District of Columbia (approx. 10.1 million), and Illinois (approx. 9.2 million) also demonstrate substantial ridership numbers.
    * These states represent key urban transit hubs for Amtrak.
* **Significance:** Identifying high-ridership states helps in prioritizing service quality and infrastructure investment in these crucial markets. It also provides insights into successful strategies that can be analyzed and potentially applied to states with lower ridership to drive growth.

**4. Total Procurement Spending by State:**

**Query**:
```sql
SELECT m.stateCode AS State_Code, t.stateName AS State_Name, SUM(m.stateMetricValue) AS Total_Procurement_Spending
FROM [Amtrak.StateMetrics] m
JOIN [Amtrak.State] t ON m.stateCode = t.stateCode
WHERE m.stateMetric = 'Procurement'
GROUP BY m.stateCode, t.stateName
ORDER BY Total_Procurement_Spending DESC;
```
**Visualization**:

![viz2](https://github.com/emilgeorgemathew/Amtrak-Database-Project/blob/main/viz4.png)

* **Insights:**
    * California leads in total procurement spending with over $1.35 billion, closely followed by New York with approximately $1.34 billion, and Pennsylvania with $1.03 billion.
    * There are significant regional disparities in spending, with major coastal states showing high expenditures, while many central states have considerably lower spending.
* **Significance:** Analyzing procurement spending trends across states can identify opportunities for cost efficiencies, strategic resource reallocation to potentially underfunded regions, and optimization of procurement practices based on the observed patterns in high-spending states.

# Recommendations 🧠
- Optimize Construction Budget: Review escalating "Construction" allocations (post-2020) for operational benefits and ensure balanced funding with "Design" and "Deployment" phases for efficient project pipelines.

- Improve Long-Distance OTP: Implement targeted interventions like infrastructure upgrades, optimized scheduling, and enhanced maintenance for "Long Distance" routes to boost their on-time performance.

- Replicate OTP Success: Analyze and replicate best practices from high-performing "Northeast Corridor" and "State Supported" routes to improve punctuality across the network.

- Invest in High-Ridership States: Prioritize investment in service quality and capacity for top-ridership states (New York, California) and adapt their success strategies to boost ridership in other states.

- Audit Procurement Spending: Conduct comprehensive audits in high-expenditure states (California, New York, Pennsylvania) for cost efficiencies and evaluate procurement needs in lower-spending states for potential resource redistribution or optimized practices.

# Tech Stack

Microsoft SQL Server (T-SQL)
Excel (Data Preprocessing - Cleaning & Formatting)
Tableau (Business Intelligence and Data Visualization )
GitHub (Version Control & Publishing)

# Credits
1. Pranav Praveen Nair - Data Preprocessing and Database Design.
2. Emil George Mathew  - Data Preprocessing, Database Implementation & Querying (including DML, DCL, DQL), business problem formation, leadership and slides.
3. Abhishek Bhosale - SQL queries, leadership, business problem formation and data visualization.
4. Henry Kangten - Data visualization and reports.

Thank you for checking out this project.
