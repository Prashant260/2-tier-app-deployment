variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "environments" {
  default = {
    dev = {
      instance_type = "t2.micro"
    }
    staging = {
      instance_type = "c7i-flex.large"
          }

  }

}