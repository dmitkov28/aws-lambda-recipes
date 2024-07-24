resource "aws_ecr_repository" "ecr_repo" {
  name         = "python_image"
  force_delete = true
}

data "aws_ecr_image" "python_image" {
  repository_name = aws_ecr_repository.ecr_repo.name
  image_tag       = "latest"

  depends_on = [docker_registry_image.python_image]
}
