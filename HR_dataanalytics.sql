use [hrdata];

select * from [dbo].[hrdata];

-- Employee Count
select count(emp_no) as employee_count
from hrdata

-- Attrition Count:
select count(attrition) as attrition_count
from hrdata
where attrition='Yes';

--Attrition Rate:
select 
((select count(attrition) from hrdata where attrition='Yes')/sum(employee_count)*100)
from hrdata


-- Active Employee count
select sum(employee_count) - (select count(attrition)
							  from hrdata
							  where attrition='Yes')
from hrdata


-- Avg Age
select round(avg(age),0) as avg_age
from [dbo].[hrdata];


--Attration by Gender 
select gender, count(attrition) as count_attration
from [dbo].[hrdata]
where attrition='Yes'
group by gender
order by count(attrition) DESC


-- Department wise attrition 
select department, count(attrition) as count_attration
from [dbo].[hrdata]
where attrition='Yes'
group by department
order by count(attrition) DESC

-- No of Employee by Age group 
select age, sum(employee_count) as sum_employee
from hrdata
group by age
order by age;


-- Education Field wise Attrition 
select education_field, count(attrition)as count_attrition
from hrdata
where attrition='Yes'
group by education_field
order by count_attrition;


--Attrition by Gender for different Age Group 
select age_band, gender, count(attrition), 
round((cast(count(attrition) as numeric)/(select count(attrition) from hrdata where attrition='Yes'))*100,2) as pct
from hrdata
where attrition='yes'
group by age_band, gender
order by age_band, gender 

select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as pct
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender desc;


CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
  SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction
	) AS ct(job_role varchar(50), one numeric, two numeric, three numeric, four numeric)
ORDER BY job_role;
