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
  default = "remote-terraform-state-dejanor"
  
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "eb-application" {
  type    = map
  default = {
    name        = "laravel-realworld-example-app"
    description = "laravel-realworld-example-app"
  }
}

variable "eb-environment-name" {
  type    = string
  default = "laravel-environment"
}

variable "eb-staging-environment-name" {
  type    = string
  default = "laravel-staging-environment"
}
