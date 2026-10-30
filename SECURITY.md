# Security Risk Register

## AWS-0104 — Unrestricted Egress

- **Severity:** CRITICAL
- **Affected resource:** EC2 Security Group
- **Finding:** The security group allows outbound traffic to `0.0.0.0/0` using all protocols.
- **Risk:** If an EC2 instance is compromised, it could initiate unrestricted outbound connections.
- **Decision:** Temporarily accept this risk in the development learning environment.
- **Reason:** The instance installs Nginx during startup. Required outbound destinations have not yet been verified. EC2 creation is currently disabled (`create_ec2=false`).
- **Future mitigation:** Identify required outbound destinations and implement least-privilege egress rules.
- **Review trigger:** Before enabling EC2 or deploying to production.

## AWS-0132 — S3 Customer-Managed Encryption Key

- **Severity:** HIGH
- **Affected resource:** Application S3 Bucket
- **Finding:** The S3 bucket uses SSE-S3 (AES256) encryption instead of a customer-managed AWS KMS key.
- **Risk:** Encryption keys are managed by AWS, limiting our control over key policies, rotation, and auditing.
- **Existing protection:** Server-side encryption is enabled using SSE-S3 (AES256).
- **Decision:** Temporarily accept this risk in the development learning environment.
- **Reason:** SSE-S3 already provides encryption at rest. A customer-managed KMS key would introduce additional costs and management overhead.
- **Future mitigation:** Evaluate SSE-KMS with a customer-managed key for production workloads.
- **Review trigger:** Before deploying to production or introducing sensitive data.