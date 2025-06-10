# DataForge: Analyzing Amtrak Performance Data 🚆

# Authors: 
Pranav Praveen Nair, Emil George Mathew, Abhishek Bhosale, Henry Kangten

# Course: BUDT 703 | University of Maryland

# Overview
DataForge is a comprehensive data analysis project built around Amtrak’s station-level and state-level performance data from 2021 to 2023. Using a custom-designed relational database and insightful SQL queries, the project uncovers key operational patterns and performance bottlenecks related to ridership, budgeting, on-time performance (OTP), procurement, and employment spending across U.S. states.

# Project Objectives 🎯
Design a normalized and referentially-integrated SQL database for Amtrak operations.

Analyze ridership trends, procurement distribution, OTP by route types, and employment budgets.

Provide actionable recommendations for Amtrak management using data storytelling in Tableau.

Present insights on budget allocations (Design, Construction, Deployment) over time and their impact.

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
