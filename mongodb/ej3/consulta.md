SELECT DISTINCT SUM(credits) as sum FROM course c INNER JOIN takes t WHERE c.course_id = t.course_id AND t.ID = id COLLATE utf8mb4_unicode_ci;
