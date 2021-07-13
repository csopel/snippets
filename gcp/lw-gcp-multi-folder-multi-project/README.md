## Overview
This code will generate a Lacework GCP Config integration for a list of projects under multiple folders using a single service account (as opposed to the [lw-gcp-multi-project-test](../lw-gcp-multi-project-test/) folder which will create a service account per integration).  This requires configuring a ``google_projects`` data source per folder, and then creating a ``gcp_project_config`` module per folder.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_project_config_test_folder_01"></a> [gcp\_project\_config\_test\_folder\_01](#module\_gcp\_project\_config\_test\_folder\_01) | lacework/config/gcp | ~> 1.0 |
| <a name="module_gcp_project_config_test_folder_02"></a> [gcp\_project\_config\_test\_folder\_02](#module\_gcp\_project\_config\_test\_folder\_02) | lacework/config/gcp | ~> 1.0 |
| <a name="module_gcp_service_account"></a> [gcp\_service\_account](#module\_gcp\_service\_account) | lacework/service-account/gcp | n/a |

## Resources

| Name | Type |
|------|------|
| [google_projects.test-folder-01](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/projects) | data source |
| [google_projects.test-folder-02](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/projects) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_sa_project_id"></a> [gcp\_sa\_project\_id](#input\_gcp\_sa\_project\_id) | Project for Lacework integration Service Account to reside in | `string` | n/a | yes |
| <a name="input_lacework_account"></a> [lacework\_account](#input\_lacework\_account) | Lacework Account to integrate with | `string` | n/a | yes |
| <a name="input_lacework_api_key"></a> [lacework\_api\_key](#input\_lacework\_api\_key) | API Key to use for Lacework integrations | `string` | n/a | yes |
| <a name="input_lacework_api_secret"></a> [lacework\_api\_secret](#input\_lacework\_api\_secret) | API Secret for lacework\_api\_key | `string` | n/a | yes |

## Outputs

No outputs.
