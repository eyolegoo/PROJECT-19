region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnet = 2

preferred_number_of_private_subnet = 4

ami = "ami-0149b2da6ceec4bb0"

ami-bastion = "ami-0ade15728b4d74c05"

ami-nginx = "ami-0d49a462efaa122bb"

ami-sonar = "ami-0f08acaf0ff039020"

ami-web = "ami-03894188eb54f6ec0"

keypair = "DevKey"

account_no = "648544004274"

db-username = "lego"

db-password = "1godwynE"

tags = {
  Enviroment      = "production"
  Owner-Email     = "eyolegoo@gmail.com"
  Managed-By      = "terraform"
  Billing-Account = "648544004274"
}

