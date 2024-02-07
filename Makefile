CONFIG_FILE := .localterraform

get_config_value = $(shell grep -m1 "^$(1)=" $(CONFIG_FILE) 2>/dev/null | cut -d '=' -f 2-)

init:
	@rm -rf .terraform
	@echo "\033[1;36mInitializing Terraform with backend configuration...\033[0m"
	@terraform init -backend-config="params/backend.config" -reconfigure

plan:
	@echo "\033[1;36mPlanning Terraform deployment using parameters...\033[0m"
	@terraform plan -var-file="params/params.tfvars"

apply:
	@echo "\033[1;36mApplying Terraform configuration...\033[0m"
	@bash -c 'read -n1 -p "Press any key to continue or Ctrl+C to abort..."; echo "";'
	@terraform apply -var-file="params/params.tfvars"

target:
	@read -p "Enter the resource or module to target (e.g., module.my_module or aws_instance.example): " TARGET_RESOURCE; \
	printf "\033[1;36mTargeting resource/module %s - THIS IS A TARGETED APPLY\033[0m\n" $$TARGET_RESOURCE; \
	bash -c 'read -n1 -p "Press any key to continue or Ctrl+C to abort..."; echo "";'; \
	terraform apply -var-file="params/params.tfvars" --target=$$TARGET_RESOURCE

destroy:
	@echo "\033[1;31mDestroying Terraform-managed infrastructure...\033[0m"
	@bash -c 'read -n1 -p "⚠️ WARNING: This will destroy your infrastructure. Press any key to continue or Ctrl+C to abort..."; echo "";'
	@terraform destroy -var-file="params/params.tfvars"
