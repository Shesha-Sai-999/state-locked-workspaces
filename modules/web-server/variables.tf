variable "vpc_id" { 
    type = string
 }

variable "subnet_ids" {
     type = list(string)
 }
 
variable "env_name" { 
    type = string
 }

variable "instance_count" { 
    type = number
 }

variable "instance_type" { 
    type = string
 }

variable "key_name" { 
    type = string 
    default = "proj-deployer"
}

variable "sg_name" {
     default = "web-sg"
 }

variable "ami_id" { 
    default = "ami-0b6c6ebed2801a5cb"
 }