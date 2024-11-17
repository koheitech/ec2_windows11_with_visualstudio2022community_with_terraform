variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "rdp_cidr_blocks" {
  description = "The CIDR blocks allowed to access RDP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the Windows Server instance"
  type        = string
  default     = "ami-037bb856a23a2f822"
}

variable "instance_type" {
  description = "The instance type for the Windows Server instance"
  type        = string
  default     = "t2.micro"
}

variable "volume_size" {
  description = "The size of the default volume in GB"
  type        = number
  default     = 256
}
