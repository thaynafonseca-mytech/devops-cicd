#Criando KMS.
resource "aws_kms_key" "kms_key" {
  description                 = var.description
  customer_master_key_spec    = var.type_kms_key
  key_usage                   = var.usage_kms_key
  multi_region                = var.multi_region
}

#Nomenado a key.
resource "aws_kms_alias" "this" {
  name                        = var.alias
  target_key_id               = aws_kms_key.kms_key.arn
}
