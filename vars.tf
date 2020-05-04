variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-south-1 = "ami-0b44050b2d893d5f7"
  }
}

variable "PRIVATE_KEY" {
  default = "keyy"
}

variable "PUBLIC_KEY" {
  default = "keyy.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

