#!/bin/bash
set -e

COMMAND_ID=$(aws ssm send-command \
  --instance-ids "$INSTANCE_ID" \
  --document-name "AWS-RunShellScript" \
  --comment "Deploy $ENVIRONMENT" \
  --parameters "{\"commands\":[
    \"aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com\",
    \"cd /home/ec2-user/app && docker compose pull\",
    \"cd /home/ec2-user/app && docker compose up -d --remove-orphans\"
  ]}" \
  --region "$REGION" \
  --query "Command.CommandId" \
  --output text)

echo "SSM Command ID: $COMMAND_ID"

aws ssm wait command-executed \
  --command-id "$COMMAND_ID" \
  --instance-id "$INSTANCE_ID" \
  --region "$REGION"

STATUS=$(aws ssm get-command-invocation \
  --command-id "$COMMAND_ID" \
  --instance-id "$INSTANCE_ID" \
  --region "$REGION" \
  --query "Status" \
  --output text)

echo "Status: $STATUS"

if [ "$STATUS" != "Success" ]; then
  aws ssm get-command-invocation \
    --command-id "$COMMAND_ID" \
    --instance-id "$INSTANCE_ID" \
    --region "$REGION" \
    --query "StandardErrorContent" \
    --output text
  exit 1
fi