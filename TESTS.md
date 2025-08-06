# Terraform Test Files for Random Cluster Module

I'll create a set of test files to validate your module that generates random cluster IDs and names. Let's create two test files:

1. A basic test to verify both resources are created correctly
2. A test to validate the output values match the expected format

## basic_test.tftest.hcl

```hcl
variables {
  // No input variables required for this module
}

run "verify_resources_created" {
  command = plan

  assert {
    condition     = length(random_string.cluster_id) == 1
    error_message = "random_string.cluster_id resource was not created"
  }

  assert {
    condition     = length(random_pet.cluster_name) == 1
    error_message = "random_pet.cluster_name resource was not created"
  }
}

run "verify_resource_configuration" {
  command = plan

  assert {
    condition     = random_string.cluster_id.length == 9
    error_message = "random_string.cluster_id length should be 9"
  }

  assert {
    condition     = random_string.cluster_id.special == false
    error_message = "random_string.cluster_id should not include special characters"
  }

  assert {
    condition     = random_string.cluster_id.upper == false
    error_message = "random_string.cluster_id should not include uppercase characters"
  }

  assert {
    condition     = random_pet.cluster_name.length == 2
    error_message = "random_pet.cluster_name length should be 2"
  }

  assert {
    condition     = random_pet.cluster_name.separator == "-"
    error_message = "random_pet.cluster_name separator should be '-'"
  }
}
```

## output_test.tftest.hcl

```hcl
variables {
  // No input variables required for this module
}

run "verify_outputs_exist" {
  command = apply

  assert {
    condition     = output.cluster_id != null && output.cluster_id != ""
    error_message = "cluster_id output should not be empty"
  }

  assert {
    condition     = output.cluster_name != null && output.cluster_name != ""
    error_message = "cluster_name output should not be empty"
  }
}

run "verify_output_formats" {
  command = apply

  assert {
    condition     = length(output.cluster_id) == 9
    error_message = "cluster_id output should be 9 characters long"
  }

  assert {
    condition     = can(regex("^[a-z0-9]{9}$", output.cluster_id))
    error_message = "cluster_id output should only contain lowercase letters and numbers"
  }

  assert {
    condition     = can(regex("^[a-z]+-[a-z]+$", output.cluster_name))
    error_message = "cluster_name output should be in format 'word-word'"
  }
}
```

These test files will verify:
1. That the resources are created with the correct configuration
2. That the outputs exist and match the expected format
3. That the random string is 9 characters long with no special or uppercase characters
4. That the random pet name consists of two words separated by a hyphen

You can run these tests with the `terraform test` command in the directory containing your module and test files.
