#!/bin/bash


# base Policy ( JSON format) with the placeholders to substituição
POLICY_JSON='{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::BUCKET_NAME"
            ],
            "Effect": "Allow",
            "Sid": "ReadWriteS3"
        },
        {
            "Action": [
                "s3:Putobject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:DeleteObjectVersion",
                "s3:GetObjectVersion",
                "s3:GetObjectACL",
                "s3:PutObjectACL"

            ],
            "Resource": [
                "arn:aws:s3:::BUCKET_NAME/sftp/*"
            ],
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}'

#########

# get the bucket name as argument
if [ $# -eq 0 ]; then
  echo "Please, provide the bucket name as an argument."
  exit 1
fi
#bucket name
BUCKET_NAME="$1"
#policy name
POLICY_NAME="$2"
# Role name
ROLE_NAME="$3"

# change the placeholders buy the bucket name
POLICY_JSON=$(echo "$POLICY_JSON" | sed "s/BUCKET_NAME/$BUCKET_NAME/g")

# Perfil da AWS (opcional)
PROFILE="$4"

# Created or updated the policy. 
aws iam create-policy --policy-name "$POLICY_NAME" --policy-document "$POLICY_JSON" ${PROFILE+--profile "$PROFILE"} || \
aws iam update-policy --policy-arn "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/$POLICY_NAME" --policy-document "$POLICY_JSON" ${PROFILE+--profile "$PROFILE"}

echo "Policy '$POLICY_NAME' successfully created and updated for bucket '$BUCKET_NAME'!"


aws iam attach-role-policy --policy-arn "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/$POLICY_NAME" --role-name "$ROLE_NAME" ${PROFILE+--profile "$PROFILE"}

echo "Policy '$POLICY_NAME' successfully attached to the role '$ROLE_NAME'"

