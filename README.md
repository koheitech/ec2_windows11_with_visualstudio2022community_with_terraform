# README

This is a terraform setup to launch an EC2 instance of Windows11 with VisualStudio Commnuity 2022 installed.

Once launched, you can connect to the windows env with Remote Desktop Connection.

# How-to
## Prerequisite
1. Make sure to have AWS account and IAM user for terraform
    - cf: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build


2. Install [Windows App(Previously Remote Desktop)](https://apps.apple.com/us/app/windows-app/id1295203466?mt=12)

3. Create PEM-format SSH key

    ```bash
    ssh-keygen -t rsa -b 2048 -m PEM -f ~/.ssh/windows_ec2_key
    ```

## Launch EC2 with terraform
1. Set up environment variables
    - modify [terraform.tfvars.example](./terraform.tfvars.example)
    - rename it to `terraform.tfvars`
2. Execute terraform command
    ```bash
    terraform plan
    ```
    ```bash
    terraform apply
    ```

## Connect to the windows instance using Remote Desktop Connection
Once launched and health check has passed, we can start remote desktop connection.

