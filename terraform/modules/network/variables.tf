variable "subnets" {
  type = map(object({
    cidr = string
    az   = string
    type = string
  }))
}

variable "name_prefix" {
  type    = string
  default = "whale"
}

variable "vpc_config" {
  type = object({
    cidr = string
    name = string
  })
}