# Terraform Random Cluster Generator Module

This Terraform module generates random cluster identifiers and names for use in cloud infrastructure deployments. It provides both a random string ID and a more human-friendly pet name for your clusters.

## Features

- Generates a random 7-character alphanumeric cluster ID
- Creates a friendly two-word cluster name using the random pet naming convention
- Configurable environment and region variables
- Outputs both identifiers for use in other Terraform resources

## Usage

```hcl
module "cluster_identifiers" {
  source = "path/to/module"

  environment = "staging"
  region      = "us-east-1"
}

# Use the generated identifiers
resource "aws_eks_cluster" "example" {
  name     = module.cluster_identifiers.cluster_name
  role_arn = aws_iam_role.cluster.arn
  
  vpc_config {
    subnet_ids = aws_subnet.example[*].id
  }

  tags = {
    Environment = var.environment
    ClusterID   = module.cluster_identifiers.cluster_id
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| random | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| random | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment name (dev, staging, prod) | `string` | `"dev"` | no |
| region | AWS region | `string` | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The generated cluster ID |
| cluster_name | The generated cluster name |

## Examples

### Basic Usage

```hcl
module "cluster_identifiers" {
  source = "path/to/module"
}

output "generated_cluster_id" {
  value = module.cluster_identifiers.cluster_id
}

output "generated_cluster_name" {
  value = module.cluster_identifiers.cluster_name
}
```

### Custom Environment and Region

```hcl
module "cluster_identifiers" {
  source = "path/to/module"

  environment = "prod"
  region      = "eu-central-1"
}
```

## How It Works

This module uses Terraform's random provider to generate two different identifiers:

1. `cluster_id`: A 7-character lowercase alphanumeric string (no special characters)
2. `cluster_name`: A two-word pet name with a hyphen separator (e.g., "happy-dolphin")

These identifiers can be used to uniquely name your cluster resources while also providing a human-readable reference.

## License

MIT

## Authors

Your Organization
