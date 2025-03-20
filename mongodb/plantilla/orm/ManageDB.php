<?php
include_once 'DB.php';
class ManageBD extends DB
{
  private $queries;

  public function __construct()
  {
    parent::__construct();
    $this->queries = require 'Queries.php'; // load queries
  }

  public function getQueries($params = [])
  {
    $pdo = $this->connect();
    $results = [];

    foreach ($this->queries as $key => $query) {
      if (strpos($query, ':id') !== false && isset($params['id'])) {
        $stmt = $pdo->prepare($query);
        $stmt->execute(['id' => $params['id']]);
        $results[$key] = $stmt->fetchAll(PDO::FETCH_ASSOC);
      } else {
        $stmt = $pdo->query($query);
        $results[$key] = $stmt->fetchAll(PDO::FETCH_ASSOC);
      }
    }

    return $results;
  }
}
