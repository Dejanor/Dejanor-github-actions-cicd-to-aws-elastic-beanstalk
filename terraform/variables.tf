variable "kms_master_key_id" {
  default = ""
}

variable "read_capacity" {
  type    = number
  default = 1
}

variable "write_capacity" {
  type    = number
  default = 1
}

variable "aws_dynamodb_table_enabled" {
  type    = bool
  default = true
}

variable "backend_bucket_name" {
  default = "winich-devops"
  
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "eb-application" {
  type    = map
  default = {
    name        = "winichwebsite"
    description = "winichwebsite application"
  }
}

variable "eb-environment-name" {
  type    = string
  default = "winichwebsite-environment"
}

variable "eb-staging-environment-name" {
  type    = string
  default = "winichwebsite-staging-environment"
}