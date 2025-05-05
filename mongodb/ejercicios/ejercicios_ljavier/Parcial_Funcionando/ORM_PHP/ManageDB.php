<?php
include_once 'DB.php';
class ManageBD extends DB
{
  public function getQueries()
  {

    $objectsagregations = $this->connect()->query('SELECT DISTINCT c.*, t.* FROM course AS c NATURAL JOIN takes AS t;');
    $objectsbasics = $this->connect()->query('SELECT * FROM (SELECT i.* FROM instructor i WHERE salary > 90000) AS set_1 EXCEPT SELECT * FROM (SELECT i.* FROM instructor i WHERE i.dept_name = "Music" AND  i.dept_name = "Physic" ) AS set_2;');
    $objectscomplexes = $this->connect()->query('SELECT * FROM json_all WHERE id=1;');
    $objectsindexs = $this->connect()->query('SELECT DISTINCT s.*, t.* FROM student AS s  LEFT OUTER JOIN takes AS t ON s.id = t.ID');

    $queries = array(
      "objectsagregations" => $objectsagregations,
      "objectsbasics" => $objectsbasics,
      "objectscomplexes" => $objectscomplexes,
      "objectsindexs" => $objectsindexs,
    );

    return $queries;
  }
}
