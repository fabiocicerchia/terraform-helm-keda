@domain:integration @area:usage-examples @from:examples/outputs
Feature: Reading back the example's KEDA deployment
  Shows operators who copy the worked example how to see where KEDA landed, under which release name, and which chart version, so downstream configuration can use those values.

  Background:
    Given the operator applies the worked example, which installs KEDA as release "keda" in namespace "keda-system" pinned to chart version "2.14.0"

  @id:integration.usage-examples.003 @rule:integration.usage-examples.reexports-deployment-outputs @inferred @source:examples/outputs.tf#keda_namespace @questionable
  Scenario Outline: The example reports where KEDA was deployed, under which release and at which chart version
    Given the example deployment has been applied
    When the operator reads the example's <output> output
    Then the value is "<value>"
    And the output is described as "<description>"

    Examples:
      | output             | value       | description                            |
      | keda_namespace     | keda-system | The namespace where KEDA is deployed   |
      | keda_release_name  | keda        | The Helm release name of KEDA          |
      | keda_chart_version | 2.14.0      | The chart version of the deployed KEDA |
