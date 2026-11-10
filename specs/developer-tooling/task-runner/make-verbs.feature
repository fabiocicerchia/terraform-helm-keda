@domain:developer-tooling @area:task-runner @from:terraform-helm-keda/makefile
Feature: Running the repository's make verbs
  Gives a module maintainer one predictable set of make verbs that list themselves, validate the module and its example, and refuse or explain rather than silently succeed.

  Background:
    Given the maintainer has a checkout of the terraform-helm-keda module

  @id:developer-tooling.task-runner.001 @rule:tooling.make.bare-make-lists-verbs @inferred @source:Makefile#help
  Scenario: Running make with no verb lists every available verb with its description
    When the maintainer runs make with no verb
    Then each verb is listed with its one-line description
    And the list includes setup, install, test, lint, format, analyze, build and run
    And no other action is taken

  @id:developer-tooling.task-runner.002 @rule:tooling.make.test-validates-module-and-examples @inferred @source:Makefile#test
  Scenario: Testing validates both the module and its example without a state backend
    When the maintainer runs make test
    Then the module is initialised without configuring a backend and validated
    And the examples are initialised without configuring a backend and validated
    And the run fails if either the module or the examples is invalid

  @id:developer-tooling.task-runner.003 @rule:tooling.make.analyze-refuses-without-tflint @inferred @source:Makefile#analyze
  Scenario: Analysis refuses with a pointer to tflint when tflint is not installed
    Given tflint is not installed
    When the maintainer runs make analyze
    Then the message "analyze needs tflint: https://github.com/terraform-linters/tflint" is shown on stderr
    And make reports the analyze verb failing with "Error 69"
    And no analysis is performed

  @id:developer-tooling.task-runner.004 @rule:tooling.make.not-applicable-verbs-explain @inferred @source:Makefile#build
  Scenario Outline: Verbs that do not apply to a Terraform module succeed and say why
    When the maintainer runs make <verb>
    Then the message "<message>" is shown
    And the message "See README > Not applicable." is shown
    And the command exits with status 0

    Examples:
      | verb  | message                                                                  |
      | build | Nothing to build: this is a Terraform module, consumed from source.      |
      | run   | Nothing to run: a module is called by a root module, never run directly. |
