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

- Configure a workspace

- We will use version control workflow as the most common and recommended way to run Terraform commands triggered from our git repository.

- Make sure to clone down or fork this terraform [repository](https://github.com/eyolegoo/Terraform-Cloud-P19) to your work station and edit accordingly to meet your new changes.

- Create a new repository in your GitHub account you can give it any name, push the terraform codes to the repository. **NOTE**; Remember to copy the AMI id created with packer for the bastion, nginx, ubuntu, and webservers to the terraform.auto.tfvars file and edit accordingly.

- Go back to your terraform account, Choose version control workflow and you will be prompted to connect your GitHub account to your workspace – follow the prompt and add your newly created repository (terraform-cloud) to the workspace.

- Move on to “Configure settings”, provide a description for your workspace and leave all the rest settings to default, click “Create workspace”
