#!/bin/bash

# Configurações (substitua pelos seus valores)
PROFILE="$4"  # Perfil da AWS CLI
REGION="us-east-1"   # Região da AWS (ex: us-east-1)
DOMAIN="server.transfer.us-east-1.amazonaws.com"      # Domínio para o SFTP (ex: sftp.seudominio.com)
USERNAME="$1"    # Nome de usuário SFTP
SSH_PUBLIC_KEY=""  # Caminho para sua chave pública SSH

#ROLE_NAME="$2" # Substitua pelo nome da sua role

HOME_DIR="$3"

#ROLE_INFO=$(aws iam get-role --role-name "$ROLE_NAME")
ROLE_ARN="$2"

echo "$ROLE_INFO"  # Imprime a saída completa do comando

# Criar o SFTP Transfer Family
#FAMILY_ID=$(aws transfer create-server --endpoint-type VPC_ENDPOINT --identity-provider-type SERVICE_MANAGED --domain "$DOMAIN" --endpoint-details AddressAllocationIds=eipalloc-xxxxxxxxxxxxxxxxx --profile "$PROFILE" --region "$REGION" --query ServerId --output text)

FAMILY_ID=""
# Criar o usuário SFTP
if [-n "$FAMILY_ID"]; then
	aws transfer create-user --server-id "$FAMILY_ID" \
	       	--user-name "$USERNAME" --role "$ROLE_ARN" \
		--ssh-public-key "$SSH_PUBLIC_KEY" --profile \
		"$PROFILE" --region "$REGION" \
		--home-directory "$HOME_DIR" 

# Criar o servidor virtual SFTP (VSF)
#VSF_ID=$(aws transfer create-access --server-id "$FAMILY_ID" --external-id "VSF-1" --home-directory "/sftp_root" --role "arn:aws:iam::xxxxxxxxxxxx:role/sua_funcao_iam_para_transfer" --profile "$PROFILE" --region "$REGION" --query AccessId --output text)

#echo "SFTP Transfer Family criado com sucesso:"
echo "  Family ID: $FAMILY_ID"
#echo "  VSF ID: $VSF_ID"
echo "  Endpoint: sftp://$FAMILY_ID.$DOMAIN"
