terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "2.16.0"
        }
    }
}

provider "docker" {}

variable wordpress_port {
    default = 8080
}

resource "docker_volume" "database_data" {
    name = "database_data"
}

resource "docker_network" "the_wordpress_net" {
    name = "the_wordpress_net"
}

resource "docker_container" "database" {
    name = "database"
    image = "mysql:5.7"
    restart = "always"
    network_mode = "the_wordpress_net"
    env = [
        "MYSQL_ROOT_PASSWORD=wordpress",
        "MYSQLPASSWORD=wordpress",
        "MYSQL_USER=wordpress",
        "MYSQL_DATABASE=wordpress",
    ]
    mounts {
        type = "volume"
        target = "/var/lib/mysql"
        source = "database_data"
    }
}

resource "docker_container" "wordpress" {
    name = "wordpress"
    image = "wordpress:latest"
    restart = "always"
    network_mode = "the_wordpress_net"
    env = [
        "WORDPRESS_DB_HOST=db:3306",
        "WORDPRESS_USER=wordpress",
        "WORDPRESS_NAME=wordpress",
        "WORDPRESS_PASSWORD=wordpress",
    ]
    ports {
        internal = 80
        external = "${var.wordpress_port}"
    }
}
