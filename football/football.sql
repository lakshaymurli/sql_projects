create database sql_project;

select * from matches;

select * from country
where name is null or id is null;

--creating primary keys

alter table country alter column id int not null;
alter table country add primary key(id);

alter table league alter column id int not null;
alter table league add primary key(id);

alter table matches alter column match_api_id int not null;
alter table matches add primary key(match_api_id);

alter table team alter column team_api_id int not null;
alter table team add primary key(team_api_id);

---creating foreign keys

alter table league alter column country_id int;
alter table league add foreign key (country_id) references country(id);

alter table matches alter column home_team_api_id int;
alter table matches add foreign key(home_team_api_id) references team(team_api_id);

alter table matches alter column away_team_api_id int;
alter table matches add foreign key(away_team_api_id) references team(team_api_id);

alter table matches alter column country_id int;
alter table matches add foreign key(country_id) references country(id);

alter table matches alter column league_id int;
alter table matches add foreign key(league_id) references league(id);

--identifying duplicates and deleting if any

select country_id, name from league
group by country_id, name
having count(*)>1;

-- inserting duplicates manually
select * from league;
insert into league
values (2,1, 'Belgium Jupiler League'),
       (1730,1729,'England Premier League'),
	   (10259,10257,'Italy Serie A');

-- removing the duplicate

delete from league where id in
(
  select id from
	(
	  select id, row_number()
	  over (partition by country_id, name order by country_id) 
	  as row_no 
	  from league)B 
where row_no>1);

select * from league;

--Data type mismatch

SELECT date
FROM matches
WHERE try_convert(date, date) is null;

update matches
SET date = convert(date, date, 105) -- Assuming the date format is 'DD-MM-YYYY'
WHERE try_convert(date, date) is null;

alter table matches
alter column date date;

update matches set matches.date= cast(matches.date as datetime);

select * from matches;

set dateformat ymd;

--correcting data type to perfrom further operations

alter table matches
alter column home_team_api_id int;

alter table matches
alter column away_team_api_id int;

alter table matches
alter column home_team_goal int;

alter table matches
alter column away_team_goal int;

--Creating view to have a count of goals made by home team and away team with minimum count of goals be 2

create view home_team_goal_count
as
select  matches.home_team_api_id, team_long_name, sum(home_team_goal) as 'home_team_goal_count' from team
join matches
on team.team_api_id=matches.home_team_api_id
group by matches.home_team_api_id, team_long_name
having sum(home_team_goal)>2;

create view away_team_goal_count
as
select  matches.away_team_api_id, team_long_name, sum(away_team_goal) as 'away_ team_goal_count' from team
join matches
on team.team_api_id=matches.away_team_api_id
group by matches.away_team_api_id, team_long_name
having sum(away_team_goal)>2;

--USE CASE 1
--Find the team won based on the number of goals they have made on the day of the match

select winning_team_api_id, match_api_id, match_date,team.team_long_name 
from
(select match_api_id, date as match_date,
case when home_team_goal > away_team_goal then home_team_api_id
	 when away_team_goal > home_team_goal then away_team_api_id
end as winning_team_api_id
from matches)A
join team
on A.winning_team_api_id=team.team_api_id;

--USE CASE 2
--List down the country name and the leagues happend on those countries

select country.name as 'country_name', league.id as 'league_id', league.name as 'league_name'
from country
join league
on country.id = league.country_id;

--USE CASE 3
--country and league can be joined with id and country_id
--country,league and match can be combined through cntry_id,league_id from matches table
--match and team tables can be joined through team_api_id and home_team/away_team

select country.name as 'country_name',
league.name as 'league_name',
matches.stage, matches.date, match_api_id,
home_team.team_long_name as 'home_team_long_name', away_team.team_long_name as 'away_team_long_name',
home_team_goal, away_team_goal
from country 
join league
on country.id = league.country_id
join matches
on country.id = matches.country_id and league.id = matches.league_id
join team as home_team
on matches.home_team_api_id=home_team.team_api_id
join team as away_team
on matches.away_team_api_id=away_team.team_api_id;

--use case 4
--calculate the metrics 
--average home team goals
--average away team goals
--average goal difference
--average goal sum (sum(home+away)/no.of matches)
--goal sum (sum(home+away))
--country,league
--no.of teams -- join with team table and find the count(team_api_id)

select country.name as country_name,
league.name as 'league_name',
avg(home_team_goal) as 'avg_home_team_goals',
avg(home_team_goal) as 'avg_away_team_goals',
avg(home_team_goal-away_team_goal) as 'avg_goal_diff',
avg(home_team_goal+away_team_goal) as 'avg_goal_sum',
sum(home_team_goal+away_team_goal) as 'total_goals',
count(team_api_id) as 'no._of_teams'
from country
join league
on country.id = league.country_id
join matches
on country.id = matches.country_id
and league.id = matches.league_id
join team 
on matches.home_team_api_id=team.team_api_id or matches.away_team_api_id = team.team_api_id
group by country.name, league.name
order by total_goals desc;

select count(team_api_id) from team;

--USE CASE 5
--supply a team_api_id , then get the total goals taken by that team when they played as 
--home team or away team


--CONCEPTS USED
--stored procedure

create procedure total_goals_taken (@team_id int)
as
begin
 select sum (case when home_team_api_id = @team_id then home_team_goal end) as home_team_count,
       sum (case when away_team_api_id = @team_id then away_team_goal end) as away_team_count
	   from matches;
end

total_goals_taken 8342;


select * from team_goal_details;

--USE CASE 6
--High score matches

--CONCEPTS USED
--CTE common table expression

with big_game as (
select league_id,match_api_id,home_team_api_id,away_team_api_id,
home_team_goal+away_team_goal as total_goals
from matches
where home_team_goal+away_team_goal>4)
select 
league.name as league_name,
count(big_game.match_api_id) as High_score_matches_count,
sum(total_goals) as total_no_of_goals
from
big_game
join
league
on
league.id=big_game.league_id
group by league.id,league.name;

--USE CASE 7

--Rank the leagues based on the average total number of goals achieved in every league.

select league.name as league_name,
avg(home_team_goal+away_team_goal) as avg_goal,
rank() over (order by avg(home_team_goal+away_team_goal) desc) as league_rank
from
matches
join
league
on
league.id=matches.league_id
group by league.name;

--USE CASE 8
--calculate the running total of a particular team "KRC Genk" with the id 9987
--based on the date column in a unbounded preceding and current row.

--CONCEPTS USED
--rows between 
--n preceding and current row
--n preceding and n following
--unbounded preceding and unbounded following
--running total



select 
matches.date,
team.team_long_name as home_team_name,
home_team_goal,
sum(home_team_goal) over (order by matches.date rows between unbounded preceding and current row) as running_total
from
matches
join
team
on
team.team_api_id=matches.home_team_api_id
where 
matches.home_team_api_id=9987;

