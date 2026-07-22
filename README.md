# infra-dns

Manages Cloudflare DNS records for `opensgf.org` as code.

## Scope
- Owns: Cloudflare DNS records declared in this repo for the `opensgf.org` zone.
- Owns: Terraform/OpenTofu state for DNS changes in this stack.

## Managed Records
No DNS records are declared yet.

## Structure
- `src/tf/`: OpenTofu DNS resources, provider config, backend config, and outputs.
- `.github/workflows/`: Plan/validate/apply automation for DNS changes.

## Run
```bash
make help
make tf-init
make tf-plan
make tf-apply
make tf-output
```
