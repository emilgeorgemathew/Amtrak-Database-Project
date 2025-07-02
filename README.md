# DataForge: Analyzing Amtrak Performance Data 🚆
DataForge is a comprehensive data analysis project built around Amtrak’s station-level and state-level performance data from 2021 to 2023. Using a custom-designed relational database and insightful SQL queries, the project uncovers key operational patterns and performance bottlenecks related to ridership, budgeting, on-time performance (OTP), procurement, and employment spending across U.S. states.

# Table of content
1. [Overview](#overview)
2. [Data Source and Preprocessing](#data-source-and-preprocessing)
3. [Project Objectives](#project-objectives)
4. [Database Design](#database-design)
5. [Contents](#contents)
6. [Key Insights](#key-insights)
7. [Visualizations](#visualizations)
8. [Recommendations](#recommendations)
9. [Tech Stack](#tech-stack)
10. [Credits](#credits)

## Overview
This project models Amtrak data - Ridership, Guest Rewards, Stations, On-Time Performance and Employees to analyze:

1. [cite_start]Performance of Amtrak stations using various performance metrics like ridership, on-time performance, and budgeting across different stations in various states[cite: 10].
2. [cite_start]Amtrak's last 3 years of data to provide insights and recommendations on budgeting and costs using on-time performance and ridership for various stations across cities[cite: 16, 17].
3. [cite_start]Performance, recommendations, and storytelling using intuitive visualizations and data-driven decisions[cite: 18, 19].


# Project Objectives 🎯
Design a normalized and referentially-integrated SQL database for Amtrak operations.

Analyze ridership trends, procurement distribution, OTP by route types, and employment budgets.

Provide actionable recommendations for Amtrak management using data storytelling in Tableau.

Present insights on budget allocations (Design, Construction, Deployment) over time and their impact.
# Authors: 
1. Pranav Praveen Nair - Data Preprocessing and Database Design.
2. Emil George Mathew  - Data Preprocessing, Database Implementation & Querying (including DML, DCL, DQL), business problem formation, leadership and slides.
3. Abhishek Bhosale - SQL queries, leadership, business problem formation and data visualization.
4. Henry Kangten - Data visualization and reports.

# Data Source and Preprocessing
1. **Amtrak Data**:
- Merged from real Amtrak references and [fact sheets](https://www.amtrak.com/state-fact-sheets).
- Sourced and merged data from multiple data sources like Amtrak stats and supplementary info (state codes, station codes and city).
- All suplementary sources were merged onto the main dataset to handle missing data points like station codes or city names.
- Reformatted and standardized into a single Excel file: Amtrack.xlsx.
- 
2. **Schema Design**:
- Designed a normalized schema with x main tables: State, Station, Ridership, Employee, GuestRewards.
- Used primary/foreign keys and cascading referential integrity rules.

3. **Import to SQL**:
- Each sheet was a table in the database.
- Used DML, DCL queries to create tables for data and management.


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

# Visualizations 📊
The Tableau dashboards provide:

Comparative ridership by state and station.

OTP breakdown by route type.

Yearly trends in budget allocations.

Heatmaps of employment and procurement data.

# Recommendations 🧠
Optimize budget allocations by aligning spending with operational outcomes.

Improve OTP on long-distance routes through better scheduling and maintenance.

Leverage high-ridership states to pilot new service improvements or technologies.

Reassess procurement efficiency in top-spending states to reduce costs.

#Tech Stack

Microsoft SQL Server (T-SQL)
Excel (Data Preprocessing - Cleaning & Formatting)
Tableau (Business Intelligence and Data Visualization )
GitHub (Version Control & Publishing)

Thank you for checking out this project.
