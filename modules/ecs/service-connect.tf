# Define the AWS App Mesh resources
resource "aws_appmesh_mesh" "dibbs_aws_ecs_mesh" {
  name = "dibbs-aws-ecs-mesh"
}

# Define the AWS App Mesh resources
resource "aws_appmesh_virtual_node" "orchestration_service_virtual_node" {
  name      = "orchestration-service-virtual-node"
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
        service_name   = aws_service_discovery_service.orchestration_service.name
        namespace_name = aws_service_discovery_private_dns_namespace.dibbs_aws_ecs_ns.id
        # namespace_name = "dibbs-aws-service-connect-ns"
      }
    }
  }
}

# Define the virtual service
resource "aws_appmesh_virtual_service" "orchestration_service" {
  name      = "orchestration-service"
  mesh_name = aws_appmesh_mesh.dibbs_aws_ecs_mesh.name

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.orchestration_service_virtual_node.name
      }
    }
  }
}
