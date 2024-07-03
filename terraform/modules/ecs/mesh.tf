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
}
