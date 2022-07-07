

--Total Cases vs Total Deaths
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidData..CovidDeaths
Where location = 'pakistan' and continent is not null 
order by 1,2


--Total Cases vs Population
Select location, date, population, total_cases, (total_cases/population)*100 as CasesPercentage
From CovidData..CovidDeaths
Where location = 'pakistan' and continent is not null
order by 1,2

select sum(new_cases), max(total_cases) from CovidData..CovidDeaths where location = 'canada'

select max(population), sum(total_cases) from CovidData..CovidDeaths where location = 'Andorra'



--Highest infection rate vs Population
Select location, max(population) as Population, max(total_cases) as TotalCases, max((total_cases/population) * 100) as InfectionRateByPopulation
From CovidData..CovidDeaths
where continent is not null
group by location, population
order by InfectionRateByPopulation DESC


--Countries With Highest Death Count

select location, max(cast(total_deaths as int)) as TotalDeaths
from CovidData..CovidDeaths
where continent is not null
group by location
order by TotalDeaths desc



--Statistics by Continent

select continent, max(cast(total_deaths as int)) as TotalDeaths
from CovidData..CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc


--Continents with highest death counts per Population
select continent as Continent, max(population) as TotalPopulation, max(cast(total_deaths as int)) as TotalDeaths, ( max(cast(total_deaths as int)) / max(population))*100 as TotalDeathsPercentage 
from CovidData..CovidDeaths
where continent is not null
group by continent
order by TotalDeaths desc



--Global overall
Select sum(new_cases) as NewCases, sum(cast(new_deaths as int)) as TotalDeaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
From CovidData..CovidDeaths
Where continent is not null 
order by 1,2

--Global by Date
Select date, sum(new_cases) as NewCases, sum(cast(new_deaths as int)) as TotalDeaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
From CovidData..CovidDeaths
Where continent is not null 
Group by date
order by 1,2


--COVID DEATHS VS VACCINATION DATA

--Total Population vs vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(cast(new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vacc
	on dea.date = vacc.date 
	and dea.location = vacc.location
where dea.continent is not null
order by 2,3



--Using CTE
With PopvsVac(continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(cast(new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vacc
	on dea.date = vacc.date 
	and dea.location = vacc.location
where dea.continent is not null
)
Select *, (RollingPeopleVaccinated/population)*100 
from PopvsVac
order by 2,3



--Using Temp Table
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated 
(
Continent nvarchar(255), 
Location nvarchar(255),
Date datetime,
population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
) 


Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vacc.new_vaccinations
, sum(cast(new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vacc
	on dea.date = vacc.date 
	and dea.location = vacc.location
where dea.continent is not null
order by 2,3

Select *, (RollingPeopleVaccinated/population)*100 
from #PercentPopulationVaccinated
order by 2,3





--Creating Views to store data for data visualization later

