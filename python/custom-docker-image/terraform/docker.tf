resource "docker_image" "python_image" {
  name = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  build {
    context = "../"
  }
  depends_on = [aws_ecr_repository.ecr_repo]
}

resource "docker_registry_image" "python_image" {
  name          = docker_image.python_image.name
  keep_remotely = true
}

