/* SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;


SELECT *
FROM job_postings_fact
LIMIT 3;

SELECT
    AVG(salary_year_avg) AS a_salary_year,
    AVG(salary_hour_avg) AS a_salary_hour
FROM job_postings_fact
WHERE
    job_posted_date > '2023-08-01'; 


SELECT
    COUNT(job_id) AS no_job_postings,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS month
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month
; */

SELECT
    DISTINCT c.name AS company,    
    EXTRACT(MONTH FROM jp.job_posted_date) AS month
FROM
    company_dim AS c
LEFT JOIN
    job_postings_fact AS jp USING(company_id)
WHERE
    job_health_insurance IS TRUE AND
    EXTRACT(QUARTER FROM jp.job_posted_date) = 2
;