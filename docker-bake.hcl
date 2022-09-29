variable "LATEST" { default = "" }
variable "TAG" { default = "dev" }

group "default" {
  targets = ["caddy"]
}

target "release" {
  inherits = ["caddy"]
  output = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64/v8",
    "linux/ppc64le",
    "linux/s390x"
  ]
}

target "caddy" {
  output = ["type=docker"]
  tags = [
    "erlend/caddy:${TAG}",
    notequal("",LATEST) ? "erlend/caddy:latest" : ""
  ]
}
