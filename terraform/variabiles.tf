variable "bucket_name" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "enable_network_policy" {
  type    = bool
  default = true
}