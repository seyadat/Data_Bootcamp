USE [world_layoffs]
GO

/****** Object:  Table [dbo].[layoffs]    Script Date: 10/2/2025 2:16:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[layoffs_recs](
	[company] [nvarchar](255) NULL,
	[location] [nvarchar](255) NULL,
	[industry] [nvarchar](255) NULL,
	[total_laid_off] [float] NULL,
	[percentage_laid_off] [nvarchar](255) NULL,
	[date] [datetime] NULL,
	[stage] [nvarchar](255) NULL,
	[country] [nvarchar](255) NULL,
	[funds_raised_millions] [float] NULL
) ON [PRIMARY]
GO

insert into layoffs_recs 
	select * from layoffs

	select * 
		from layoffs_recs

--data cleaning 
--steps
--looking for duplicates
--standardizing the data(checking for spelling mistakes and others)
--checking for nulls and blank values
--removing any unnecessary clums and rows

--using row_number against the table colums to check for duplc tho 
	select *,
	ROW_NUMBER() 
	OVER
	(partition by company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions order by company) as Row_No#_duplc_check
		from layoffs_recs

	select *, date,
	ROW_NUMBER() 
	OVER
	(partition by company, location, date, stage order by company) as Row_No#_duplc_check
		from layoffs_recs

	--using cte, the Row_No#_duplc_check value > 1 is a duplc 
		 
	With CTE_duplicate as(
		select *,
		ROW_NUMBER() 
		OVER
		(partition by company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions order by date) as Row_No#_duplc_check
			from layoffs_recs
		)
		select * 
			from CTE_duplicate
			where Row_No#_duplc_check > 1

	--verifying 2 or 3 row sef of duplc list
		select *
			from layoffs_recs
			where company = ' Included Health'

		select *
			from layoffs_recs
			where company = '#Paid'

	--del Row_No#_duplc_check > 2
		With CTE_duplicate as(
		select *,
		ROW_NUMBER() 
		OVER
		(partition by company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions order by date) as Row_No#_duplc_check
			from layoffs_recs
		)
		--deleting the duplc
		Delete 
			from CTE_duplicate
			where Row_No#_duplc_check > 1

-- checking for duplc after del
	With CTE_duplicate as(
		select *,
		ROW_NUMBER() 
		OVER
		(partition by company, location, industry, total_laid_off,percentage_laid_off, date, stage, country, funds_raised_millions order by date) as Row_No#_duplc_check
			from layoffs_recs
		)
		select * 
			from CTE_duplicate
			--where Row_No#_duplc_check > 1
		select *
			from layoffs_recs
			where company = '#Paid'


	---standardizing data(column by column) using window functions
	-- used trim,
	select distinct(company), trim(company)
		from layoffs_recs
	--present alphabetically
		order by 1
	--updating the column
		update layoffs_recs
		set company = trim(company)

	select *
			from layoffs_recs
			where industry like '%crypto%'
	
	update layoffs_recs
	set industry = 'crypto'
	where industry like '%crypto%'
	
--checking for nulls and blanks 

	select *
		from layoffs_recs
		where total_laid_off is Null
		--and percentage_laid_off is null
		and percentage_laid_off = 'null'
		--'null' coz it's in text format
	
	--to remove the nulls and the blank space, need to check that the data 
	--is not popularized else we will end del data 
	--1-st checking column by colunm for null and blanck spaces
	1. select distinct company
			from layoffs_recs
			where company is Null
			or company = ' '

		select distinct location 
			from layoffs_recs
			where location  is Null
			or company = ' '

	--seeing the null in the industry clum, need to find and ensure the data
	--is not popularized
		select distinct industry
			from layoffs_recs
			where industry is Null
			or industry = ' '

		select *
			from layoffs_recs
			where industry is Null
			or industry = ' '

	--the below 3 row set of data have a common set of data so popularizing them will
	--do the trick, like if t1 from t0.1,t0.2,t0.3 are de same, full the null or blank
	--with the value of the filters above clmns
		select *
			from layoffs_recs
			where company = 'juul'
		select *
			from layoffs_recs
			where company = 'carvana'
		select *
			from layoffs_recs
			where company = 'airbnb'

--to the the filling, self-join will sort the much better
		select *
			from layoffs_recs lt1
			join layoffs_recs lt2
--here's self joining with the selected colmns(company,location andy maybe country)
			on lt1.company=lt2.company
			and lt1.location=lt2.location
				where (lt1.industry is Null or lt1.industry=' ')
				and lt2.industry is not null

	UPDATE layoffs_recs lt1
	Join	layoffs_recs lt2
		On lt1.company= lt1.company
		and lt1.location= lt2.location
			set lt1.industry =lt2.industry 
			where lt1.industry is Null and lt2.industry is not null

 		UPDATE lt1
		set lt1.industry =lt2.industry 
		from layoffs_recs lt1
	Join	layoffs_recs lt2
		On lt1.company= lt1.company
		and lt1.location= lt2.location
			where lt1.industry is Null and lt2.industry is not null

	select *
		from layoffs_recs
		where (total_laid_off is Null or total_laid_off = ' ')
		--and percentage_laid_off is null
		and percentage_laid_off = 'null'

--delete row with null or blank value in total_laidoff and %laidoff
	Delete
		from layoffs_recs
		where (total_laid_off is Null or total_laid_off = ' ')
		--and percentage_laid_off is null
		and percentage_laid_off = 'null'

	
	
	
	select *
		from layoffs_recs


		select distinct(industry)
			from layoffs_recs
			order by 1
			