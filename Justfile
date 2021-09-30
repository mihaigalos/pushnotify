default:
  @just --list

tool := "catapush"
docker_container_registry := "ghcr.io"
docker_user_repo := "mihaigalos/catapush"
docker_image_version := "0.0.1"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool + ":" + docker_image_version

build_docker:
    docker build -t {{docker_image}} .

# run a docker with access to journalctl entries
run:
    docker run --rm -it --network host -v /run/log/journal:/run/log/journal:ro -v /etc/machine-id:/etc/machine-id:ro -v /var/log/journal:/var/log/journal:ro {{docker_image}} /bin/bash
