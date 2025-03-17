<?php
include_once 'DB.php';
class ManageBD extends DB
{
  public function getQueries()
  {

    $advisor = $this->connect()->query('SELECT * FROM advisor');

    $queries = array(
      "advisor" => $advisor,
    );

    return $queries;
  }
}

