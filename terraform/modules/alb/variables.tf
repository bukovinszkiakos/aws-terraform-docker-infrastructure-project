variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "instance_ids" {
  type = list(string)
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check" {
  type = object({
    path     = string
    interval = number
    timeout  = number
  })
  default = {
    path     = "/"
    interval = 30
    timeout  = 5
  }
}

variable "name_prefix" {
  type    = string
  default = "whale"
}