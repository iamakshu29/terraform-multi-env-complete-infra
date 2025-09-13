alb = {
  alb_test = {
    name     = "test-alb"
    internal = false
    tags = {
      Environment = "test"
    }
  }

  alb_tg = {
    name = "test-alb-tg"
    port = 80
  }

}

# code is left for Security group rules to be added later.