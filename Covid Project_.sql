use Covid_Project;

select * 
from [dbo].[CovidDeaths]
where continent is not null
order by 3,4

select * 
from [dbo].[CovidVaccinations]
order by 3,4;


--select data that going to be using 
select location, date, total_cases,new_cases,total_deaths, population
from [dbo].[CovidDeaths]
where continent is not null
order by 1,2;


-- Looking at total cases vs Total Deaths
--showing likelihood of dying if you contract covid in your country
select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as Percentage_deaths
from [dbo].[CovidDeaths]
where location like '%states%'
and continent is not null
order by 1,2;


--Looking at Total Cases vs Population 
--shows what percentage of population got covid
select location, date, total_cases, population, (total_deaths/population)*100 as Percentage_cases
from [dbo].[CovidDeaths]
where location like '%states%']
and continent is not null
order by 1,2;


--Looking at country with infection rate compared population 
select location, MAX(total_cases) as Highestinfectionscount, MAX(total_cases/population)*100 as Percentage_percentagepopulationinfected
from [dbo].[CovidDeaths]
where continent is not null
group by location
order by 1,2;

--Showing countries with highest Death Count per Population
select location, max(cast(total_deaths as int)) as Totaldeathcount 
from [dbo].[CovidDeaths]
where continent is not null
group by location
order by max(cast(total_deaths as int)) DESC;


-- LET'S BREAK THIS DOWN BY COUNTINENT
select location, max(cast(total_deaths as int)) as Totaldeathcount 
from [dbo].[CovidDeaths]
where continent is null
group by location
order by max(cast(total_deaths as int)) DESC;


-- Showing continent with the highest death count per population
select continent, max(cast(total_deaths as int)) as Totaldeathcount 
from [dbo].[CovidDeaths]
where continent is not null
group by continent
order by max(cast(total_deaths as int)) DESC;

--GLOBAL NUMBER 
select SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(New_Deaths as int))/SUM(New_cases)*100 as DeathPercentage
from [dbo].[CovidDeaths]
--where location like '%states%'
where continent is not null
--group by date 
order by 1,2;

--Looking Total Population vs Vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeoplevacctionated
--, (rollingpeoplevacctionated/population)*100
from [dbo].[CovidDeaths] dea
join [dbo].[CovidVaccinations] vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3


-- USE CTE 

with PopvsVac (Continet, location, Date, Population,New_Vaccinations, rollingpeoplevacctionated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeoplevacctionated
--, (rollingpeoplevacctionated/population)*100
from [dbo].[CovidDeaths] dea
join [dbo].[CovidVaccinations] vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3
)
select *, (rollingpeoplevacctionated/population)*100
from PopvsVac




