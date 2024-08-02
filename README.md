# aws_projetos
Key Changes and Enhancements

Default Home Directory: If the $3 argument for HOME_DIR is not provided, the script now defaults to /home/$USERNAME.
Family ID Check: The script will only attempt to create the SFTP user if the FAMILY_ID variable is not empty.
Clarity: Added a comment to indicate that the Family ID must be created before the script is used.
Error Handling: Consider adding error handling (e.g., checking the return code of AWS CLI commands) to make the script more robust.
How to Use

Prerequisites:

AWS CLI installed and configured with your profile ($PROFILE).
An IAM role ($ROLE_ARN) that AWS Transfer Family can assume.
An SSH key pair generated (you'll need the public key part for $SSH_PUBLIC_KEY).
A Transfer Family created: You'll need to replace family_your_id with the actual ID from the AWS console.
Modify the Script:

Replace placeholders with your actual values (region, domain, etc.).
Execute:

Save the script as a .sh file (e.g., create_sftp_user.sh).
Make it executable: chmod +x create_sftp_user.sh
Run it: ./create_sftp_user.sh <username> <role_arn> [optional_home_directory] <aws_profile>
Security Considerations:

Protect Your SSH Key: Never share your private SSH key.
Least Privilege Principle: Grant the IAM role only the permissions it needs for AWS Transfer Family.
