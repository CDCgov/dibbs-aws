[
    {
    "name": "fhir-converter",
    "image": "ghcr.io/cdcgov/phdi/fhir-converter:v1.4.1",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs-cloudwatch-logs",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "environment": [
      {
      "name": "fhir-converter",
      "value": "https://cdcgov.github.io/fhir-converter"
      }
    ]
  }
]