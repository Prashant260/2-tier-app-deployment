variable "environments" {
  default = {
    dev = {
      instance_type = "t3.small"
    }
    staging = {
      instance_type = "c7i-flex.large"
    }
  }
}

