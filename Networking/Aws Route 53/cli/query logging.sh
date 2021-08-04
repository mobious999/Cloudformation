#!/bin/bash 

echo "Creating Route53 Query Logging 'Dns Query Logging'"
queryLoggingConfigId=$(aws route53resolver create-resolver-query-log-config \
 --name "Dns Query Logging" \
 --destination-arn "change me to the real arn of the logging destination" --query "ResolverQueryLogConfig.Id" --output=text)

aws route53resolver associate-resolver-query-log-config \
 --resolver-query-log-config-id $queryLoggingConfigId \
 --resource-id "change to vpc id or input from template"