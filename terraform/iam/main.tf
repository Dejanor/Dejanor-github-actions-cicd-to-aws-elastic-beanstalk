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

resource "aws_iam_role_policy_attachment" "ec2_web_tier" {
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
  role       = aws_iam_role.ec2_role.name
}

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

resource "aws_iam_policy" "eb_auto_scaling_policy" {
  name        = "eb-auto-scaling-policy"
  path        = "/"
  description = "Auto Scaling policy for Elastic Beanstalk"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeScalingActivities",
          "autoscaling:PutScalingPolicy",
          "autoscaling:DeleteScalingPolicy",
          "autoscaling:UpdateAutoScalingGroup"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eb_service_auto_scaling" {
  policy_arn = aws_iam_policy.eb_auto_scaling_policy.arn
  role       = aws_iam_role.service_role.name
}

resource "aws_iam_role_policy_attachment" "eb_service_health" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
  role       = aws_iam_role.service_role.name
}

resource "aws_iam_role_policy_attachment" "eb_service_general" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
  role       = aws_iam_role.service_role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}

output "service_role_name" {
  value = aws_iam_role.service_role.name
}
