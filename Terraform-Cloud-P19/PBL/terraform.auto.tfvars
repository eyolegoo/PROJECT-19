region = "us-east-2"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnet = 2

preferred_number_of_private_subnet = 4

ami = "ami-0149b2da6ceec4bb0"

ami-bastion = "ami-037e401ce6c751446"

ami-nginx = "ami-04cc008450224bc8d"

ami-sonar = "ami-061da076c0bf9f5ba"

ami-web = "ami-0bfc24c427814a85b"

keypair = "IAC"

account_no = "648544004274"

db-username = "lego"

db-password = "1godwynE"

tags = {
  Enviroment      = "production"
  Owner-Email     = "eyolegoo@gmail.com"
  Managed-By      = "terraform"
  Billing-Account = "648544004274"
}

