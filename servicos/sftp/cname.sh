#!/bin/bash

# ... (configurações e criação do SFTP, como no script anterior)

# Obter o endpoint do SFTP
ENDPOINT=$(aws transfer describe-server --server-id "$FAMILY_ID" --profile "$PROFILE" --region "$REGION" --query EndpointDetails.AddressAllocationId --output text)
ENDPOINT="sftp://$DOMAIN"  # Formate o endpoint corretamente


# Criar o CNAME no Route 53 (substitua pelos seus valores)
HOSTED_ZONE_ID="seu_id_da_zona_hospedada"    # ID da sua zona hospedada no Route 53
RECORD_NAME="seu_subdominio"               # Subdomínio desejado (ex: sftp)

aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --change-batch '{
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name":   
 "'"$RECORD_NAME.$DOMAIN"'",
        "Type": "CNAME",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "'"$ENDPOINT"'"
          }
        ]
      }
    }
  ]
}' --profile "$PROFILE"

echo "CNAME criado no Route 53:"
echo "  Name: $RECORD_NAME.$DOMAIN"
echo "  Value: $ENDPOINT"
