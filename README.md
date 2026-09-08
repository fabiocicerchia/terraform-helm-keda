# Terraform Module for KEDA

Terraform module to deploy KEDA (Kubernetes Event Driven Autoscaling) on Kubernetes using Helm.

## Overview

KEDA enables autoscaling of workloads based on events and external metrics, not just CPU/memory. It supports multiple scalers including:

- **Event-based scaling**: Scale based on external events
- **Custom metrics**: Scale on custom application metrics
- **Example deployments**: Optional example KEDA scalers for testing

## Quick Start

```hcl
module "keda" {
  source = "fabiocicerchia/keda/helm"

  release_name    = "kedacore"
  namespace       = "keda"
}
```

## Inputs

| Name            | Description                                  | Type     | Default      | Required |
| --------------- | -------------------------------------------- | -------- | ------------ | -------- |
| `release_name`  | Helm release name for KEDA                   | `string` | `"kedacore"` | no       |
| `namespace`     | Kubernetes namespace for KEDA                | `string` | `"keda"`     | no       |
| `chart_version` | Helm chart version (empty string for latest) | `string` | `""`         | no       |
| `values`        | Helm values for KEDA deployment              | `any`    | `{}`         | no       |

## Outputs

| Name            | Description                                 |
| --------------- | ------------------------------------------- |
| `namespace`     | Kubernetes namespace where KEDA is deployed |
| `release_name`  | Helm release name of KEDA                   |
| `chart_version` | Chart version of KEDA deployment            |

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster

### Dependencies

**Important:** KEDA requires Prometheus for metrics-based scaling. KEDA's `ScaledObject` resources need to reference Prometheus for metrics-based autoscaling. Ensure you have Prometheus deployed in your cluster before deploying KEDA.

## Usage

### Basic Deployment

```hcl
module "keda" {
  source = "fabiocicerchia/keda/helm"

  namespace       = "keda"
}
```

### Pin Chart Version

```hcl
module "keda" {
  source = "fabiocicerchia/keda/helm"

  chart_version   = "2.12.0"
}
```

## Verify Deployment

```bash
# Check KEDA deployment
kubectl get pods -n keda
```

## Resources

- [KEDA Documentation](https://keda.sh/)
- [KEDA Helm Chart](https://github.com/kedacore/charts)
- [KEDA Scalers Reference](https://keda.sh/docs/latest/scalers/)

## Make targets

`make help` lists them. Every repository in this estate exposes the same eight
verbs, so you do not have to read a Makefile to find out how to build or test it
(FC-GEN-057).

| Verb      | What it does here                                    |
| --------- | ---------------------------------------------------- |
| `setup`   | Install the pre-commit hook                          |
| `install` | Download the providers this module pins              |
| `lint`    | `pre-commit run --all-files` — the whole gate        |
| `format`  | `terraform fmt -recursive`                           |
| `test`    | `terraform validate` on the module and every example |
| `analyze` | `tflint --recursive`                                 |

### Not applicable

Two verbs have no meaning for a Terraform module. They exit 0 and say so rather
than pretending to work (FC-GEN-058):

- `build` — nothing is compiled; the module is consumed from source.
- `run` — a module is instantiated by a root module, never executed directly.

## License

MIT
