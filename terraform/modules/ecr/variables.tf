variable "name_prefix" {
  type    = string
  default = "whale"
}

variable "policy_arns" {
  type = list(string)

  default = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}