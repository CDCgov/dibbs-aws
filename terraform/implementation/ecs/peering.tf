# gets all the vpcs with the tag Environment = "skylight-rie"
data "aws_vpcs" "rhapsody" {
  tags = {
    Environment = "skylight-rie"
  }
}

# gets the data on the list of vpcs
data "aws_vpc" "rhapsody" {
  count = length(data.aws_vpcs.rhapsody.ids)
  id    = tolist(data.aws_vpcs.rhapsody.ids)[count.index]
}

# creates a peering connection between the vpc and the rhapsody vpc
resource "aws_vpc_peering_connection" "peer" {
  count = length(data.aws_vpcs.rhapsody.ids)
  vpc_id        = module.vpc.vpc_id
  peer_vpc_id   = data.aws_vpc.rhapsody[count.index].id
  auto_accept   = true

  tags = {
    Name = "${module.vpc.vpc_id}-to-${data.aws_vpc.rhapsody[count.index].id}"
  }
}

# creates a route from the private ecr viewer route table to the rhapsody vpc
resource "aws_route" "route_private_ecr_viewer_to_rhapsody" {
  count = length(data.aws_vpcs.rhapsody.ids)
  route_table_id         = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block = data.aws_vpc.rhapsody[count.index].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer[count.index].id
}

# creates a route from the public ecr viewer route table to the rhapsody vpc
resource "aws_route" "route_public_ecr_viewer_to_rhapsody" {
  count = length(data.aws_vpcs.rhapsody.ids)
  route_table_id         = module.vpc.public_route_table_ids[count.index]
  destination_cidr_block = data.aws_vpc.rhapsody[count.index].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer[count.index].id
}

# creates a route from the rhapsody vpc to the ecr viewer subnet
resource "aws_route" "route_rhapsody_to_ecr_viewer" {
  count = length(data.aws_vpcs.rhapsody.ids)
  route_table_id         = data.aws_vpc.rhapsody[count.index].main_route_table_id
  destination_cidr_block = module.vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer[count.index].id
}