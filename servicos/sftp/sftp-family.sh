#!/bin/bash

# Configurações (substitua pelos seus valores)
PROFILE="$4"  # Perfil da AWS CLI
REGION="us-east-1"   # Região da AWS (ex: us-east-1)
DOMAIN="server.transfer.us-east-1.amazonaws.com"      # Domínio para o SFTP (ex: sftp.seudominio.com)
USERNAME="$1"    # Nome de usuário SFTP
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDd2tHjLzCXrKwvmExDzsG7MtCctnzUNTdlNBTkQ2RXix9hUkIVN8h8teZ4kS+Xyurt/DHioKvAszQQr+kbPcY1wkD6ysxETsgYx/2y1RViemHknuR8fZvhdVGgBKmVHuB48msKlYJKgb+RKdFMv9/XRhlwYNRldkPfH8/WZwEm/k5D/sdq/fKYnIdK2bm1fHIjqlRKEKfNWWKrIyT4Vp1UdQn/kffJl9DvvotRmUXKUE7sHDOEf/mbA+6k6IRru1KIqaZ7xLukzzwiKWg61iN9bsR/igOJ8b0ckYThkzJY82lIMCniMnV7RQz2KnCYiVl79EnvJp6VhrH1+mFFJHnxLd/AI5eLcsXmr7Af6fnuCZt2MXp1BuEnfk9+HXhW2zJPQF8n575rzqCAHY0JUxNmjb1c1ruGK+UNTfJwipu7WdAAOWdldyGjoGNa8xWxrGLiliICF+kZ8akUb4n9Ok5XmJVfZ2bAJbCxBTGwut5zS8Wdm82hkV/KzrGG9GwyEAevqBPLb2m0ADVBjDv66BzPsLZYGn0gG4xGKMxgXaUjOOZ8QyvgE1TRFbaRVI2+j3sKLmeNJWAc2JJo5ytID1tGNahMOCyqq0WwHXwiLJSKL5OCVk3QJUXD3xjfwyNoIAeCxuc2AHBCiwmVJ76Bt5K2+52YGeoEnOFre0NLXh9VnQ== domrock@DESKTOP-4BDPOC8"  # Caminho para sua chave pública SSH

#ROLE_NAME="$2" # Substitua pelo nome da sua role

HOME_DIR="$3"

#ROLE_INFO=$(aws iam get-role --role-name "$ROLE_NAME")
ROLE_ARN="$2"

echo "$ROLE_INFO"  # Imprime a saída completa do comando

# Criar o SFTP Transfer Family
#FAMILY_ID=$(aws transfer create-server --endpoint-type VPC_ENDPOINT --identity-provider-type SERVICE_MANAGED --domain "$DOMAIN" --endpoint-details AddressAllocationIds=eipalloc-xxxxxxxxxxxxxxxxx --profile "$PROFILE" --region "$REGION" --query ServerId --output text)

FAMILY_ID="s-f569088189274c3d9"
# Criar o usuário SFTP
aws transfer create-user --server-id "$FAMILY_ID" --user-name "$USERNAME" --role "$ROLE_ARN" --ssh-public-key "$SSH_PUBLIC_KEY" --profile "$PROFILE" --region "$REGION" --home-directory "$HOME_DIR" 

# Criar o servidor virtual SFTP (VSF)
#VSF_ID=$(aws transfer create-access --server-id "$FAMILY_ID" --external-id "VSF-1" --home-directory "/sftp_root" --role "arn:aws:iam::xxxxxxxxxxxx:role/sua_funcao_iam_para_transfer" --profile "$PROFILE" --region "$REGION" --query AccessId --output text)

#echo "SFTP Transfer Family criado com sucesso:"
echo "  Family ID: $FAMILY_ID"
#echo "  VSF ID: $VSF_ID"
echo "  Endpoint: sftp://$FAMILY_ID.$DOMAIN"
