<?php
class DB
{
  private $host;
  private $db;
  private $user;
  private $password;

  public function __construct()
  {
    $config = require 'ConnectionSettings.php';

    $this->host = $config['host'];
    $this->db = $config['db'];
    $this->user = $config['user'];
    $this->password = $config['password'];
  }
  function connect()
  {
    try {
      $connection = "mysql:host=" . $this->host . ";dbname=" . $this->db;
      $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_EMULATE_PREPARES   => false,
      ];
      $pdo = new PDO($connection, $this->user, $this->password);
      return $pdo;
    } catch (PDOException $e) {
      print_r('Error connection: ' . $e->getMessage());
    }
  }
}
