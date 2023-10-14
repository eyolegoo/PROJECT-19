region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnet = 2

preferred_number_of_private_subnet = 4

ami = "ami-0149b2da6ceec4bb0"

ami-bastion = "ami-09f2ca3030fbea67a"

ami-nginx = "ami-08afa1d66ef286f9f"

ami-sonar = "ami-0e64aeb60976de56b"

ami-web = "ami-0ad59f057a9823709"

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

