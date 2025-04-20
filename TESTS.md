# Terraform Test Files for Random Cluster Module

I'll create comprehensive test files for your module that validates the resources and outputs. Here are the test files:

## main.tftest.hcl

```hcl
# Test basic functionality with default values
run "default_values" {
  command = plan

  # Assert that resources will be created
  assert {
    condition     = length(random_string.cluster_id) == 1
    error_message = "random_string.cluster_id resource should be created"
  }

  assert {
    condition     = length(random_pet.cluster_name) == 1
    error_message = "random_pet.cluster_name resource should be created"
  }

  # Validate random_string configuration
  assert {
    condition     = random_string.cluster_id.length == 7
    error_message = "random_string.cluster_id length should be 7"
  }

  assert {
    condition     = random_string.cluster_id.special == false
    error_message = "random_string.cluster_id should not include special characters"
  }

  assert {
    condition     = random_string.cluster_id.upper == false
    error_message = "random_string.cluster_id should not include uppercase characters"
  }

  # Validate random_pet configuration
  assert {
    condition     = random_pet.cluster_name.length == 2
    error_message = "random_pet.cluster_name length should be 2"
  }

  assert {
    condition     = random_pet.cluster_name.separator == "-"
    error_message = "random_pet.cluster_name separator should be '-'"
  }

  # Validate default variable values
  assert {
    condition     = var.environment == "dev"
    error_message = "Default environment should be 'dev'"
  }

  assert {
    condition     = var.region == "us-west-2"
    error_message = "Default region should be 'us-west-2'"
  }
}

# Test with custom variable values
run "custom_variables" {
  command = plan

  variables {
    environment = "prod"
    region      = "eu-west-1"
  }

  assert {
    condition     = var.environment == "prod"
    error_message = "Environment should be set to 'prod'"
  }

  assert {
    condition     = var.region == "eu-west-1"
    error_message = "Region should be set to 'eu-west-1'"
  }
}

# Test output values
run "output_validation" {
  command = apply

  # Check that outputs are non-empty
  assert {
    condition     = length(output.cluster_id) > 0
    error_message = "cluster_id output should not be empty"
  }

  assert {
    condition     = length(output.cluster_name) > 0
    error_message = "cluster_name output should not be empty"
  }

  # Verify output matches resource values
  assert {
    condition     = output.cluster_id == random_string.cluster_id.result
    error_message = "cluster_id output should match random_string.cluster_id.result"
  }

  assert {
    condition     = output.cluster_name == random_pet.cluster_name.id
    error_message = "cluster_name output should match random_pet.cluster_name.id"
  }
}

# Test random_string properties
run "random_string_properties" {
  command = apply

  assert {
    condition     = length(random_string.cluster_id.result) == 7
    error_message = "random_string.cluster_id result should have length 7"
  }

  assert {
    condition     = can(regex("^[a-z0-9]+$", random_string.cluster_id.result))
    error_message = "random_string.cluster_id should only contain lowercase letters and numbers"
  }
}

# Test random_pet properties
run "random_pet_properties" {
  command = apply

  assert {
    condition     = can(regex("-", random_pet.cluster_name.id))
    error_message = "random_pet.cluster_name should contain the separator '-'"
  }

  assert {
    condition     = length(split("-", random_pet.cluster_name.id)) == 2
    error_message = "random_pet.cluster_name should have exactly 2 parts"
  }
}
```

## variables.tftest.hcl

```hcl
# Test variable validation
run "variable_defaults" {
  command = plan

  # Check default values
  assert {
    condition     = var.environment == "dev"
    error_message = "Default environment should be 'dev'"
  }

  assert {
    condition     = var.region == "us-west-2"
    error_message = "Default region should be 'us-west-2'"
  }
}

# Test with staging environment
run "staging_environment" {
  command = plan

  variables {
    environment = "staging"
    region      = "us-west-2"
  }

  assert {
    condition     = var.environment == "staging"
    error_message = "Environment should be set to 'staging'"
  }
}

# Test with production environment and different region
run "production_environment" {
  command = plan

  variables {
    environment = "prod"
    region      = "us-east-1"
  }

  assert {
    condition     = var.environment == "prod"
    error_message = "Environment should be set to 'prod'"
  }

  assert {
    condition     = var.region == "us-east-1"
    error_message = "Region should be set to 'us-east-1'"
  }
}
```

These test files provide comprehensive validation of your module's functionality, including:

1. Resource creation and configuration
2. Default and custom variable values
3. Output validation
4. String pattern validation for the generated random values
5. Multiple test scenarios for different environments

You can run these tests using the `terraform test` command in the directory containing your module and test files.
