resource "aws_ecs_task_definition" "orders_task_definition" {
    family             = "ecs-task"
    network_mode       = "awsvpc"
    execution_role_arn = var.ecs_task_execution_role_arn
    cpu                = 2
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }
    container_definitions = jsonencode([
    {
        name      = "orders"
        image     = "ghcr.io/ort-devops-2023s2g1/orders-service-example:7090894486"
        cpu       = 2
        memory    = 256
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

    tags = {
      "Nombre" = "Task definition for: orders microservice"
      "Created" = "Created with terraform"
    }
}

resource "aws_ecs_task_definition" "payments_task_definition" {
    family             = "ecs-task"
    network_mode       = "awsvpc"
    execution_role_arn = var.ecs_task_execution_role_arn
    cpu                = 2
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }
    container_definitions = jsonencode([
    {
        name      = "orders"
        image     = "ghcr.io/ort-devops-2023s2g1/payments-service-example:7107677406"
        cpu       = 2
        memory    = 256
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

    tags = {
      "Nombre" = "Task definition for: orders microservice"
      "Created" = "Created with terraform"
    }
}

resource "aws_ecs_task_definition" "products_task_definition" {
    family             = "ecs-task"
    network_mode       = "awsvpc"
    execution_role_arn = var.ecs_task_execution_role_arn
    cpu                = 2
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }
    container_definitions = jsonencode([
    {
        name      = "orders"
        image     = "ghcr.io/ort-devops-2023s2g1/products-service-example:7080022031"
        cpu       = 2
        memory    = 256
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

    tags = {
      "Nombre" = "Task definition for: orders microservice"
      "Created" = "Created with terraform"
    }
}

resource "aws_ecs_task_definition" "shipments_task_definition" {
    family             = "ecs-task"
    network_mode       = "awsvpc"
    execution_role_arn = var.ecs_task_execution_role_arn
    cpu                = 2
    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }
    container_definitions = jsonencode([
    {
        name      = "orders"
        image     = "ghcr.io/ort-devops-2023s2g1/shipping-service-example:7080018234"
        cpu       = 2
        memory    = 256
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

    tags = {
      "Nombre" = "Task definition for: orders microservice"
      "Created" = "Created with terraform"
    }
}