# creating dynamic ingress security groups
locals {
  security_groups = {
    ext-alb-sg = {
      name        = "ext-alb-sg"
      description = "security group for external loadbalncer"
    }

    # security group for bastion
    bastion-sg = {
      name        = "bastion-sg"
      description = "allow access from work station"
    }

    # security group for nginx
    nginx-sg = {
      name        = "nginx-sg"
      description = "allow access from ext-alb and bastion"
    }

    # security group for IALB
    int-alb-sg = {
      name        = "int-alb-sg"
      description = "allow acces from nginx proxy servers"
    }

    # security group for webservers
    webserver-sg = {
      name        = "webserver-sg"
      description = "allow acces from internal load balancer and bastion instance"
    }

    # security group for data-layer
    datalayer-sg = {
      name        = "datalayer-sg"
      description = "allow traffic from websever on nfs port and mysql port and bastion host on mysql port"
    }
  }
}
