# ====================================================================
# 1. Create VPC
# ====================================================================

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.main_vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

# ====================================================================
# 2. Create Public Subnets 
# ====================================================================

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_block[0]
  availability_zone       = var.public_subnet_az[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr_block[1]
  availability_zone       = var.public_subnet_az[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-public-subnet-2"
    environment = var.environment
  }
}

# ====================================================================
# 3. Create Private Subnets 
# ====================================================================

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_block[0]
  availability_zone = var.private_subnet_az[0]

  tags = {
    Name        = "${var.environment}-private-subnet-1"
    environment = var.environment
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr_block[1]
  availability_zone = var.private_subnet_az[1]

  tags = {
    Name        = "${var.environment}-private-subnet-2"
    environment = var.environment
  }
}

# ====================================================================
# 4. Create Internet Gatway
# ====================================================================

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

# ====================================================================
# 5. Create Public Route Table
# ====================================================================

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

# ====================================================================
# 6. Create Private Route Table
# ====================================================================

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main_gw.id
  }

  tags = {
    Name = "${var.environment}-private-rt"
  }
}

# ====================================================================
# 7. Public Route Table Association
# ====================================================================

resource "aws_route_table_association" "public_rt_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# ====================================================================
# 8. Private Route Table Association to each private subnet
# ====================================================================

resource "aws_route_table_association" "private_rt_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}

# ====================================================================
# 9. Create Elastic IP for NAT Gateway
# ====================================================================

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name : "${var.environment}-nat-eip"
  }
}

# ====================================================================
# 10. Create NAT Gateway
# ====================================================================

resource "aws_nat_gateway" "main_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "${var.environment}-nat-gw"
  }

  depends_on = [aws_internet_gateway.main_igw]
}
