#!/bin/bash

STACK_NAME=awsbootstrap
REGION=us-west-1
CLI_PROFILE=awsbootstrap
EC2_INSTANCE_TYPE=t2.micro
CFN_TEMPLATE=main.yml

# Deploy the CloudFormation template
echo -e "\n\n=========== Deploying $CFN_TEMPLATE ==========="

aws cloudformation deploy \
    --region $REGION \
    --profile $CLI_PROFILE \
    --stack-name $STACK_NAME \
    --template-file $CFN_TEMPLATE \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        EC2InstanceType=$EC2_INSTANCE_TYPE

if [ $? -eq 0 ]; then
    aws cloudformation list-exports \
        --profile awsbootstrap \
        --query "Exports[?Name=='InstanceEndpoint'].Value"
fi
