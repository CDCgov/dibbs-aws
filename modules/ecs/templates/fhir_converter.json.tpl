[
    {
    "name": "fhir-converter",
    "image": "ghcr.io/cdcgov/phdi/fhir-converter:v1.2.11",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "ecs-cloudwatch-logs",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs-log-stream"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]