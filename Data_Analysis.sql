-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?

select gender, 
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00'
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?


select race, 
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by race
order by  employees desc;

-- 3. What is the age distribution of employees in the company?

select case 
			  when age >= 18 and age <= 25 then '18-25'
              when age >= 26 and age <= 35 then '26-35'
              when age >= 36 and age <= 45 then '36-45'
              when age >= 46 and age <= 55 then '46-55'
              when age >= 56 and age <= 65 then '56-65'
              else '65+'
              end as age_category,
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by age_category
order by age_category;

select case 
			  when age >= 18 and age <= 25 then '18-25'
              when age >= 26 and age <= 35 then '26-35'
              when age >= 36 and age <= 45 then '36-45'
              when age >= 46 and age <= 55 then '46-55'
              when age >= 56 and age <= 65 then '56-65'
              else '65+'
              end as age_category,
		gender,
        count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by age_category, gender
order by age_category, gender;

-- 4. How many employees work at headquarters versus remote locations?

select location, 
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by location;

-- 5. What is the average length of employment for employees who have been terminated?


 select round(avg(datediff(termdate, hire_date))/365, 0) as avg_lenght_employment
 from hr
 where termdate <= curdate()
	and termdate <> '0000-00-00'
    and age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?

select department,
		gender, 
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by department, gender
order by  department;

-- 7. What is the distribution of job titles across the company?

select jobtitle, 
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by jobtitle
order by jobtitle desc;

-- 8. Which department has the highest turnover rate?

select department, 
		total_employees,
		terminated_employees, 
        terminated_employees/total_employees termonation_rate
from(
	select department,
			count(*) as total_employees, 
			sum(case
				when termdate <> '0000-00-00' and termdate <= curdate() then 1
				else 0
				end
                ) as terminated_employees
	from hr
    where  age >= 18
    group by department
    ) as subquery
order by termonation_rate desc;

-- 9. What is the distribution of employees across locations by city and state?

select location_state,
		count(*) as employees
from hr
where age >= 18 
	and termdate = '0000-00-00' 
group by location_state
order by  employees desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?

select year, 
		hires, 
        terminations, 
        hires - terminations as net_change,   
        round((hires - terminations)/hires*100, 2) as net_change_percent
from (
		select year(hire_date) as year,
				count(*) as hires,
                sum(case
					when termdate <> '0000-00-00' and termdate <= curdate() then 1
					else 0
					end
                    ) as terminations
		from hr
        where age >= 18
        group by year(hire_date)
	) as subquery
order by year asc;

-- 11. What is the tenure distribution for each department?

select department,
		round(avg(datediff( termdate, hire_date))/365,0) as avg_tenure
from hr
where age >=18 
	and termdate <> '0000-00-00' 
	and termdate <= curdate()
group by department;


