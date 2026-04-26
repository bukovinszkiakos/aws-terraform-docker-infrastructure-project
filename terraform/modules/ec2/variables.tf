variable "subnet_ids" {
  type = list(string)
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "ecr_repo_url" {
  description = "ECR repository URL"
  type        = string
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

variable "instance_profile_name" {
  type = string
}


variable "alb_ingress_rules" {
  description = "Ingress rules for ALB"
  type = list(object({
    port        = number
    description = string
    cidr_blocks = list(string)
  }))
}



