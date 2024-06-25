resource "aws_service_discovery_private_dns_namespace" "this" {
  name = var.cloudmap_namespace_name
  vpc  = var.vpc_id
}

resource "aws_service_discovery_service" "this" {
  # TODO parameterize name
  name         = var.cloudmap_service_name
  namespace_id = aws_service_discovery_private_dns_namespace.this.id
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id
    dns_records {
      ttl  = 60
      type = "A"
    }
  }
}

resource "aws_appmesh_mesh" "this" {
  name = var.appmesh_name
}

resource "aws_appmesh_virtual_node" "this" {
  for_each  = var.service_data
  name      = each.key
  mesh_name = aws_appmesh_mesh.this.name

  # dynamic "spec" {
  #   # The conditional for this for_each checks the key for the current interation of aws_ecs_task_definition.this
  #   # and var.service_data so that we only create a dynamic load_balancer block for the public services.
  #   # It may seem a little weird but it works and I'm happy with it.
  #   # We loop through the service_data so that we have access to the container_port
  #   # TODO: set a local.public_services list variable that only contains the public services
  #   for_each = { for key, value in var.service_data : key => value }
  #   content {
  #     listener {
  #       port_mapping {
  #         port     = spec.value.container_port
  #         protocol = "http"
  #       }
  #     }

  #     service_discovery {
  #       aws_cloud_map {
  #         service_name   = spec.key
  #         namespace_name = aws_service_discovery_private_dns_namespace.this.id
  #         # namespace_name = "dibbs-aws-service-connect-ns"
  #       }
  #     }
  #   }
  # }

  spec {
    listener {
      dynamic "port_mapping" {
        for_each = {
          for key, value in var.service_data : key => value
          if each.key == key
        }
        content {
          port     = port_mapping.value.container_port
          protocol = "http"
        }
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = each.key
        namespace_name = aws_service_discovery_private_dns_namespace.this.id
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "this" {
  for_each  = aws_appmesh_virtual_node.this
  name      = each.key
  mesh_name = aws_appmesh_mesh.this.name

  spec {
    provider {
      virtual_node {
        virtual_node_name = each.key
      }
    }
  }
}
