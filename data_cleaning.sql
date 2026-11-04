select *
from layoffs;
create table layoffs_staging
like layoffs;

select *
from layoffs_staging;

insert layoffs_staging
select * from layoffs;

select *
from layoffs_staging;

select *,
row_number() over(partition by company,industry,total_laid_off,percentage_laid_off,'date')
AS row_num
from layoffs_staging;

with duplicate_cte as
(
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)
AS row_num
from layoffs_staging
)

select * from 
duplicate_cte where row_num > 1;

select * from layoffs_staging
where company = 'casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` double DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
AS row_num
from layoffs_staging;

SET SQL_SAFE_UPDATES = 0;


DELETE FROM layoffs_staging2
WHERE row_num > 1;


select *
from layoffs_staging2
where row_num > 1;


select company, Trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = Trim(company);

select *
from layoffs_staging2
where industry like 'crypto%'; 

update layoffs_staging2
set industry =  'crypto'
where industry like  'crypto%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2 order by 1;

update layoffs_staging2 
set country = trim(trailing '.' from country)
where country like 'united states%'; 

select distinct country,trim(trailing '.' from country)
from layoffs_staging2 order by 1;

select `date`,
str_to_date(`date`, '%m/%d/%y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date`
from layoffs_staging2;

select * from layoffs_staging2;

select * from layoffs_staging2
where total_laid_off is null;

select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2;

alter table layoffs_staging2
drop column  row_num;

























