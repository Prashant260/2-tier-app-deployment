variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  default = {
    dev = {
      instance_type = "t2.small"
    }
    staging = {
      instance_type = "c7i-flex.large"
          }

  }

}