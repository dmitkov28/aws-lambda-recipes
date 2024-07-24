resource "docker_image" "python_image" {
  name = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  build {
    context = "../"
  }
  triggers = {
    always_run = "${timestamp()}"
    dockerfile = filemd5("../Dockerfile")
  }
  depends_on = [aws_ecr_repository.ecr_repo]
}

resource "docker_registry_image" "python_image" {
  name          = docker_image.python_image.name
  keep_remotely = true
  triggers = {
    # This ensures the image is pushed every time it's rebuilt
    image_digest = docker_image.python_image.repo_digest
  }
}

