module "networking"{
    source = "../../modules/networking"
    vpc_name = "prod-vpc"
}

module "my-web-server"{
    source = "../../modules/web-server"
    
    env_name = "prod"
    instance_count = 2
    instance_type = "t3.small"

    vpc_id = module.networking.vpc_id
    subnet_ids = module.networking.public_subnets
}