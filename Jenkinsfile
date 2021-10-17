#!/usr/bin/groovy
image = "prometheus-textfile-collectors"
label = "latest"
build = null

node {
    stage("Checkout") {
        checkout scm
    }

    stage("Build") {
        build = docker.build("kspaceee/${image}")
    }

    stage("Push") {
        docker.withRegistry("https://registry.hub.docker.com", "dockerhub-kspace") {
            build.push(label)
        }
    }
}
