#!/bin/bash 

aws iam create-role --role-name "Ec2RoleForSSM" \
--assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            },
            "Action": [
                "sts:AssumeRole"
            ]
        }
    ]
}' \
 --region "us-east-2"
aws iam attach-role-policy --role-name "Ec2RoleForSSM" \
 --policy-arn "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" \
 --region "us-east-2"
aws iam attach-role-policy --role-name "Ec2RoleForSSM" \
 --policy-arn "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" \
 --region "us-east-2"
aws iam attach-role-policy --role-name "Ec2RoleForSSM" \
 --policy-arn "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess" \
 --region "us-east-2"
aws iam put-role-policy --role-name "Ec2RoleForSSM" \
 --policy-name "AllowAccessToS3" \
 --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": "arn:aws:s3:::*/*"
        }
    ]
}' \
 --region "us-east-2"
aws iam put-role-policy --role-name "Ec2RoleForSSM" \
 --policy-name "AllowAccessToVpcEndpoints" \
 --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::aws-ssm-us-east-2/*",
                "arn:aws:s3:::aws-windows-downloads-us-east-2/*",
                "arn:aws:s3:::amazon-ssm-us-east-2/*",
                "arn:aws:s3:::amazon-ssm-packages-us-east-2/*",
                "arn:aws:s3:::us-east-2-birdwatcher-prod/*",
                "arn:aws:s3:::patch-baseline-snapshot-us-east-2/*"
            ]
        }
    ]
}' \
 --region "us-east-2"
aws iam create-instance-profile --instance-profile-name "Ec2RoleForSSM" \
 --region "us-east-2"
aws iam add-role-to-instance-profile --instance-profile-name "Ec2RoleForSSM" --role-name "Ec2RoleForSSM" \
 --region "us-east-2"