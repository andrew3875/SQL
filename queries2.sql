SELECT * FROM report
EXCEPT
SELECT * FROM report_2;

SELECT item, ed_course, num_students
FROM (
  SELECT 
    item,
    ed_course,
    num_students,
    ROW_NUMBER() OVER (PARTITION BY item ORDER BY num_students DESC) AS rank
  FROM report
) sub
WHERE rank <= 3;

SELECT 
  s.fio,
  s.enrollment_date,
  s.date_deduction,
  v.date AS statement_date,
  v.subject,
  v.grade
FROM student s
JOIN statement v ON v.id_student = s.id_student
WHERE s.date_deduction = CURRENT_DATE
  AND v.control IN ('экзамен', 'к/р')
  AND NOT EXISTS (
    SELECT 1
    FROM statement v2
    WHERE v2.id_student = s.id_student
      AND v2.control IN ('экзамен', 'к/р')
      AND v2.grade NOT IN ('удовл', 'хор')
  );

SELECT
  s.scientific_director,
  COUNT(*) AS active_supervisees_count,
  CURRENT_DATE AS query_date
FROM student s
WHERE s.date_deduction IS NULL
GROUP BY s.scientific_director
HAVING COUNT(*) = (
  SELECT MIN(cnt) FROM (
    SELECT COUNT(*) AS cnt
    FROM student
    WHERE date_deduction IS NULL
    GROUP BY scientific_director
    ) sub
)
ORDER BY active_supervisees_count ASC;

SELECT
  g.name,
  sp.faculty,
  ep."Year",
  ep.semester,
  ROUND(AVG(ep.fact), 2) AS avg_actual_hours
FROM ed_plan ep
JOIN study_group g ON ep.id_group = g.id_group
JOIN specialty sp ON g.id_specialty = sp.id_specialty
WHERE ep.semester = 2
GROUP BY g.name, sp.faculty, ep."Year", ep.semester
HAVING AVG(ep.fact) > 60
ORDER BY avg_actual_hours DESC;

SELECT
  v.date,
  v.id_statement,
  s.fio AS fio_student,
  l.fio AS fio_lecturer,
  v.subject,
  v.control,
    CASE v.grade
      WHEN 'не зачтено' THEN '-'
      WHEN 'зачтено'     THEN '+'
      WHEN 'отл'         THEN '5'
      WHEN 'хор'         THEN '4'
      WHEN 'удовл'       THEN '3'
    END AS grade
FROM statement v
JOIN student s ON v.id_student = s.id
JOIN lecturer l ON v.id_lecturer = l.id
WHERE EXTRACT(YEAR FROM v.date) = 2023;

SELECT 
  s.id_student, 
  s.fio, 
  s.dob, 
  s.faculty, 
  s.enrollment_date 
FROM student s 
WHERE Extract(year FROM s.enrollment_date) = 2021 
  AND s.dob BETWEEN DATE '2006-07-01' 
  AND DATE '2006-12-31';

