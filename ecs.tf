resource "aws_ecs_cluster" "ecs_cluster" {
    name = "ecs-cluster-${local.infra_env}"
}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
    name = "${local.infra_env}-ecs-capacity-provider"

    auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ecs_asg.arn

    managed_scaling {
        maximum_scaling_step_size = 1000
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 3
    }
    }
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_provider" {
    cluster_name = aws_ecs_cluster.ecs_cluster.name

    capacity_providers = [aws_ecs_capacity_provider.ecs_capacity_provider.name]

    default_capacity_provider_strategy {
        base              = 1
        weight            = 100
        capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    }
}

resource "aws_ecs_task_definition" "products_task_definition" {
    family             = "ecs-task"
    network_mode       = "awsvpc"
    execution_role_arn = "arn:aws:iam::637483454218:role/LabRole"
    cpu                = 256
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }
    container_definitions = jsonencode([
    {
        name      = "products"
        image     = "637483454218.dkr.ecr.us-east-1.amazonaws.com/aws-ecr-products-service:7142072702"
        cpu       = 256
        memory    = 512
        essential = true
        portMappings = [
        {
            containerPort = 80
            hostPort      = 80
            protocol      = "tcp"
        }
        ]
    }
    ])
}

resource "aws_ecs_service" "ecs_service" {
    name            = "ecs-service-products-${local.infra_env}"
    cluster         = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.products_task_definition.arn
    desired_count   = 2

    network_configuration {
        subnets         = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
        security_groups = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
    }

    force_new_deployment = true
        placement_constraints {
            type = "distinctInstance"
    }

    triggers = {
        redeployment = timestamp()
    }

    capacity_provider_strategy {
        capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
        weight            = 100
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.ecs_tg.arn
        container_name   = "products"
        container_port   = 80
    }

    depends_on = [aws_autoscaling_group.ecs_asg]
}