# Deploying a Public Access Azure Database for PostgreSQL Flexible Server using Terraform
[![Terraform](https://img.shields.io/badge/terraform-v1.8+-blue.svg)](https://www.terraform.io/downloads.html)

## Overview

Deploying an Azure Database for PostgreSQL Flexible Server with Public Access using Terraform

Blog --> https://gmusumeci.medium.com/how-to-deploy-a-public-access-azure-postgresql-flexible-server-using-terraform-92c16d13456e

## Code creates:

- Resource Group
- PostgreSQL Flexible Server
- PostgreSQL Database
- PostgreSQL Firewall Rules
- PostgreSQL Extensions

##  Variables

List of variables used in this code to configure the PostgreSQL Flexible Server:

| Variable | Description | Type | 
| --- | --- | --- | 
| `location` | The region in which this module should be deployed | string | 
| `company` | This variable defines the company name used to build resources | string | 
| `app_name` | This variable defines the application name used to build resources | string | 
| `environment` | This variable defines the environment to be built | string |
| `tags` | The collection of tags to be applied to all resources | map(string) |
| `postgres_user`            | The username for PostgreSQL administrator login | string |
| `postgres_password`        | The password for PostgreSQL administrator login | string |
| `postgres_server_sku`      | PostgreSQL server type | string |
| `postgres_server_version`  | PostgreSQL server version (Possible values are 11, 12, 13, 14, 15 and 16)| string |
| `postgres_server_storage_mb` | PostgreSQL server storage in MB (Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216 and 33553408) | number |
| `postgres_server_storage_tier` | PostgreSQL server storage tier (Possible values are P4, P6, P10, P15,P20, P30,P40, P50,P60, P70 or P80) | string |
| `postgres_admin_access_cidr` | PostgreSQL admin access CIDR | string |
| `postgres_database_collation` | Specifies the Collation for the Azure PostgreSQL Flexible Server Database | string |
| `postgres_database_charset` | Specifies the charset for the Azure PostgreSQL Flexible Server Database | string |

## How To deploy the code:

- Clone the repo
- Update variables to your environment
- Execute "terraform init"
- Execute "terraform apply"
