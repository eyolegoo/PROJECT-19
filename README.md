# PROJECT-19
AUTOMATE INFRASTRUCTURE WITH IAC USING TERRAFORM. PART 4 – TERRAFORM CLOUD


- In previous project, we explored **AWS S3 backend** as the remote backend to store Terraform state files and refactored our terraform codes into modules and as a result the introduction of modules into our codebase it saved us time and reduce costly errors by re-using configuration written either by yourself, other members of your team, or other Terraform practitioners who have published modules for you to use


![architecture](https://github.com/eyolegoo/PROJECT-19/assets/115954100/99282ce5-3401-4e21-8885-0c30074e0eb1)


- For this project we are going to explore another option, which is the `Terraform-Cloud-P19`. We will also use `Packer-AMIs-P19` to build our machine images, and `Ansible-Deploy-P19` to configure the infrastructure.

- Before you proceed ensure you have the following tools installed on your local machine;

    - Packer. Follow this link to install [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)

    - Ansible. Follow this link to install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

    - AWS CLI. Follow sthis link to configure [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
 
## What is Packer?

- Packer is HashiCorp's open-source tool for creating machine images for multiple platforms from a single source configuration. Packer automates the creation of any type of machine image. It embraces modern configuration management by encouraging you to use automated scripts to install and configure the software within your Packer-made images.

- **Here's how Packer works with AMIs:**

   - Configuration: You define a configuration file in JSON or HCL (HashiCorp Configuration Language) that specifies what kind of image you want to build, including the source machine image, provisioners (scripts or software to install), and any custom settings.

   - Builder: Packer uses a builder to create a virtual machine or instance from a base image. For AWS, this is typically an EC2 instance. Packer launches this instance, applies the configuration, and provisions the machine based on your specifications.

   - Provisioners: Packer supports various provisioners like shell scripts, Ansible, Chef, or Puppet. These provisioners are used to configure the instance after it's launched. You can install software, configure settings, and make other customizations.

   - Image Creation: Once the instance is provisioned and configured according to your specifications, Packer shuts it down and creates an image (e.g., an AMI for AWS) from the instance. This image is a snapshot of the configured virtual machine.

   - Cleanup: After the image is created, Packer can optionally clean up any temporary resources like the EC2 instance, leaving you with just the image.

- Packer is a powerful tool for creating consistent and versioned machine images. It's commonly used in DevOps and infrastructure-as-code (IaC) workflows to ensure that the infrastructure is reproducible, tested, and version-controlled.


## STEP 1

- Clone down this [Packer-AMIs-P19 repository](https://github.com/eyolegoo/Packer-AMIs-P19) to your local machine and `cd Packer-AMIs-P19`.

- Before running the `Packer build` command, make sure to configure the AWS CLI on your local machine. Packer relies on the AWS CLI for authentication and access to AWS resources. Running the `aws configure` command will prompt you to enter your ***AWS Access Key ID*** and ***AWS Secret Access Key***.. It provides the neccessary permissions to interact with AWS resources.

- Go ahead to build the images

- For each of the following `.pkr.hcl files`, we run the following commands

- `packer fmt bastion.pkr.hcl`
- `packer validate bastion.pkr.hcl`
- `packer build bastion.pkr.hcl`

- Do same for other AMIs(**Nginx, Ubuntu and web**)

- Expected output...

<img width="732" alt="Bastion AMI" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/3645e27e-b9af-4669-bd34-d548d9250c29">

<img width="730" alt="NGINX AMI" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/7df281dc-1e90-4f94-9bb0-8bd55ac3ca09">

<img width="931" alt="Ubuntu AMI" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/0edfbf84-0ed3-4929-873f-9e16e761672f">

<img width="957" alt="Web AMI" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/e35502a5-151c-4721-a45a-f7127db21e5b">

- Console AMIs confirmed.
  
<img width="957" alt="Console AMIs confirmed" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/d53ca2f4-9d38-4ce9-bc30-17868b5a91d0">


## STEP 2

- **Terraform cloud configuration**

- Terraform Cloud This is a managed service provided by HashiCorp for using Terraform to provision and manage infrastructure in a collaborative and efficient way. Terraform Cloud provides you with Terraform CLI to provision infrastructure, either on demand or in response to various events. If you have a team who works with Terraform, you need a consistent remote environment with remote workflow and shared state to run Terraform commands. In summary, Terraform Cloud simplifies the management of infrastructure as code (IaC) and is especially useful for teams working on infrastructure projects collaboratively. It ensures consistency, security, and efficiency in managing infrastructure using Terraform.

- **What's next?**

- Migrate the .tf code to `terraform cloud` to manage the AWS infrastructure from there.

   1 - Create a Terraform Cloud account
Follow this [link](https://app.terraform.io/public/signup/account), create a new account, verify your email

   2 - Create an organization
Select “Start from scratch”, choose a name for your organization and create it.

   3 - Configure a workspace

- We will use version control workflow as the most common and recommended way to run Terraform commands triggered from our git repository.

- Make sure to clone down or fork this terraform [repository](https://github.com/eyolegoo/Terraform-Cloud-P19) to your work station and edit accordingly to meet your new changes.

- Create a new repository in your GitHub account you can give it any name, push the terraform codes to the repository. **NOTE**; Remember to copy the AMI id created with packer for the bastion, nginx, ubuntu, and webservers to the terraform.auto.tfvars file and edit accordingly.

- Go back to your terraform account, Choose version control workflow and you will be prompted to connect your GitHub account to your workspace – follow the prompt and add your newly created repository (terraform-cloud) to the workspace.

- Move on to “Configure settings”, provide a description for your workspace and leave all the rest settings to default, click “Create workspace”

  4 - Terraform Cloud supports two types of variables: environment variables and Terraform variables. Either type can be marked as sensitive, which prevents them from being displayed in the Terraform Cloud web UI and makes them write-only.

- Set two environment variables: `AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY`, set the values used in Project 16. These credentials will be used to provision your AWS infrastructure by Terraform Cloud.

- After you have set these 2 environment variables – your Terraform Cloud is all set to apply the codes from GitHub and create all necessary AWS resources.

  5 - Run `terraform plan` and `terraform apply` from web console.

- Before we push our codes to github, comment out the `listeners and attachment group` for now, reason being that we do not want our Load balancer to forward traffic to the listeners yet, because we still have some configurations we need to put in place, else we will keep getting unhealthy instances.

<img width="588" alt="uncomment1" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/78361b79-2274-4c0a-a220-9c32e769e6ea">

<img width="746" alt="uncomment2" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/29198303-9ff2-4015-a835-389b35774db1">

<img width="652" alt="uncomment3" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/76fbc95f-274c-4df5-83eb-feed5f6b8afd">

<img width="789" alt="uncomment4" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/16feb47c-1638-427a-a9f8-f55be65f2daf">


- Now Push your changes to github since we have an integration with GitHub, the process will be triggered automatically. Plan must be launched automatically, but to apply you still need to approve manually. NOTE; Even though you can configure “Auto apply”, it is always a good idea to verify your plan results before pushing it to apply to avoid any misconfigurations that can cause ‘bill shock’

- **Output**


<img width="747" alt="terraform cloud run" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/f210797a-bd42-4676-9a70-da3e59f46944">


- Because of the comment out on ***Listeners and attachment group***, the output to some resource look thus:


<img width="822" alt="BEFORE 1" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/da7725ab-be3b-4132-adb9-5fe7bf12602c">

<img width="825" alt="BEFORE 2" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/62cd7995-fad0-4d9d-9f73-ffc2341719e3">

<img width="799" alt="Nginx HC before" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/c08965b5-9e3b-402d-8978-668e05b1ff48">

<img width="800" alt="Tooling HC before" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/f0dee0d6-e778-4401-81fb-b462d0242559">

<img width="801" alt="Wordpress HC before" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/d8ebdb10-99a0-4579-9f14-84f352c8792d">

<img width="786" alt="Target Before" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/abc078cf-9ad0-42be-a7c0-ac0b3978e2d3">


