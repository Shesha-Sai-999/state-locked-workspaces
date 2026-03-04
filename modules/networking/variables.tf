variable "vpc_name"{
    description = "vpc name"
    type = string
    default = "my-vpc"
}

variable "cidr"{
    description = "cidr block"
    type = string
    default = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_sub" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_sub" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}