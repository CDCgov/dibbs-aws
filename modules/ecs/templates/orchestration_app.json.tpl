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
        "name": "APPMESH_VIRTUAL_NODE_NAME",
        "value": "orchestration-service-virtual-node"
      },
      {
      "name": "INGESTION_URL",
      "value": "http://ingestion-service:8080"
      },
      {
      "name": "VALIDATION_URL",
      "value": "http://validation-service:8080"
      },
      {
      "name": "MESSAGE_PARSER_URL",
      "value": "http://message-parser-service:8080"
      },
      {
      "name": "FHIR_CONVERTER_URL",
      "value": "http://fhir-converter-service:8080"
      },
      {
      "name": "ECR_VIEWER_URL",
      "value": "http://ecr-viewer:3000"
      }
    ]
  }
]