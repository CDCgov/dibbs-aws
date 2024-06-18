locals { 
    services = {
        ecr-viewer = {
            fargate_cpu = var.fargate_cpu,
            fargate_memory = var.fargate_memory,
            app_image = var.app_image,
            container_port = var.app_port,
            host_port = var.app_port,
            env_vars = []
        },
        fhir-converter = {
            fargate_cpu = var.fargate_cpu,
            fargate_memory = var.fargate_memory,
            app_image = var.app_image,
            container_port = var.app_port,
            host_port = var.app_port,
            env_vars = []
        },
        ingestion = {
            fargate_cpu = var.fargate_cpu,
            fargate_memory = var.fargate_memory,
            app_image = var.app_image,
            container_port = var.app_port,
            host_port = var.app_port,
            env_vars = []
        },
        validation = {
            fargate_cpu = var.fargate_cpu,
            fargate_memory = var.fargate_memory,
            app_image = var.app_image,
            container_port = var.app_port,
            host_port = var.app_port,
            env_vars = []
        },
        orchestration = { 
            fargate_cpu = var.fargate_cpu,
            fargate_memory = var.fargate_memory,
            app_image = var.app_image,
            container_port = var.app_port,
            host_port = var.app_port,
            env_vars = [
                {
                    name = "APPMESH_VIRTUAL_NODE_NAME",
                    value = "orchestration"
                },
                {
                    name = "INGESTION_URL",
                    value = "http://ingestion:8080"
                },
                {
                    name = "VALIDATION_URL",
                    value = "http://validation:8080"
                },
                {
                    name = "FHIR_CONVERTER_URL",
                    value = "http://fhir-converter:8080"
                },
                {
                    name = "ECR_VIEWER_URL",
                    value = "http://ecr-viewer:3000"
                }
            ]
        }
    }
}
