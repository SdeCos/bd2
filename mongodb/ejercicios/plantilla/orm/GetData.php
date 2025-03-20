
<?php
include_once 'ManageDB.php';

class GetData
{
  public function getAll()
  {
    $queries = new ManageBD();
    $queries_res = $queries->getQueries();

    $data = [];
    foreach ($queries_res as $key => $res) {
      $data[$key] = $res;
    }

    return $data;
  }
}
