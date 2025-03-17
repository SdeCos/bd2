<?php
include_once 'DB.php';
class ManageBD extends DB
{
  public function getQueries()
  {
    $data = $this->connect()->query('SELECT DISTINCT SUM(credits) as sum FROM course c INNER JOIN takes t WHERE c.course_id = t.course_id AND t.ID = id COLLATE utf8mb4_unicode_ci;');

    $esquema1 = $this->connect()->query('SELECT * FROM course');
    $esquema2 = $this->connect()->query('SELECT * FROM takes');

    $queries = array(
      "data" => $data,
      "course" => $esquema1,
      "takes" => $esquema2,
    );

    return $queries;
  }
  /*echo "<pre>";
	print_r($queries);
	echo "</pre>";*/
}
