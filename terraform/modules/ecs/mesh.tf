resource "aws_service_discovery_private_dns_namespace" "this" {
  name = local.cloudmap_namespace_name
  vpc  = var.vpc_id
  tags = local.tags
}

resource "aws_appmesh_mesh" "this" {
  name = local.appmesh_name
  tags = local.tags
}

resource "aws_appmesh_virtual_node" "this" {
  for_each  = local.service_data
  name      = each.key
  mesh_name = aws_appmesh_mesh.this.name

  spec {
    listener {
      dynamic "port_mapping" {
        for_each = {
          for key, value in local.service_data : key => value
          if each.key == key
        }
        content {
          port     = port_mapping.value.container_port
          protocol = "http"
        }
      }
    }

    backend {
      virtual_service {
        virtual_service_name = each.key
      }
    }

    service_discovery {
      aws_cloud_map {
        service_name   = each.key
        namespace_name = aws_service_discovery_private_dns_namespace.this.id
      }
    }
  }
  tags = local.tags
}
