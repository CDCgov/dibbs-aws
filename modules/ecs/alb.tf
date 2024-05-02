resource "aws_lb" "alb" {
    name                = var.application_load_balancer_name
    load_balancer_type  = "application"  

    #security_groups     = [aws_security_groups.alb_sg.id]
    subnets             = [for subnet in aws_subnet.public : subnet.id]

    /*subnets             = [
        "${aws_default_subnet.default_subnet_a.id}", 
        "${aws_default_subnet.default_subnet_b.id}",
        "${aws_default_subnet.default_subnet_c.id}"
    ] */
}

