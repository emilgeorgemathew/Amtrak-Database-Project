USE BUDT703_Project_0507_13

-- Which budget type recieved the highest allocated budget in each year?

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

--Avg otp for diff route types 


SELECT r.routeType AS 'Route Type', ROUND(AVG(o.otpValue),4) AS 'Average OTP'
FROM [Amtrak.Route] r
INNER JOIN [Amtrak.OnTimePerformance] o
ON r.routeId = o.routeId
GROUP BY r.routeType
ORDER BY ROUND(AVG(o.otpValue),2) DESC


--What are the top 5 states with the highest ridership?

SELECT TOP 5 t.stateCode AS State_Code, s.stateName AS State_Name, SUM(m.stationMetricValue) AS Total_Ridership 
FROM [Amtrak.StationMetrics] m 
JOIN [Amtrak.Station] t ON m.stationCode = t.stationCode 
JOIN [Amtrak.State] s ON t.stateCode = s.stateCode 
WHERE m.stationMetric = 'Ridership' 
GROUP BY t.stateCode, s.stateName 
ORDER BY Total_Ridership DESC   


--What is the total procurement spending for each state across all years? 

SELECT m.stateCode AS State_Code, t.stateName AS State_Name, SUM(m.stateMetricValue) AS Total_Procurement_Spending 
FROM [Amtrak.StateMetrics] m 
JOIN [Amtrak.State] t ON m.stateCode = t.stateCode 
WHERE m.stateMetric = 'Procurement' 
GROUP BY m.stateCode, t.stateName 
ORDER BY Total_Procurement_Spending DESC;


























