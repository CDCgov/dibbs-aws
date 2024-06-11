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
        namespace_name = "dibbs-aws-service-connect-ns"
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

# Define the virtual router
# resource "aws_appmesh_virtual_router" "my_virtual_router" {
#   name      = "my-router"
#   mesh_name = aws_appmesh_mesh.dibbs_aws_ecs_mesh.name

#   spec {
#     listeners {
#       port_mapping {
#         port     = 80
#         protocol = "http"
#         name     = "http"
#       }

#       port_mapping {
#         port     = 443
#         protocol = "http"
#         name     = "https"
#       }
#     }
#   }
# }

# # Associate the virtual service with the virtual router
# resource "aws_appmesh_route" "my_route" {
#   name                = "my-route"
#   mesh_name           = aws_appmesh_mesh.dibbs_aws_ecs_mesh.name
#   virtual_router_name = aws_appmesh_virtual_router.my_virtual_router.name
#   spec {
#     http_route {
#       action {
#         weighted_targets {
#           virtual_node = aws_appmesh_virtual_node.my_virtual_node.name
#           weight       = 100
#         }
#       }

#       match {
#         prefix = "/"
#       }
#     }
#   }
# }
