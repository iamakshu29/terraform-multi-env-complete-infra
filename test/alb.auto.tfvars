alb = {
  alb_test = {
    name     = "test-lb-tf"
    internal = false
    tags = {
      Environment = "production"
    }
  }

  alb_tg = {
    name = "tf-example-lb-tg"
    port = 80
  }

}

# code is left for Security group rules to be added later.