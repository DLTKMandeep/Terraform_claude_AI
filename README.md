# Terraform Random Cluster Generator

This Terraform module generates random identifiers for clusters, providing both a unique cluster ID and a human-friendly cluster name.

## Features

- Generates a 9-character alphanumeric cluster ID (lowercase only)
- Creates a memorable two-word cluster name using the random pet naming convention
- Provides both values as module outputs for use in other resources

## Usage

```hcl
module "cluster_identifiers" {
  source = "path/to/module"
}

# Use the generated identifiers
resource "example_cluster" "this" {
  id   = module.cluster_identifiers.cluster_id
  name = module.cluster_identifiers.cluster_name
  # ... other configuration ...
}
```

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

### Using with Kubernetes or Other Cluster Resources

```hcl
module "cluster_identifiers" {
  source = "path/to/module"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = module.cluster_identifiers.cluster_name
    
    labels = {
      cluster_id = module.cluster_identifiers.cluster_id
    }
  }
}
```

## Inputs

This module has no inputs.

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The generated cluster ID (9-character random string, lowercase alphanumeric) |
| cluster_name | The generated cluster name (two random words separated by a hyphen) |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| random | >= 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [random_string.cluster_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_pet.cluster_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## License

MIT

## Authors

Module created and maintained by [Your Name/Organization].

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
