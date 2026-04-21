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

variable "env" {
  description = "The environment to deploy (dev or staging)"
  type = string
  validation {
    condition     = var.env == "dev" || var.env == "staging"
      }
}
