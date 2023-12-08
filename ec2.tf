resource "aws_launch_template" "ecs_lt" {
    name_prefix   = "ecs-template"
    image_id      = "ami-0230bd60aa48260c6"
    instance_type = var.instance_type

    key_name               = "ecs-proyecto"
    vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
    
    iam_instance_profile {
        name = "EMR_EC2_DefaultRole"
    }

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size = 30
            volume_type = "gp2"
        }
    }

    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = "ecs-instance"
        }
    }

    #user_data = filebase64("${path.module}/ecs.sh")

}

# Evaluar si solo se utiliza en PRD
resource "aws_autoscaling_group" "ecs_asg" {
    vpc_zone_identifier = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
    desired_capacity    = 2
    max_size            = 3
    min_size            = 1

    launch_template {
        id      = aws_launch_template.ecs_lt.id
        version = "$Latest"
    }

    tag {
        key                 = "AmazonECSManaged"
        value               = true
        propagate_at_launch = true
    }
}

# con esta definicion solo funciona en un ambiente por las subnets definidas
resource "aws_lb" "ecs_alb" {
    name               = "ecs-alb-${local.infra_env}"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
    subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

    tags = {
        
    }
}

resource "aws_lb_listener" "ecs_alb_listener" {
    load_balancer_arn = aws_lb.ecs_alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.ecs_tg.arn
    }
    }

# solo definido para dev/ver si este solo sirve para todo
resource "aws_lb_target_group" "ecs_tg" {
    name        = "ecs-target-group"
    port        = 80
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = aws_vpc.main.id

    health_check {
        path = "/"
    }
}