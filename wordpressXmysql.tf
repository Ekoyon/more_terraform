terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 2.5"
        }
    }
}

provider "docker" {}
