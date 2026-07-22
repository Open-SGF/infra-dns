# infra-dns

Manages Cloudflare DNS records for Open SGF community domains as code.

## Scope
- Owns: Cloudflare DNS records declared in this repo for `opensgf.com`, `opensgf.org`, `takeshelternow.com`, and `takeshelternow.org`.
- Owns: Terraform/OpenTofu state for DNS changes in this stack.

## Managed Records
DNS records are grouped into one module per Cloudflare zone under `src/tf/modules/`.

## Structure
- `src/tf/`: OpenTofu provider config, zone lookups, module calls, and outputs.
- `src/tf/modules/`: DNS resources grouped by domain.
- `.github/workflows/`: Plan/validate/apply automation for DNS changes.

## Run
```bash
make help
make tf-init
make tf-plan
make tf-apply
make tf-output
```
