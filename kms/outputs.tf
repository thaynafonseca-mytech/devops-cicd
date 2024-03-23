## Output --> kEY KMS

#Retorna o nome de recurso da Amazon (ARN) da chave.
output "arn_key" {
  value = aws_kms_key.kms_key.arn
}

#Retorna o identificador globalmente exclusivo da chave.
output "key_id" {
  value = aws_kms_key.kms_key.key_id
}
