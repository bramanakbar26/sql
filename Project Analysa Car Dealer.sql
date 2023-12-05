use [latihan]

select * from [dbo].[Cardekho]

--Total Records
select count(Name) as total_car
from [dbo].[Cardekho]

-- Total car that available in 2023
select count(Name) as car_2023
from [dbo].[Cardekho]
where year='2023'

-- Total car that avail in 2022, 2021, 2020
select count(name) 
from [dbo].[Cardekho]
where year='2022'
OR year='2021'
OR year='2020'

-- Total car by year 
select year, count(name) as total_car
from [dbo].[Cardekho]
group by year 
order by year DESC

-- Total car diesel in 2021 
select count(name) as total_diesel
from [dbo].[Cardekho]
where year='2021'
AND fuel='Diesel'

-- Total Petrol car in 2020
select count(name) as total_petrol
from [dbo].[Cardekho]
where year='2020'
AND fuel='petrol'

-- All Fuel in 2022
select * 
from [dbo].[Cardekho]
where year='2023'


-- Year that have more than 1000 unit 
select year, count(name) as total_car
from [dbo].[Cardekho]
group by year
having count(name)>=1000

-- details car between 2015 and 2023 
select * from [dbo].[Cardekho]
where year between 2015 and 2023

-- count car between 2015 and 2023 
select count(name) as total_car
from [dbo].[Cardekho]
where year between 2015 and 2023