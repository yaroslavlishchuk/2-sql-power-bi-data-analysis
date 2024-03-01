create database projects;

use projects;

select * from hr;

alter table hr
change column ď»żid emp_id text;

describe hr;

select birthdate from hr;

set sql_safe_updates = 0;

update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table hr
modify column birthdate date;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

alter table hr
modify column hire_date date;

 set sql_mode='';

update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != ' ';

alter table hr
modify column termdate date;

alter table hr
add column age INT;

update hr
set age = timestampdiff(YEAR, birthdate, CURdate());

select * 
from hr;

select MIN(age) as youngest,
	   MAX(age) as oldest
from hr;

select count(*)
from hr
where age < 18;

select count(*)
from hr
where termdate > CURdate();

select count(*)
from hr
where termdate = '0000-00-00';

