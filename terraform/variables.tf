variable "region" {
  description = "AWS region"
  type        = string
}

variable "ecr_repo_url" {
  description = "ECR repository URL"
  type        = string
}

variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    cidr = string
    az   = string
    type = string
  }))
}

variable "vpc_config" {
  type = object({
    cidr = string
    name = string
  })
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_ingress_rules" {
  type = list(object({
    port        = number
    description = string
  }))
}

variable "alb_ingress_rules" {
  type = list(object({
    port        = number
    description = string
    cidr_blocks = list(string)
  }))
}