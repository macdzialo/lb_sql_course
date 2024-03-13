/* SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs
LIMIT 10;
 */

/* SELECT 
    company_id,
    name AS company_name
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY 
        company_id
)
; */

/* WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count USING(company_id)
ORDER BY total_jobs DESC */


/* SELECT
    skill_id,
    COUNT(skill_id)
FROM
    skills_job_dim
GROUP BY skill_id
ORDER BY count DESC
LIMIT 5; */

/* SELECT 
    sc.skill_id,
    sn.skills AS skill_name,
    sc.count
FROM (
    SELECT
        skill_id,
        COUNT(skill_id)
    FROM
        skills_job_dim
    GROUP BY skill_id
    ORDER BY count DESC
    LIMIT 5
) AS sc
LEFT JOIN
    skills_dim AS sn ON sn.skill_id = sc.skill_id */

/* SELECT
    name,
    no_of_jobs,
    CASE
    WHEN no_of_jobs < 10 THEN 'Small'
    WHEN no_of_jobs BETWEEN 10 AND 50 THEN 'Medium'
    WHEN no_of_jobs > 50 THEN 'Big'
    END AS company_size
    
FROM
    (
    SELECT
        company_id,
        COUNT(job_id) AS no_of_jobs
    FROM
        job_postings_fact
    GROUP BY company_id
    )
LEFT JOIN company_dim USING(company_id)
ORDER BY no_of_jobs DESC */

SELECT
    company_size,
    COUNT(company_size)
FROM (
    SELECT
        name,
        no_of_jobs,
        CASE
        WHEN no_of_jobs < 10 THEN 'Small'
        WHEN no_of_jobs BETWEEN 10 AND 50 THEN 'Medium'
        WHEN no_of_jobs > 50 THEN 'Big'
        END AS company_size
        
    FROM
        (
        SELECT
            company_id,
            COUNT(job_id) AS no_of_jobs
        FROM
            job_postings_fact
        GROUP BY company_id
        )
    LEFT JOIN company_dim USING(company_id)
    ORDER BY no_of_jobs DESC
)
GROUP BY company_size