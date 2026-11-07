@domain:integration @area:compatibility @from:terraform-helm-keda/versions
Feature: Declaring supported Terraform, OpenTofu and Helm provider versions
  Serves operators adopting the module by stating, and enforcing at init/plan time, which Terraform/OpenTofu and Helm provider versions it runs on, so incompatible toolchains are refused up front instead of failing mid-deploy.

  Background:
    Given the operator's configuration calls the KEDA module

  @id:integration.compatibility.001 @rule:keda.compatibility.minimum-terraform-version @inferred @source:versions.tf#terraform
  Scenario Outline: The module refuses to run on Terraform or OpenTofu older than 1.0
    Given the operator's toolchain is <tool> version <tool_version>
    When the operator initialises the configuration
    Then the module is <outcome>

    Examples:
      | tool      | tool_version | outcome                                                  |
      | Terraform | 0.15.5       | refused with an unsupported Terraform Core version error |
      | Terraform | 1.0.0        | accepted                                                 |
      | Terraform | 1.9.8        | accepted                                                 |
      | OpenTofu  | 1.6.0        | accepted                                                 |

  @id:integration.compatibility.002 @rule:keda.compatibility.minimum-helm-provider-version @inferred @source:versions.tf#terraform
  Scenario Outline: The module requires the HashiCorp Helm provider at version 2.0 or later
    Given the operator's configuration locks the hashicorp/helm provider to version <provider_version>
    When the operator initialises the configuration
    Then the module is <outcome>

    Examples:
      | provider_version | outcome                                                          |
      | 1.3.2            | refused because no installable provider version satisfies >= 2.0 |
      | 2.0.0            | accepted                                                         |
      | 2.17.0           | accepted                                                         |
      | 3.0.2            | accepted                                                         |
