## Overview
This code will generate a Lacework GCP Config integration for a list of projects ``gcp_project_ids`` using a single service account (as opposed to the [lw-gcp-multi-project-test](../lw-gcp-multi-project-test/) folder which will create a service account per integration)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 0.5 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_project_config"></a> [gcp\_project\_config](#module\_gcp\_project\_config) | lacework/config/gcp | ~> 1.0 |
| <a name="module_gcp_service_account"></a> [gcp\_service\_account](#module\_gcp\_service\_account) | lacework/service-account/gcp | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_project_ids"></a> [gcp\_project\_ids](#input\_gcp\_project\_ids) | Projects to integrate into Lacework | `list(any)` | n/a | yes |
| <a name="input_gcp_sa_project_id"></a> [gcp\_sa\_project\_id](#input\_gcp\_sa\_project\_id) | Project for Lacework integration Service Account to reside in | `string` | n/a | yes |
| <a name="input_lacework_account"></a> [lacework\_account](#input\_lacework\_account) | Lacework Account to integrate with | `string` | n/a | yes |
| <a name="input_lacework_api_key"></a> [lacework\_api\_key](#input\_lacework\_api\_key) | API Key to use for Lacework integrations | `string` | n/a | yes |
| <a name="input_lacework_api_secret"></a> [lacework\_api\_secret](#input\_lacework\_api\_secret) | API Secret for lacework\_api\_key | `string` | n/a | yes |

## Outputs

No outputs.
