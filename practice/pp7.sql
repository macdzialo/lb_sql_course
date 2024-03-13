/* SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
; */

SELECT
    COUNT(salary_year_avg) AS number_of_jobs,
    CASE
        WHEN salary_year_avg BETWEEN 0 AND 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50001 AND 100000 THEN 'Mid'
        WHEN salary_year_avg > 100000 THEN 'High'
        WHEN salary_year_avg IS NULL THEN 'Not Available'
        ELSE NULL
    END AS salary_bucket
FROM
    job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY salary_bucket
ORDER BY number_of_jobs DESC
LIMIT 10;