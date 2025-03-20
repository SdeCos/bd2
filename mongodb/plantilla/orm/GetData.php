
<?php
include_once 'ManageDB.php';

class GetData
{
  public function getAll()
  {
    $queries = new ManageBD();
    $queries_res = $queries->getQueries(); // this already returns fetched arrays

    $data = [];
    foreach ($queries_res as $key => $res) {
      $data[$key] = $res; // no need to do ->fetch() here
    }

    return $data;
  }
}

// Debug output (if needed)
// $instance = new GetData();
// echo "<pre>";
// print_r($instance->getAll());
// echo "</pre>";
?>
