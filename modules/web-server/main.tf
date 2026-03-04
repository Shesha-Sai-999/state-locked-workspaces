resource "aws_key_pair" "deployer"{
    key_name = var.key_name
    public_key = file("/home/sheshasai/terraform-labs/terraform-practice-key.pub")
}

resource aws_security_group my_security_group{
    name = var.sg_name
    description = "for default security group"
    vpc_id = var.vpc_id

    #inbound rules
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "For SSH"
    }
    ingress{
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP for tenant"
    }
    #outbound rules
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access"
    }
}
# ec2 instance

resource "aws_instance" "web_server"{
    count = var.instance_count
    key_name = aws_key_pair.deployer.key_name
    instance_type = var.instance_type
    ami = var.ami_id
    associate_public_ip_address = true
    subnet_id  = var.subnet_ids[count.index % length(var.subnet_ids)]
    vpc_security_group_ids = [aws_security_group.my_security_group.id]

    root_block_device{
        volume_size = 15
        volume_type = "gp3"
    }
    tags = {
        Name = "${var.env_name}-server-${count.index}"
    }
}
