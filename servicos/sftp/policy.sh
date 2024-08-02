#!/bin/bash


# Política base (em formato JSON) com placeholders para substituição
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

# Obtém o nome do bucket como argumento
if [ $# -eq 0 ]; then
  echo "Por favor, forneça o nome do bucket como argumento."
  exit 1
fi
#nome do bucket
BUCKET_NAME="$1"
#nome da politica
POLICY_NAME="$2"
# nome da Role
ROLE_NAME="$3"

# Substitui os placeholders pelo nome do bucket
POLICY_JSON=$(echo "$POLICY_JSON" | sed "s/BUCKET_NAME/$BUCKET_NAME/g")

# Perfil da AWS (opcional)
PROFILE="$4"

# Cria ou atualiza a política
aws iam create-policy --policy-name "$POLICY_NAME" --policy-document "$POLICY_JSON" ${PROFILE+--profile "$PROFILE"} || \
aws iam update-policy --policy-arn "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/$POLICY_NAME" --policy-document "$POLICY_JSON" ${PROFILE+--profile "$PROFILE"}

echo "Política '$POLICY_NAME' criada/atualizada com sucesso para o bucket '$BUCKET_NAME'!"


aws iam attach-role-policy --policy-arn "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/$POLICY_NAME" --role-name "$ROLE_NAME" ${PROFILE+--profile "$PROFILE"}

echo "Política '$POLICY_NAME' anexada à role '$ROLE_NAME' com sucesso!"

