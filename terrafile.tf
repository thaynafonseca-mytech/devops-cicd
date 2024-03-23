terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.69, < 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" #Virginia
}

module "kms_key" {
    source                 = "./kms"

    description            = "Criando a KMS key"

   #Definindo de key é do tipo symmetric ou asymmetric
    type_kms_key           = "SYMMETRIC_DEFAULT"

   #Definindo o modelo uso da key
    usage_kms_key          = "ENCRYPT_DECRYPT"

    multi_region           = "false"

    alias                  = "alias/p2f_kms_key"
  
}