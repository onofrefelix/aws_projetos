# aws_projetos
# AWS SFTP User Creation Script

This Bash script simplifies creating SFTP users, policies and roles, for the AWS Transfer Family.

## Key Changes and Enhancements

* **Default Home Directory:** If no home directory (`$3`) is specified, the script defaults to `/home/$USERNAME`.
* **Family ID Check:** The script only creates the SFTP user if a valid `FAMILY_ID` is provided.
* **Clarity:** Added a comment highlighting the need to create the Transfer Family before using the script.
* **Error Handling:** Consider adding error handling for AWS CLI commands to improve robustness.

## How to Use

**Prerequisites:**

1. **AWS CLI:** Installed and configured with your profile (`$PROFILE`).
2. **IAM Role:** A role (`$ROLE_ARN`) that AWS Transfer Family can assume.
3. **SSH Key Pair:** Generate an SSH key pair (you'll use the public key for `$SSH_PUBLIC_KEY`).
4. **Transfer Family:** Create a Transfer Family and replace `family_your_id` with the actual ID.

**Steps:**

1. **Modify the Script:** Replace the placeholders with your actual values (region, domain, etc.).
2. **Execute:**
   - Save the script as `create_sftp_user.sh`.
   - Make it executable: `chmod +x create_sftp_user.sh`
   - Run: `./create_sftp_user.sh <username> <role_arn> [optional_home_directory] <aws_profile>`

## Security Considerations

* **Protect Your SSH Key:**  Never share your private SSH key.
* **Least Privilege Principle:** Only grant the IAM role the necessary permissions for AWS Transfer Family.
