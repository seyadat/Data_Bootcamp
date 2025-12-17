--exploring data and some queries to equip

	select *
		from layoffs_recs

	select max(total_laid_off), max(percentage_laid_off)
		from layoffs_recs

--finding company with 100% layoff that had highest raising funds(gov funds)
		select *
		from layoffs_recs
		where percentage_laid_off = '1'
		order by funds_raised_millions desc

--find the compnay total/sum laid off
	select company, sum(total_laid_off)
		from layoffs_recs
		group by company
		order by 2 desc
--finding the industry that got hit the most
	select industry, sum(total_laid_off)
		from layoffs_recs
		group by industry
		order by 2 desc
--finding the country that got hit the most
	select country, sum(total_laid_off)
		from layoffs_recs
		group by country
		order by 2 desc
--finding the date ranges
	select min(date), max(date)
		from layoffs_recs
--finding the sum of layoff by date ranges
	select date, sum(total_laid_off)
		from layoffs_recs
		group by date
		order by 1 desc
--finding the sum of layoff per year
	select Year(date), sum(total_laid_off)
		from layoffs_recs
		group by Year(date)
		order by 1 desc
		
--by month and year, doing a rolling sum(laidoff)/total sum of laidoff 
	select date, sum(total_laid_off)
		from layoffs_recs
		group by date
		order by 1 desc

	With CTE_Tlayoff as (
		select format(date, 'MMM yyyy') as Mont,  sum(total_laid_off) as AllSum
		from layoffs_recs
		where format(date, 'MMM yyyy') is not null
		group by format(date, 'MMM yyyy')
		)
		select Mont, AllSum, sum(AllSum)
			over (order by Mont) as G_Sum
			from CTE_Tlayoff

	--find the total laidoff in total per company
	 select company, Year(date), sum(total_laid_off) AllOffSum
		from layoffs_recs
		group by company, Year(date)
		order by 1 desc 

	--using the above to find which year company laidpple off most by ranks
	With CTE_ComYear(company, Years, total_laid_off) as (
	 select company, Year(date), sum(total_laid_off) AllOffSum
		from layoffs_recs
		group by company, Year(date)
		), ComYr_Ranking as (
--to know which company most pple per year by rank them with totallaidoff
		select *, DENSE_RANK() over(partition by years order by total_laid_off desc) DataRanking
		from CTE_ComYear
		where years is not null
		)
		select *
			ComYr_Ranking 
			where ComYr_Ranking  <=5
