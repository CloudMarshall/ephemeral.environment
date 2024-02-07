# 👩‍💻 Checkov - IaC Security and Best Practices Scanner

Checkov is an open-source static code analysis tool for Infrastructure as Code (IaC) files. It scans your IaC templates and identifies security issues, misconfigurations, and adherence to best practices.

## 🛠️ Installation

### 📋 Prerequisites

Make sure you have Python and pip installed on your system.

### ⬇️ Install Checkov

You can install Checkov using pip:

```bash
pip install checkov
```

## 🚀 Usage

### 🔄 Basic Usage

To scan your IaC files, navigate to the directory containing your templates and run:

```bash
checkov -d .
```

Checkov will automatically detect the IaC files in the current directory and its subdirectories and provide a report of findings.

### 📄 Specify IaC File

To scan a specific IaC file, provide the file path:

```bash
checkov -f terraform -d /path/to/your/terraform/file.tf
```

### 📂 Downloading External Modules

Downloading External Modules
If your IaC templates include external modules, make sure to download them before running Checkov.

```bash
checkov -d . --download-external-modules true
```
## 🔍 Example

```bash
$ checkov -d . --download-external-modules true
[ terraform framework ]: 100%|████████████████████|[4/4], Current File Scanned=variables.tf
[ secrets framework ]: 100%|████████████████████|[4/4], Current File Scanned=./backend.tf  


       _               _              
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V / 
  \___|_| |_|\___|\___|_|\_\___/ \_/  
                                      
By bridgecrew.io | version: 2.2.43 
Update available 2.2.43 -> 3.2.5
Run pip3 install -U checkov to update 


terraform scan results:

Passed checks: 1, Failed checks: 0, Skipped checks: 0

Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
        PASSED for resource: aws.default
        File: /provider.tf:11-16
        Guide: https://docs.bridgecrew.io/docs/bc_aws_secrets_5

```