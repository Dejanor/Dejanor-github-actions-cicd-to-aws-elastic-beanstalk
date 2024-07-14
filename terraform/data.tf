
# Retrieve the VPC ID
data "aws_vpc" "default" {
    id = "vpc-08271cafeed9799a1"
}

# Retrieve the subnet IDs within the VPC
data "aws_subnet" "default" {
    vpc_id = data.aws_vpc.default.id
    availability_zone = "eu-west-2b"
}

data "aws_iam_instance_profile" "default" {
    name = "aws-elasticbeanstalk-ec2-role"
}

data "aws_iam_role" "default" {
    name = "aws-elasticbeanstalk-service-role-2"
}


