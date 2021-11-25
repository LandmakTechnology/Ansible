## **Ansible Vault**
- If your Ansible playbooks deal with sensitive data like passwords, API keys, and credentials, it is important to keep that data safe by using an encryption mechanism. Ansible provides ansible-vault to encrypt files and variables.
- Even though it is possible to encrypt any Ansible data file as well as binary files, it is more common to use ansible-vault to encrypt variable files containing sensitive data. After encrypting a file with this tool, you will only be able to execute, edit or view its contents by providing the relevant password defined when you first encrypted the file.

# Creating a New Encrypted File
You can create a new encrypted Ansible file with:

**$ ansible-vault create credentials.yml**

This command will perform the following actions:

•	First, it will prompt you to enter a new password. You’ll need to provide this password whenever you access the file contents, whether it’s for editing, viewing, or just running playbooks or commands using those values.
•	Next, it will open your default command-line editor so you can populate the file with the desired contents.
•	Finally, when you’re done editing, ansible-vault will save the file as encrypted data.

# Encrypting an Existing Ansible File
- To encrypt an existing Ansible file, you can use the following syntax:

**$ ansible-vault encrypt credentials.yml**

This will prompt you for a password that you’ll need to enter whenever you access the file credentials.yml.

# Viewing the Contents of an Encrypted File
If you want to view the contents of a file that was previously encrypted with ansible-vault and you don’t need to change its contents, you can use:

**$ ansible-vault view credentials.yml**

This will prompt you to provide the password you selected when you first encrypted the file with ansible-vault.

# Editing an Encrypted File
To edit the contents of a file that was previously encrypted with Ansible Vault, run:
**$ ansible-vault edit credentials.yml**

- This will prompt you to provide the password you chose when first encrypting the file credentials.yml with ansible-vault. After password validation, your default command-line editor will open with the unencrypted contents of the file, allowing you to make your changes.
-  When finished, you can save and close the file as you would normally, and the updated contents will be saved as encrypted data.

# Decrypting Encrypted Files
If you wish to permanently revert a file that was previously encrypted with ansible-vault to its unencrypted version, you can do so with this syntax:
**$ ansible-vault decrypt credentials.yml**

- This will prompt you to provide the same password used when first encrypting the file credentials.yml with ansible-vault. After password validation, the file contents will be saved to the disk as unencrypted data.

# Using Multiple Vault Passwords
- Ansible supports multiple vault passwords grouped by different vault IDs. This is useful if you want to have dedicated vault passwords for different environments, such as development, testing, and production environments.
- To create a new encrypted file using a custom vault ID, include the --vault-id option along with a label and the location where ansible-vault can find the password for that vault. The label can be any identifier, and the location can either be prompt, meaning that the command should prompt you to enter a password, or a valid path to a password file.
**$ ansible-vault create --vault-id dev@prompt credentials_dev.yml**

- This will create a new vault ID named dev that uses prompt as password source. By combining this method with group variable files, you’ll be able to have separate ansible vaults for each application environment:
**$ ansible-vault create --vault-id prod@prompt credentials_prod.yml**


- We used dev and prod as vault IDs to demonstrate how you can create separate vaults per environment, but you can create as many vaults as you want, and you can use any identifier of your choice as vault ID.
Now to view, edit, or decrypt these files, you’ll need to provide the same vault ID and password source along with the ansible-vault command:
**$ ansible-vault edit credentials_dev.yml --vault-id dev@prompt**


# Using a Password File
- If you need to automate the process of provisioning servers with Ansible using a third-party tool, you’ll need a way to provide the vault password without being prompted for it. You can do that by using a password file with ansible-vault.
- A password file can be a plain text file or an executable script. If the file is an executable script, the output produced by this script will be used as the vault password. Otherwise, the raw contents of the file will be used as vault password.
- To use a password file with ansible-vault, you need to provide the path to a password file when running any of the vault commands:
**$ ansible-vault create --vault-id dev@path/to/passfile credentials_dev.yml**

# Running a Playbook with Data Encrypted via Ansible Vault
- Whenever you run a playbook that uses data previously encrypted via ansible-vault, you’ll need to provide the vault password to your playbook command.
- If you used default options and the prompt password source when encrypting the data used in this playbook, you can use the option --ask-vault-pass to make Ansible prompt you for the password:
**$ ansible-playbook myplaybook.yml --ask-vault-pass**

- If you used a password file instead of prompting for the password, you should use the option --vault-password-file instead:
**$ ansible-playbook myplaybook.yml --vault-password-file my_vault_password.py**

- If you’re using data encrypted under a vault ID, you’ll need to provide the same vault ID and password source you used when first encrypting the data:
**$ ansible-playbook myplaybook.yml --vault-id dev@prompt**

- If using a password file with your vault ID, you should provide the label followed by the full path to the password file as password source:
**$ ansible-playbook myplaybook.yml --vault-id dev@vault_password.py**

- If your play uses multiple vaults, you should provide a --vault-id parameter for each of them, in no particular order:
**$ ansible-playbook myplaybook.yml --vault-id dev@vault_password.py --vault-id test@prompt --vault-id ci@prompt**
