default:
  @just --list

tool := "alert"
docker_container_registry := "ghcr.io"
docker_user_repo := "mihaigalos"
docker_image_version := "0.0.1"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool+ ":" + docker_image_version

build_docker:
    docker build -t {{docker_image}} .

# run a docker with access to journalctl entries
run:
    #!/bin/bash
    touch ~/.history_make_shell
    docker-compose run --rm {{tool}} /bin/bash
