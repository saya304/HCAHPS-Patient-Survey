/* 
HCAHPS Patient Survey

National & state-level scores from 2013 to 2022 for the Hospital Consumer Assessment of Healthcare Providers and Systems (HCAHPS) survey, a national, standardized survey of hospital patients about their experiences during a recent inpatient hospital stay.

Recommended Analysis:
1) Have hospitals made improvements in their quality of care over the past 9 years?
2) Are there any specific areas where hospitals have made more progress than others?
3) Are there still any major areas of opportunity?
4)What recommendations can you make to hospitals to help them further improve the patient experience? 
*/

--Column 'Completed_Survey' of Table 'Responses' has some string and integer values
-- changing the values of column 'Completed Survey' to represent consistent data type (int)
update hcahps.dbo.responses
set COMPLETED_SURVEYS = case
    when completed_surveys = '300 or more' then 400
    when completed_surveys = 'Between 100 and 299' then 200
    when completed_surveys = 'Fewer than 100' then 90
    when completed_surveys = 'Not Available' then 0
    when completed_surveys = 'FEWER THAN 50' then 300
    else completed_surveys
    end

-- changing the data type of column from nvarchar to int
ALTER TABLE responses 
alter column completed_surveys INT;

--checking Information Schema to verify datatype change
select * from hcahps.INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like '%completed_survey%'

--verified that datatype is changed to INT

---------------------------------------------------------------------------------------------------------------------------------

--Checking for non integer values in Response_Rate 
Select distinct Response_Rate
from hcahps.dbo.responses
where Response_Rate like '%[A-Za-z]%'
-- Has one string 'Not Available'

--Updating rows where response_rate is 'Not Available' to 0
UPDATE hcahps.dbo.responses
set Response_Rate = CASE
	when Response_Rate = 'Not Available' then 0
	else Response_Rate
	end

--change datatype of Column response_rate from nvarchar to int
ALTER TABLE responses 
alter column response_rate float

--verifying correct datatype assignment
select * from hcahps.INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like '%response_rate%'

----------------------------------------------------------------------------------------------------------------------------------

--nationwide result

SELECT  
   DATEPART(YEAR, [Start_Date]) as 'Period',
    Measure,
    Type,
    Question,
    Bottom_box_Answer as Answer,
    Bottom_box_Percentage as 'Rating (%)',
    'Bottom' as Response
FROM national_results nr
JOIN measures m ON nr.Measure_ID = m.Measure_ID
JOIN questions q ON nr.Measure_ID = q.Measure_ID
JOIN reports rep ON nr.Release_Period = rep.Release_Period

UNION

SELECT  
   DATEPART(YEAR, [Start_Date]) as 'Period',
   Measure,
    Type,
    Question,
    Middle_box_Answer as Answer,
    Middle_box_Percentage as 'Rating (%)',
    'Middle' as Response
FROM national_results nr
JOIN measures m ON nr.Measure_ID = m.Measure_ID
JOIN questions q ON nr.Measure_ID = q.Measure_ID
JOIN reports rep ON nr.Release_Period = rep.Release_Period

UNION

SELECT  
   DATEPART(YEAR, [Start_Date]) as 'Period',
   Measure,
    Type,
    Question,
    Top_box_Answer as Answer,
    Top_box_Percentage as 'Rating (%)',
    'Top' as Response
FROM national_results nr
JOIN measures m ON nr.Measure_ID = m.Measure_ID
JOIN questions q ON nr.Measure_ID = q.Measure_ID
JOIN reports rep ON nr.Release_Period = rep.Release_Period

-----------------------------------------------------------------------------------------------------------------------------
--creating views

--This creates a view for top box percentage in year 2013
DROP VIEW if exists view1

CREATE VIEW view1 AS

WITH first_score as
	(
		select
			r.Release_period,
			cast (r.Start_Date as DATE) as StartDate,
			min(cast (r.Start_Date as DATE)) over () as MN,
			s.state ,
			s.State_Name,
			sr.Measure_ID, 
			q.question,
			sr.Top_box_Percentage
		from state_results as sr
		join states as s on sr.State = s.State
		join questions as q on sr.Measure_ID = q.Measure_ID
		join reports as r on sr.Release_Period = r.Release_Period
	)
select *
	from first_score
	where StartDate = MN;

--This creates a view for top box percentage in year 2022

DROP VIEW if exists view2

CREATE VIEW view2 AS

with last_score as(
select
r.Release_period,
cast (r.Start_Date as DATE) as StartDate,
max(cast (r.Start_Date as DATE)) over () as MN,
s.state , 
s.State_Name,
sr.Measure_ID, 
q.question,
sr.Top_box_Percentage
from state_results as sr
join states as s on sr.State = s.State
join questions as q on sr.Measure_ID = q.Measure_ID
join reports as r on sr.Release_Period = r.Release_Period
)

select *
from last_score 
where StartDate = MN;

-- create a view for the difference in improvement from 2013 to 2022
drop view if exists final_results

create view final_results as

select v1.state, v1.state_name ,v1.measure_id, v1.question, (v1.top_box_percentage - v2.top_box_percentage) as improvement
from view1 as v1
join view2 as v2 on v1.state = v2.state and v1.question = v2.question