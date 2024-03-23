# AWS - KMS
variable "description" {
  type        = string
  description = "Descrição da key"
}

variable "type_kms_key" {
  type        = string
  description = "Definindo type da key. Para uma key do tipo symmetric: SYMMETRIC_DEFAULT / Para uma key do tipo asymmetric: RSA_2048"
}

variable "usage_kms_key" {
  type        = string
  description = "Definindo finalidade da key kms"
} 

variable "multi_region" {
  type        = string
  description = "Definindo se é multi region"
}

variable "alias" {
  type        = string
  description = "Definindo nome da key"
}