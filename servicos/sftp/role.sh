#!/bin/bash


# Política da role (em formato JSON)
ROLE_POLICY='{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "transfer.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'


#role name
ROLE_NAME="$1"
# Perfil da AWS (opcional)
PROFILE="$2"

# Comando da AWS CLI para criar ou atualizar a role
aws iam create-role --role-name "$ROLE_NAME" --assume-role-policy-document "$ROLE_POLICY" ${PROFILE+--profile "$PROFILE"} || \
aws iam update-assume-role-policy --role-name "$ROLE_NAME" --policy-document "$ROLE_POLICY" ${PROFILE+--profile "$PROFILE"}

echo "Role '$ROLE_NAME' criada/atualizada com sucesso!"
