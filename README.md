# aide-platform

Orchestrates the `aide-infra` Terraform modules and runs plan and apply pipelines.

## Structure

```
bootstrap/          Creates S3 state bucket and DynamoDB lock table (run once)
environments/
  dev/              Calls network, storage, and compute modules for the dev environment
.github/workflows/  Terraform plan on PR, apply on merge to main
```

## Getting started

1. Run bootstrap first (local state, run once):
   ```bash
   cd bootstrap && terraform init && terraform apply
   ```

2. Initialise the dev environment:
   ```bash
   cd environments/dev && terraform init && terraform plan
   ```

3. Push to a PR to trigger the plan workflow. Merge to main to apply.

## Module sources

All modules are sourced from [aide-infra](https://github.com/SundaramDiraviam/aide-infra).
