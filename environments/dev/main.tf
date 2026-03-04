module "networking"{
    source = "../../modules/networking"
    vpc_name = "dev-vpc"
}

module "my-web-server"{
    source = "../../modules/web-server"
    env_name = "dev"
    instance_count = 1
    instance_type = "t3.micro"
    ami_id = "ami-0b6c6ebed2801a5cb"
    vpc_id = module.networking.vpc_id
    
    subnet_ids = module.networking.public_subnets
}