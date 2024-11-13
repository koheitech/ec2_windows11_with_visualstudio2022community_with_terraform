provider "aws" {
  region = "us-east-1"
  profile = "terraform-admin"
}

# Create VPC
resource "aws_vpc" "windows_ec2_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "windows_ec2_vpc"
  }
}

# Create Subnet
resource "aws_subnet" "windows_ec2_subnet" {
  vpc_id     = aws_vpc.windows_ec2_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "windows_ec2_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "windows_ec2_igw" {
  vpc_id = aws_vpc.windows_ec2_vpc.id

  tags = {
    Name = "windows_ec2_igw"
  }
}

# Create Route Table
resource "aws_route_table" "windows_ec2_route_table" {
  vpc_id = aws_vpc.windows_ec2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.windows_ec2_igw.id
  }

  tags = {
    Name = "windows_ec2_route_table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "windows_ec2_route_table_association" {
  subnet_id      = aws_subnet.windows_ec2_subnet.id
  route_table_id = aws_route_table.windows_ec2_route_table.id
}

# Create Security Group for RDP
resource "aws_security_group" "rdp_sg" {
  vpc_id      = aws_vpc.windows_ec2_vpc.id
  name        = "rdp_sg"
  description = "Allow RDP traffic"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow RDP from anywhere; adjust as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rdp_sg"
  }
}

# Generate SSH Key Pair
resource "aws_key_pair" "windows_ec2_key" {
  key_name   = "windows_ec2_key"
  public_key = file("~/.ssh/windows_ec2_key.pub")
}

# Create Windows EC2 Instance
resource "aws_instance" "windows_ec2_instance" {
  ami                    = "ami-037bb856a23a2f822"  # Replace with the AMI ID for Windows_Server-2025-English-Full-Base-2024.11.04
  instance_type          = "c7i.4xlarge"
  key_name               = aws_key_pair.windows_ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.rdp_sg.id]
  subnet_id              = aws_subnet.windows_ec2_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "Windows_Server_2025_Instance"
  }
}