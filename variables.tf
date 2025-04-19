variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-west-2"
}
