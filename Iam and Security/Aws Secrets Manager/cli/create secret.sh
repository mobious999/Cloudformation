#!/bin/bash 

randomPassword=$(aws secretsmanager get-random-password --password-length 32 \
 --no-exclude-lowercase  \
 --no-exclude-uppercase  \
 --no-exclude-numbers  \
 --no-exclude-punctuation  --query "RandomPassword" --output=text)

aws secretsmanager create-secret --name "example secret" \
 --description "example description" \
 --kms-key-id "alias/aws/secretsmanager" \
 --secret-string $randomPassword \
 --region "us-east-2"