resource "aws_ecs_service" "ecs_service" {
    name            = "ecs-service-orders"
    cluster         = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.orders_task_definition.arn
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
        capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
        weight            = 100
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.ecs_tg.arn
        container_name   = "orders"
        container_port   = 80
    }

    depends_on = [aws_autoscaling_group.ecs_asg]
}

resource "aws_ecs_service" "ecs_service" {
    name            = "ecs-service-payments"
    cluster         = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.payments_task_definition.arn
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
        capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
        weight            = 100
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.ecs_tg.arn
        container_name   = "payments"
        container_port   = 80
    }

    depends_on = [aws_autoscaling_group.ecs_asg]
}

resource "aws_ecs_service" "ecs_service" {
    name            = "ecs-service-products"
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
        capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
        weight            = 100
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.ecs_tg.arn
        container_name   = "products"
        container_port   = 80
    }

    depends_on = [aws_autoscaling_group.ecs_asg]
}

resource "aws_ecs_service" "ecs_service" {
    name            = "ecs-service-shipments"
    cluster         = aws_ecs_cluster.ecs_cluster.id
    task_definition = aws_ecs_task_definition.shipments_task_definition.arn
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
        capacity_provider = aws_ecs_capacity_provider.capacity_provider.name
        weight            = 100
    }

    load_balancer {
        target_group_arn = aws_lb_target_group.ecs_tg.arn
        container_name   = "shipments"
        container_port   = 80
    }

    depends_on = [aws_autoscaling_group.ecs_asg]
}