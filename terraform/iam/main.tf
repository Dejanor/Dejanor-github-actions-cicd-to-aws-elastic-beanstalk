# iam/main.tf
resource "aws_iam_role" "ec2_role" {
  name = "aws-elasticbeanstalk-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# ... (rest of the IAM role and policy attachment code)

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "service_role" {
  name = "aws-elasticbeanstalk-service-role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}

# ... (rest of the service role code)

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}

output "service_role_name" {
  value = aws_iam_role.service_role.name
}
