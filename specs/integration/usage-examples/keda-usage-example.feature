@domain:integration @area:usage-examples @from:examples/examples
Feature: Trying KEDA out with the worked example
  Gives an operator a ready-to-apply configuration that shows how to install KEDA with a pinned chart, its own namespace and resource limits, and how to pick up what was deployed.

  Background:
    Given the operator has a Kubernetes cluster reachable by the Helm provider
    And the operator works from the module's worked example

  @id:integration.usage-examples.002 @rule:examples.usage.helm-provider-2x-only @inferred @source:examples/main.tf#terraform @questionable
  Scenario: The worked example only runs with Helm provider 2.x, even though the module accepts newer ones
    Given the operator's configuration requires the hashicorp/helm provider at 3.0 or newer
    When the operator initialises the worked example
    Then initialisation refuses the Helm provider because the example needs "~> 2.0"
    And the module on its own would accept it under ">= 2.0"
