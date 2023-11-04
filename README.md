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


## STEP 4

- **ANSIBLE configuration**

- Before we proceed with the Ansible section of this project, i would like to explain the concept of Dynamic inventory plugin

   - Ansible Dynamic Inventory Plugin: When using Ansible with AWS or other cloud platforms, inventory file maintenance will be a hectic task as AWS frequently changes IPs, autoscaling instances, and more. Once your AWS EC2 hosts are spun up, you’ll probably want to talk to them again. With a cloud setup, it’s best not to maintain a static list of cloud hostnames in text files. Rather, the best way to handle this is to use the aws_ec2 dynamic inventory plugin.
  
- This is how it works here; The aws_ec2 dynamic inventory plugin makes API calls to AWS to get a list of inventory hosts from Amazon Web Services EC2 in the run time. It gives the EC2 instance details dynamically to manage the AWS infrastructure.

- Our infrastucture configuration management will happen from our bastion server, since we have configured our firewall/security-group to allow `ssh access` from the bastion host.

- I `ssh into the bastion` with the below setup. This will serve as a jumpbox(access) to the other servers.



<img width="477" alt="ssh bastion" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/41ec3ef0-3f80-48f8-a3b4-eef36074bf59">


- After a successful `ssh into the bastion`, I ran the `aws configure` command. This allows you to provide your AWS access key and secret access key as usual, which are used to authenticate your Ansible playbook with AWS services. This is crucial because AWS resources, such as EC2 instances, S3 buckets, and RDS databases, require proper authentication to interact with them. And since we are making use of AWS dynamic inventory plugin in Ansible configaration, it relies on the AWS CLI configuration to discover and list AWS resources. By configuring the AWS CLI on the bastion host, we ensure that the dynamic inventory plugin can authenticate with AWS and query AWS resources correctly.

- I cloned the Ansible-Deploy-P19 repo to the bastion server. The cloned repo becomes our ***PWD***

- **Take note**; I edited the `EFS access point and the RDS endpoint` for the **tooling and wordpress**. Open the **roles//tasks/main.yml and setup-db.yml** and edit accordingly.

- **Note**, Ansible has modules and plugins that allow it to interact with AWS services. These modules rely on Python libraries like `botocore and boto3` to communicate with AWS APIs. Without this, Ansible cannot establish connections to AWS services, making AWS integration impossible. To confirm this, let's change directory into the ansible repo `Ansible-Deploy-P19` and run our Ansible-playbook command as usual, we will encounter error.


<img width="694" alt="Ansible error" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/1822526d-a2cd-498b-90ea-a1fa51845a8d">


- Run the below command to solve this error

```
sudo yum install python3.8
sudo alternatives --config python3
```

- Then uninstall the ansible

```
sudo yum remove ansible
sudo yum purge ansible
```

- Then reinstall ansible using `sudo python3 -m pip install --user ansible` Confirm using `ansible --version | grep "python version"`

- Now install boto3 using `python -m pip install boto3`

- Now we can run our ansible-playbook using `ansible-playbook -i inventory/aws_ec2.yml playbooks/sites.yml`


<img width="781" alt="ANSIBLE NGINX" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/d5206555-e080-40b4-9622-3c3020c760e4">

<img width="816" alt="ANSIBLE TOOLING" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/2015cc13-933e-4aa3-aa52-af69cb8e2fd6">

<img width="816" alt="ANSIBLE WORDPRESS" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/a2e936be-f817-477f-a5d9-26fe04408697">


- Time to check if configuration with ansible works

- `ssh nginx`. Check if the server is up and running using `sudo systemctl status nginx`


<img width="678" alt="nginx is installed" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/93e732d3-1d19-4029-b070-81e125554f91">


`curl localhost`

<img width="789" alt="NGINX WELL CONFIGURED" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/84a9e594-18d4-4496-a4b6-932aef079489">


- `ssh tooling`. Check if the server is up and running using `sudo systemctl status httpd`


<img width="725" alt="Tooling well mounted, installed and running" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/cdf76abb-2c26-4634-86e4-8ffc64dee4fb">


`curl localhost`

<img width="781" alt="tooling webserver running" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/89d861d1-0a5b-4039-836e-572976147ea6">


- `ssh wordpress`. Check if the server is up and running using `sudo systemctl status httpd`


<img width="666" alt="Wordpress mounted,installed and running" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/b6285e8f-4403-4839-811f-650909aee7d0">


`curl localhost`

<img width="663" alt="wordpress webserver error" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/8d3467bf-16d9-498d-a51a-cb00703ffbb7">

<img width="677" alt="inside wp-config php file" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/dd336d46-4f5f-44f6-8f13-45e79118e9a5">


- **Issue resolved**
  
<img width="418" alt="wordpress webserver fixed" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/5302407b-95d4-4fde-9daa-dd7977c340c0">


- Now, we are sure our proxy server will be able to successfully route traffic to the wordpress and tooling servers, since we can confirm that they are healthy.

- Next step is to go back to the terraform infrastructure and **uncomment the listeners and attachment group** we commented out, then push the code back to github, so our terraform-cloud can run `plan` and `apply`.

<img width="697" alt="running the uncommented" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/734ed2ce-ee92-4bd6-b2f7-a2f7c7605423">

- Back to our AWS Console to confirm the last operation.

<img width="930" alt="NGINX LISTENERS ADD TO EXT-ALB" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/ab7671ba-2d53-4fce-ab09-3623a7b9dbad">

<img width="779" alt="nginx healthy" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/387267f1-e3d0-47f3-b521-0bcd92c3b44c">

<img width="925" alt="WORDPRESS ADDED TO INT-ALB" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/fae25f89-5cd0-4c03-ae41-684b884fc1d5">

<img width="777" alt="wordpress healthy" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/c814db14-ff96-42e6-81e5-b9a13307293c">

<img width="782" alt="tooling healthy" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/cd8b83f5-a50a-4976-86a2-64ebd2996a60">



- It has been confirmed that all of our target group instances are healthy, and ready to receive traffic.

- Let's access our applications from the browser through the domain name.


<img width="660" alt="tooling site" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/e86c4b6c-945b-4aa1-99fe-01c78da6e3f1">

<img width="327" alt="wordpress site" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/9c097c2b-0d99-492e-91bb-22901e65a1bb">


- In order to save cost, I destroy the resources as we come to the end of this project.

<img width="619" alt="resources destroyed" src="https://github.com/eyolegoo/PROJECT-19/assets/115954100/65a84860-5b34-4067-819c-6099259c1987">



