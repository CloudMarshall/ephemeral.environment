# Terraform Makefile

Although we are to use CICD throughout the majority of our deployments, there will be occasions we need to run a stack locally to debug. For this case a Makefile is provided.

This Makefile is designed to streamline the process of initializing, planning, applying, and targeting Terraform configurations with a specific structure. It allows you to choose a region and environment interactively during initialization and provides commands for planning, applying, and targeting resources/modules.


## Prerequisites

- [Terraform](https://www.terraform.io/) installed on your system.
- A valid Terraform configuration structure with regions and environments under the `params` directory.

## Usage

### 🚀 Initialization

To initialize the Terraform configuration, run:

```bash
$ make init

🌍 Available regions:
1       eu-west-1
Choose a region by entering the corresponding number: 1
🚀 You selected the region: eu-west-1
1       prod
2       dev
Choose an environment by entering the corresponding number: 2
🚀 You selected the environment: dev
```

This command interactively asks you to choose a region and environment. It then initializes Terraform with the selected configuration.

### 📋 Planning

To generate a Terraform execution plan, run:

```bash
$ make plan

📋 Plan output for dev environment in region eu-west-1
... (Terraform plan output)

```

This command displays the execution plan for the selected environment and region.

### 🚧 Applying

To apply the Terraform configuration, run:

```bash
$ make apply

🚧 Apply configuration to dev environment in region eu-west-1 - THIS IS AN APPLY
🤔 Press any key to continue or Ctrl+C to abort...

... (Terraform apply output)

```

### 🎯 Targeting

To target a specific resource or module, run:

```bash
make target

🎯 Targeting resource/module aws_instance.example in dev environment in region eu-west-1 - THIS IS A TARGETED APPLY
🤔 Press any key to continue or Ctrl+C to abort...


... (Terraform apply output for the targeted resource)

```

This command interactively asks you to enter the resource or module to target and applies the configuration accordingly.
