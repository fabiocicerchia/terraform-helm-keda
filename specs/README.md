# Specifications of terraform-helm-keda

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Developer tooling

Commands and checks maintainers use to build, validate and keep the module tidy.

- **Task runner**: [Running the repository's make verbs](developer-tooling/task-runner/make-verbs.feature) (4)

## Integration

What the module exposes to and requires from the code that calls it.

- **Platform compatibility**: [Declaring supported Terraform, OpenTofu and Helm provider versions](integration/compatibility/platform-compatibility.feature) (2)
- **Usage examples**: [Reading back the example's KEDA deployment](integration/usage-examples/example-deployment-outputs.feature) (1), [Trying KEDA out with the worked example](integration/usage-examples/keda-usage-example.feature) (1)
