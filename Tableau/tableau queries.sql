/*
Queries used for Tableau Project
*/



-- 1. 

Select location ,SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
		SUM(cast(new_deaths as int))/SUM(New_Cases) as DeathPercentage
From Cases
--Where location like '%states%'
--where continent is not null 
--Group By date

where location in ('World','United States','United Kingdom','China')
group by location
order by 1,2


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
			SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Cases
where continent is not null 
order by 1,2

-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Cases
Where continent is null 
and location not in ('World', 'European Union', 'International')
	and location not like '%income%'
Group by location
order by TotalDeathCount desc

----- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Cases
Group by Location, Population
order by PercentPopulationInfected desc

-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Cases
Group by Location, Population, date
order by PercentPopulationInfected desc


--5

select cas.location, cas.population, Sum(convert(bigint, vac.new_vaccinations)),max(vac.people_fully_vaccinated)
from Cases cas
join vaccinations  vac
on cas.location =vac.location
	and cas.date = vac.date
where cas.location = 'World'

group by cas.location, cas.population

-- 
select location,date, new_cases
from Cases
where location like 'United%'