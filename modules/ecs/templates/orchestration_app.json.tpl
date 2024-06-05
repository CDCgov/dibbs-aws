[
    {
    "name": "orchestration-app",
    "image": "ghcr.io/cdcgov/phdi/orchestration:v1.4.4",
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
      "name": "INGESTION_URL",
      "value": "https://cdcgov.github.io/ingestion"
      },
      {
      "name": "VALIDATION_URL",
      "value": "https://cdcgov.github.io/validate"
      },
      {
      "name": "MESSAGE_PARSER_URL",
      "value": "https://cdcgov.github.io/message-parser"
      },
      {
      "name": "FHIR_CONVERTER_URL",
      "value": "https://cdcgov.github.io/fhir-converter"
      }
    ]
  }
]