create database Retail_Analysis;
use Retail_Analysis;
drop table if exists retail_sales;
create table retail_sales(transaction_id int primary key,
sale_date date,	
sale_time time,
customer_id	int,
gender	char(10),
age	int,
category char(10),	
quantiy	int,
price_per_unit float,
cogs float,	
total_sales float );
 select * from retail_sales;
 
 drop table retail_sales;

select * from `retail sales analysis`;

alter table `retail sales analysis` rename to `sales_analysis`;

select * from sales_analysis;

select count(*) as total_sales from sales_analysis;

select count(distinct customer_id) as total_customer from sales_analysis;

select distinct category from sales_analysis;

select * from sales_analysis where transactions_id is null or
sale_date is null or sale_time is null or customer_id is null or
gender is null or age is null or category is null or quantiy is null or
price_per_unit is null or cogs is null or total_sale is null;
select * from sales_analysis;
select * from sales_analysis where sale_date="2022-11-05" ;
select * from (
select extract(YEAR from sale_date) as year,
extract(MONTH from sale_date) as month,
avg(total_sale),
Rank() over(partition by extract(YEAR from sale_date) order by avg(total_sale) desc) as rnk
from sales_analysis
group by 1,2 order by 1 desc) as t1 where rnk in (1,2,3);

select * from sales_analysis where category="Clothing" and date_format(sale_date,"%Y-%m")="2022-11" and quantiy>=3;
select * from sales_analysis where category="Beauty" and date_format(sale_date,"%Y-%m")="2023-07" and quantiy in (1,2,3);

select category, sum(total_sale) ,count(*) as total_order from sales_analysis group by 1;

select round(avg(age),2) from sales_analysis where category="Beauty";

select * from sales_analysis where total_sale>=1000;

select category,gender,count(transactions_id) from sales_analysis group by 1,2 order by 1;

select * from sales_analysis;

#####write a query to create  top 5 customer by total sale##################################

select customer_id,sum(total_sale) from sales_analysis group by 1 order by 2 desc limit 5;

###write a query to create distinct unique customer###################################

select category,count(distinct customer_id) from sales_analysis group by 1;


###############################Write a query create each shift and number of orders####################################

select *,
case 
when extract(hour from sale_time)<12 then "Morning"
when extract(hour from sale_time)>12 and extract(hour from sale_time)>17 then "Afternoon"
else "Evening"
end as shift
from sales_analysis order by shift asc;

with hourly_sales
as
(select *,
case 
when extract(hour from sale_time)<12 then "Morning"
when extract(hour from sale_time)>12 and extract(hour from sale_time)>17 then "Afternoon"
else "Evening"
end as shift
from sales_analysis order by shift asc) select* from hourly_sales;

alter table sales_analysis
drop  sales_analysiscol ;

alter table sales_analysis
 drop sales_analysiscol1;
 
 #####write a query to create a column of appriciation###################################
 
 select *,
 case 
 when total_sale <100 then "bad_sales"
 when total_sale between 100 and 500 then "good_sales"
 when total_sale between 500 and 1000 then "excellent_sales"
 else
 "extraordainary_sales"
 end as appraciation
  from sales_analysis;
  
  ######write a query to creare each group of age##########################
  
  select *,
  case
  when 'age'<=30 then "young"
  when age between 30 and 50 then "adult"
  else
  "aged"
  end as age_cat
  from sales_analysis;
  
 ## ####################write a query to create each shift and number of orders ############################
 
 with hourly_sales
 
 as(select *,
case 
when extract(hour from sale_time)<12 then "Morning"
when extract(hour from sale_time)>12 and extract(hour from sale_time)>17 then "Afternoon"
else "Evening"
end as shift
from sales_analysis)
select shift,
count(*) as total_order from hourly_sales
group by shift;


 