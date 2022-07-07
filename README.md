# CovidDashboard
Analysis of covid cases, deaths, and vaccinations

Link to Data Set:
https://ourworldindata.org/covid-deaths

Link to Tablaeu Public Dashboard:
https://public.tableau.com/app/profile/faizan.zafar/viz/CovidDeathandVaccinationDashboard/Dashboard1  

This Project is a simple dashboard that combines SQL, Excel, and Tablaeu. This dataset contains data of deaths and vaccinations from Year 2020 to 2021.

Steps to Complete:
1. The Data was downloaded in excel format.
2. Data Was cleaned in excel and prepared to be used to generate Insights using SQL and SSMS. 
	- Process of cleaning data includes:
		- Getting rid of NULL and Empty Values using Data filter functionality
		- Removing inconsitencies such as removing unwanted and ambiguous columns 
3. Data was then loaded into SQL Server Management Studio.
4. Useful Information was extracted from the data such as:
	- How many people died out of total people affected by Covid
	- How many people were affected by covid out of total population in a specific region
	- Which country had the highest infection rate as compared to their population
	- Which countries had the highest death count percentage
	- Which continent had the highest death count
	- Which continent had the highest infection rate as compared to their population
	- How many covid cases were reported till the time, what were the total number of deaths, and what was the death percentage
	- How many new cases were registered on daily basis, how total deaths happened, and what were the death percentages each day
	- How many people had the vaccination on daily basis in each country
5. Different SQL Concepts were used such as aggregate functions, aliases, joins, CTE, temp table etc.
6. Data was visualized using tablaeu. As in tablaeu public version we cannot import Excel. So, I copied the query results to excel and then later on were visualized in tablaeu.
