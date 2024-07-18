variable "db_name" {}
variable "username" {}
variable "password" {}
variable "db_security_group" {}
variable "subnet_ids" {
  type = list(string)
}
