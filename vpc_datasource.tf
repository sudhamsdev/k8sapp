data "aws_vpc" "ecs_vpc" {
  tags = {
    Name = "ECSCluster-vpc"
  }
}

data "aws_subnets" "private_subnets" {
  tags = {
    Type = "ECSCluster-private-subnet"
  }
}

data "aws_subnets" "public_subnets" {
  tags = {
    Type = "ECSCluster-public-subnet"
  }
}