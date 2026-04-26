output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}