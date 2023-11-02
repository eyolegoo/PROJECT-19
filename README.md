# PROJECT-19
AUTOMATE INFRASTRUCTURE WITH IAC USING TERRAFORM. PART 4 – TERRAFORM CLOUD


- In previous project, we explored **AWS S3 backend** as the remote backend to store Terraform state files and refactored our terraform codes into modules and as a result the introduction of modules into our codebase it saved us time and reduce costly errors by re-using configuration written either by yourself, other members of your team, or other Terraform practitioners who have published modules for you to use


![architecture](https://github.com/eyolegoo/PROJECT-19/assets/115954100/99282ce5-3401-4e21-8885-0c30074e0eb1)


- For this project we are going to explore another option, which is the `terraform cloud`. We will also use `Packer` to build our machine images, and `Ansible` to configure the infrastructure.

- Before you proceed ensure you have the following tools installed on your local machine;

    - Packer. Follow this link to install [Packer]

    - Ansible. Follow this link to install Ansible

    - AWS CLI. Follow sthis link to configure AWS CLI
