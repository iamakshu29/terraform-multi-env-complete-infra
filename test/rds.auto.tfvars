rds = {
  test_rds = {
    rds = {
      name = "test-rds"
      tags = {
        Name = "test-relation-database"
      }
  } }

  test_db_instance = {
    db_instance_1 = {
      db_name        = "mydb"
      engine         = "mysql"
      engine_version = "8.0"
      instance_class = "db.t3.micro"
      username       = "admin"
      # password       = "admin@123"
      multi_az = true
      tags = {
        Name = "test-default-rds-db"
      }
    }
  }
}