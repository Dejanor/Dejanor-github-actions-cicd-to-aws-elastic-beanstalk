module "vpc" {
  source = "./vpc"
}

module "iam" {
  source = "./iam"
}

resource "aws_elastic_beanstalk_application" "application" {
  name        = var.eb-application.name
  description = var.eb-application.description
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = var.eb-environment-name
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.1.1 running Docker"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = module.vpc.subnet_id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = module.iam.instance_profile_name
  }
}

resource "aws_elastic_beanstalk_environment" "staging-environment" {
  name                = var.eb-staging-environment-name
  application         = aws_elastic_beanstalk_application.application.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.1.1 running Docker"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = module.vpc.subnet_id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = module.iam.instance_profile_name
  }
}
