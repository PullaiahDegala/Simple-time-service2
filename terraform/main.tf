module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "project-vpc"
  cidr = var.vpc_cidr

  enable_dns_hostnames = true
  azs = ["us-west-2a", "us-west-2b"]
  public_subnets = [var.public_subnet_cidr_1]
  private_subnets = [var.private_subnet_cidr_1]
  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "aws_ecs_cluster" "cluster" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "simple-time-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([{
    name      = "simple-time-service"
    image     = "your-docker-image-url"
    essential = true
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }
    ]
  }])
  cpu    = "256"
  memory = "512"
}

resource "aws_ecs_service" "service" {
  name            = "simple-time-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }
}
