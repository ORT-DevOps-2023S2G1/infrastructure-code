resource "aws_ecs_cluster" "main" {
    name = "${local.name}-cluster-${local.env}"

    setting {
        name  = "containerInsights"
        value = "enabled"
    }
}

resource "aws_ecs_task_definition" "main" {
    for_each = var.services
    
    family = "${each.key}-service"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
    execution_role_arn       = local.exec-role-arn
    task_role_arn            = local.exec-role-arn
    container_definitions = file("task-definitions/${each.key}-service.json")
    
    runtime_platform {
        cpu_architecture = "X86_64"
        operating_system_family = "LINUX"
    }
}

resource "aws_ecs_service" "main" {
    for_each = var.services

    name                               = "${each.key}-service-${local.env}"
    cluster                            = aws_ecs_cluster.main.id
    task_definition                    = "${each.key}-service"
    desired_count                      = 2
    deployment_minimum_healthy_percent = 50
    deployment_maximum_percent         = 200
    launch_type                        = "FARGATE"
    scheduling_strategy                = "REPLICA"
    
    network_configuration {
        subnets         = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
        security_groups = [aws_security_group.tasks_sg.id]
        assign_public_ip = true
    }
    
    load_balancer {
        target_group_arn = aws_alb_target_group.main.arn
        container_name   = "${each.key}"
        container_port   = 8080
    }
    
    # lifecycle {
    #     ignore_changes = [task_definition, desired_count]
    # }
}

resource "aws_lb" "main" {
    name               = "${local.name}-alb-${local.env}"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb.id]
    subnets            = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
    
    enable_deletion_protection = false
    }

resource "aws_alb_target_group" "main" {
    name        = "${local.name}-tg-${local.env}"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.main.id
    target_type = "ip"
    
    health_check {
        healthy_threshold   = "3"
        interval            = "30"
        protocol            = "HTTP"
        matcher             = "200"
        timeout             = "3"
        path                = "/"
        unhealthy_threshold = "2"
    }
}

resource "aws_alb_listener" "http" {
    load_balancer_arn = aws_lb.main.arn
    port              = 80
    protocol          = "HTTP"
    
    default_action {
        target_group_arn = aws_alb_target_group.main.id
        type             = "forward"
    }
}

resource "aws_appautoscaling_target" "ecs_target" {
    for_each = var.services

    max_capacity       = 4
    min_capacity       = 1
    resource_id        = "service/${aws_ecs_cluster.main.name}/${each.key}-service-${local.env}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"

    depends_on = [
        aws_ecs_service.main
    ]
}

resource "aws_cloudwatch_log_group" "fargate-logs" {
    name = var.cloudwatch_group
}