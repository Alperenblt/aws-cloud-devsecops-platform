# Development Environment

This directory is reserved for the development environment configuration.

Purpose:
- Provides a safe environment for development and testing changes.
- Uses the shared Terraform modules located in `terraform/modules/`.
- Must keep its own Terraform state separate from other environments.

Important notes:
- The shared Terraform modules are stored in `terraform/modules/`.
- Each environment must use its own Terraform state file to isolate workloads and configuration.
- This environment is not yet configured for deployment.
