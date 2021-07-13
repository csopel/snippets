## Overview
This code will generate a Lacework GCP Config integration for a list of projects under a single folder ``gcp_folder_id`` using a single service account (as opposed to the [lw-gcp-multi-project-test](../lw-gcp-multi-project-test/) folder which will create a service account per integration)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.74.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_project_config"></a> [gcp\_project\_config](#module\_gcp\_project\_config) | lacework/config/gcp | ~> 1.0 |
| <a name="module_gcp_service_account"></a> [gcp\_service\_account](#module\_gcp\_service\_account) | lacework/service-account/gcp | n/a |

## Resources

| Name | Type |
|------|------|
| [google_projects.folder-01](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_folder_id"></a> [gcp\_folder\_id](#input\_gcp\_folder\_id) | Folder ID (numeric) that contains the projects to integrate into Lacework | `number` | n/a | yes |
| <a name="input_gcp_sa_project_id"></a> [gcp\_sa\_project\_id](#input\_gcp\_sa\_project\_id) | Project for Lacework integration Service Account to reside in | `string` | n/a | yes |
| <a name="input_lacework_account"></a> [lacework\_account](#input\_lacework\_account) | Lacework Account to integrate with | `string` | n/a | yes |
| <a name="input_lacework_api_key"></a> [lacework\_api\_key](#input\_lacework\_api\_key) | API Key to use for Lacework integrations | `string` | n/a | yes |
| <a name="input_lacework_api_secret"></a> [lacework\_api\_secret](#input\_lacework\_api\_secret) | API Secret for lacework\_api\_key | `string` | n/a | yes |

## Outputs

No outputs.
