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
| --------------- | -------------------------------------------- | -------- | ------------ | :------: |
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

## License

MIT
