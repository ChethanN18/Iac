variable "vpc_cidr" {
    description = "choose cidr for vpc"
    type = string
    default = "10.20.0.0/16"
}

variable "region" {
    description = "choose region for vpc"
    type = string
    default = "us-east-2"
}

variable "nat-amis" {
    type = map
    default = {
      us-east-1 = "ami-003acd4f8da7e06f9"
      us-east-2 = "ami-0231217be14a6f3ba"
    }
}
