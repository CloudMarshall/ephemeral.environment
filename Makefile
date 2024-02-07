CONFIG_FILE := .localterraform

get_config_value = $(shell grep -m1 "^$(1)=" $(CONFIG_FILE) 2>/dev/null | cut -d '=' -f 2-)

init:
	@rm -rf .terraform; \
	echo "🌍 Available accounts:"; \
	SELECTED_ACCOUNT_INDEX=0; \
	ACCOUNT_DIRS=$$(find params -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | nl -n ln); \
	echo "$$ACCOUNT_DIRS"; \
	read -p "Choose an account by entering the corresponding number: " SELECTED_ACCOUNT_INDEX; \
	SELECTED_ACCOUNT=$$(echo "$$ACCOUNT_DIRS" | sed -n "$${SELECTED_ACCOUNT_INDEX}p" | awk '{print $$2}'); \
	echo "🌐 You selected the account: $$SELECTED_ACCOUNT"; \
	echo "🌍 Available regions:"; \
	SELECTED_REGION_INDEX=0; \
	DIRS=$$(find params/$$SELECTED_ACCOUNT -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | nl -n ln); \
	echo "$$DIRS"; \
	read -p "Choose a region by entering the corresponding number: " SELECTED_REGION_INDEX; \
	SELECTED_REGION=$$(echo "$$DIRS" | sed -n "$${SELECTED_REGION_INDEX}p" | awk '{print $$2}'); \
	echo "🚀 You selected the region: $$SELECTED_REGION"; \
	ENV_DIRS=$$(find params/$$SELECTED_ACCOUNT/$$SELECTED_REGION -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | nl -n ln); \
	echo "$$ENV_DIRS"; \
	read -p "Choose an environment by entering the corresponding number: " SELECTED_ENV_INDEX; \
	SELECTED_ENV=$$(echo "$$ENV_DIRS" | sed -n "$${SELECTED_ENV_INDEX}p" | awk '{print $$2}'); \
	echo "🚀 You selected the environment: $$SELECTED_ENV"; \
	{ echo "ACCOUNT=$$SELECTED_ACCOUNT"; echo "REGION=$$SELECTED_REGION"; echo "ENV=$$SELECTED_ENV"; } > $(CONFIG_FILE); \
	terraform init -backend-config="params/$$SELECTED_ACCOUNT/$$SELECTED_REGION/$$SELECTED_ENV/backend.config" -reconfigure

plan:
	@DEFAULT_ACCOUNT=$(call get_config_value,ACCOUNT); \
	DEFAULT_REGION=$(call get_config_value,REGION); \
	DEFAULT_ENV=$(call get_config_value,ENV); \
	if [ -z "$$DEFAULT_ACCOUNT" ]; then \
		echo "❗ Please run 'make init' before running 'make plan'"; \
		exit 1; \
	fi; \
	if [ -z "$$DEFAULT_REGION" ]; then \
		echo "❗ Please run 'make init' before running 'make plan'"; \
		exit 1; \
	fi; \
	if [ -z "$$DEFAULT_ENV" ]; then \
		echo "❗ Please run 'make init' before running 'make plan'"; \
		exit 1; \
	fi; \
	printf "\033[32m📋 Plan output for \033[33m\033[1m\033[4m$$DEFAULT_ENV\033[0m\033[32m environment in region \033[33m\033[1m\033[4m$$DEFAULT_REGION\033[0m\033[32m\033[0m\n"; \
	terraform plan -var-file="params/$$DEFAULT_ACCOUNT/$$DEFAULT_REGION/$$DEFAULT_ENV/params.tfvars"

apply:
	@DEFAULT_ACCOUNT=$(call get_config_value,ACCOUNT); \
	DEFAULT_REGION=$(call get_config_value,REGION); \
	DEFAULT_ENV=$(call get_config_value,ENV); \
	if [ -z "$$DEFAULT_ACCOUNT" ]; then \
		echo "❗ Please run 'make init' before applying"; \
		exit 1; \
	fi; \
	if [ -z "$$DEFAULT_REGION" ]; then \
		echo "❗ Please run 'make init' before applying"; \
		exit 1; \
	fi; \
	if [ -z "$$DEFAULT_ENV" ]; then \
		echo "❗ Please run 'make init' before applying"; \
		exit 1; \
	fi; \
	printf "\033[32m🚧 Apply configuration to \033[33m\033[1m\033[4m$$DEFAULT_ENV\033[0m\033[32m environment in region \033[33m\033[1m\033[4m$$DEFAULT_REGION\033[0m\033[32m \033[1;31m- THIS IS AN APPLY\033[0m\n"; \
	bash -c 'read -n1 -p "🤔 Press any key to continue or Ctrl+C to abort..."; echo "";'; \
	terraform apply -var-file="params/$$DEFAULT_ACCOUNT/$$DEFAULT_REGION/$$DEFAULT_ENV/params.tfvars"

target:
	@DEFAULT_ACCOUNT=$(call get_config_value,ACCOUNT); \
	DEFAULT_REGION=$(call get_config_value,REGION); \
	DEFAULT_ENV=$(call get_config_value,ENV); \
	if [ -z "$$DEFAULT_ACCOUNT" ]; then \
		echo "❗ Please run 'make init' before targeting"; \
		exit 1; \
	fi; \
	if [ -z "$$DEFAULT_REGION" ]; then \
		echo "❗ Please run 'make init' before targeting"; \
		exit 1; \
	fi; \
	if [ -z "$$DEFAULT_ENV" ]; then \
		echo "❗ Please run 'make init' before targeting"; \
		exit 1; \
	fi; \
	read -p "Enter the resource or module to target (e.g., module.my_module or aws_instance.example): " TARGET_RESOURCE; \
	printf "\033[32m🎯 Targeting resource/module \033[33m\033[1m\033[4m$$TARGET_RESOURCE\033[0m\033[32m in \033[33m\033[1m\033[4m$$DEFAULT_ENV\033[0m\033[32m environment in region \033[33m\033[1m\033[4m$$DEFAULT_REGION\033[0m\033[32m \033[1;31m- THIS IS A TARGETED APPLY\033[0m\n"; \
	bash -c 'read -n1 -p "🤔 Press any key to continue or Ctrl+C to abort..."; echo "";'; \
	terraform apply -var-file="params/$$DEFAULT_ACCOUNT/$$DEFAULT_REGION/$$DEFAULT_ENV/params.tfvars" --target=$$TARGET_RESOUR
