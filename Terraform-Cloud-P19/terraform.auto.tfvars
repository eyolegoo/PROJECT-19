region = "us-east-1"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

preferred_number_of_public_subnet = 2

preferred_number_of_private_subnet = 4

ami-jenkins = "ami-0149b2da6ceec4bb0"

ami-jfrog = "ami-0149b2da6ceec4bb0"

ami-bastion = "ami-03b474e350c60d159"

ami-nginx = "ami-0b08da916d4fc9fe1"

ami-sonar = "ami-0647be5cb281201a7"

ami-web = "ami-02558a646694a4310"

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
