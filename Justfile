default:
  @just --list

tool := "pushnotify"
docker_container_registry := "ghcr.io"
docker_user_repo := "mihaigalos"
docker_image_version := "0.0.1"
docker_image := docker_container_registry + "/" + docker_user_repo + "/" + tool+ ":" + docker_image_version

build platform="linux/arm64":
    #! /bin/bash
    platform_short=$(echo {{platform}} | cut -d '/' -f2)
    output={{tool}}_${platform_short}
    docker buildx build --platform {{platform}} -t {{docker_image}}  --output "type=oci,dest=${output}.tar" src/ && gzip ${output}.tar

# Install docker buildx and other goodies for multi arch deployment.
setup:
    #! /bin/bash
    sudo apt update
    sudo apt-get install -y binfmt-support qemu-user-static
    sudo apt-get install -y docker.io
    sudo usermod -aG docker $USER

    sudo apt-get install -y jq
    mkdir -p ~/.docker/cli-plugins
    BUILDX_URL=$(curl https://api.github.com/repos/docker/buildx/releases/latest |  jq  '.assets[].browser_download_url' | grep linux-arm64)
    wget $BUILDX_URL -O ~/.docker/cli-plugins/docker-build
    chmod +x ~/.docker/cli-plugins/docker-buildx

    docker buildx create --use --name mbuilder
    docker buildx inspect --bootstrap

# run a docker with access to journalctl entries
run:
    #!/bin/bash
    sed -e "s/{{{{image}}/ghcr.io\/mihaigalos\/pushnotify:0.0.1/" src/docker-compose.yaml_template > src/docker-compose.yaml
    touch ~/.history_make_shell
    source ~/.profile
    cd src
    docker-compose run --rm {{tool}} /bin/bash
