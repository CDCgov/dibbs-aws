# Create a Cloud Map or Service Discovery Namespace
resource "aws_service_discovery_private_dns_namespace" "dibbs_aws_ecs_ns" {
  name = "dibbs-aws-ecs-service-connect-ns"
  vpc  = var.vpc_id
}

# Register ECS Services with Cloud Map or Service Discovery
resource "aws_service_discovery_service" "orchestration_service" {
  name         = "orchestration-service"
  namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id

}

resource "aws_service_discovery_service" "fhir_converter_service" {
  name         = "fhir-converter-service"
  namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id

}

resource "aws_service_discovery_service" "validation_service" {
  name         = "validation-service"
  namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id

}

resource "aws_service_discovery_service" "message_parser_service" {
  name         = "message-parser-service"
  namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id

}

resource "aws_service_discovery_service" "ingestion_service" {
  name         = "ingestion-service"
  namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id

}
