# Create a Service Discovery Namespace
resource "aws_service_discovery_private_dns_namespace" "dibbs_aws_ecs_ns" {
  name = "dibbs-aws-ecs-service-connect-ns"
  vpc  = var.vpc_id
}

# Register ECS Services with Service Discovery
resource "aws_service_discovery_service" "this" {
  name         = "alis-services"
  namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id
    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}

# Define the AWS App Mesh resources
resource "aws_appmesh_mesh" "dibbs_aws_ecs_mesh" {
  name = "dibbs-aws-ecs-mesh"
}

# Define the AWS App Mesh resources
resource "aws_appmesh_virtual_node" "this" {
  for_each = aws_ecs_service.this
  name      = each.key
  mesh_name = aws_appmesh_mesh.dibbs_aws_ecs_mesh.name

  spec {
    listener {
      port_mapping {
        port     = 8080
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = each.key
        namespace_name = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id
        # namespace_name = "dibbs-aws-service-connect-ns"
      }
    }
  }
}

# Define the virtual service
resource "aws_appmesh_virtual_service" "this" {
  for_each = aws_appmesh_virtual_node.this
  name      = each.key
  mesh_name = aws_appmesh_mesh.dibbs_aws_ecs_mesh.name

  spec {
    provider {
      virtual_node {
        virtual_node_name = each.key
      }
    }
  }
}
