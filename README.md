#### Install Terraform :
Ensure Terraform is installed on your machine. If it's not installed yet, you can follow the official installation guide.

### AWS IAM Setup for Terraform

Before you start using Terraform with AWS, it's crucial to set up a dedicated IAM user with the necessary permissions. This ensures security and proper access management.

#### Step 1: Create an IAM User for Terraform

1. **Log in to the AWS Management Console**:
   - Navigate to the [IAM Console](https://console.aws.amazon.com/iam/).

2. **Create a New IAM User**:
   - Click on **Users** in the left-hand menu, then click **Add users**.
   - **User name**: Enter a name like `terraform-user`.
   - **Access type**: Select **Programmatic access**. This will generate an access key ID and secret access key.

3. **Set Permissions**:
   - On the "Set permissions" page, select **Attach existing policies directly**.
   - Search for the **AdministratorAccess** policy and attach it. This policy provides full access to AWS services. For more restrictive access, you can create a custom policy.

4. **Review and Create**:
   - Review your settings, then click **Create user**.
   - **Download the `.csv` file** with the new user's credentials or copy the access key ID and secret access key to a secure location. You'll need these for configuring Terraform.

### Configuring AWS Access for Terraform

You can configure AWS access for Terraform using either the AWS credentials file or environment variables.

#### Method 1: Using the AWS Credentials File

1. **Set Up the Credentials File**:
   - On Linux, macOS, or Unix, the file is located at `~/.aws/credentials`.
   - On Windows, the file is located at `C:\Users\USERNAME\.aws\credentials`.

2. **Edit the Credentials File**:
   Add the following lines, replacing `<your_access_key_id>` and `<your_secret_access_key>` with the values obtained when you created the IAM user:

   ```ini
   [default]
   aws_access_key_id = <your_access_key_id>
   aws_secret_access_key = <your_secret_access_key>
   ```

#### Method 2: Using Environment Variables

Alternatively, you can set the AWS credentials as environment variables:

1. **On Linux, macOS, or Unix**:
   ```bash
   export AWS_ACCESS_KEY_ID=<your_access_key_id>
   export AWS_SECRET_ACCESS_KEY=<your_secret_access_key>
   ```

2. **On Windows**:
   ```bash
   set AWS_ACCESS_KEY_ID=<your_access_key_id>
   set AWS_SECRET_ACCESS_KEY=<your_secret_access_key>
   ```

### "Hello, World" Terraform Example on AWS

Now that your AWS access is configured, you can proceed with deploying an EC2 instance using Terraform.

#### Step 1: Install Terraform

Make sure Terraform is installed on your machine. Follow the [installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) if needed.

#### Step 2: Create the `main.tf` File

Create a directory for your project and create a `main.tf` file inside it:

1. **Create a New Directory**:
   ```bash
   mkdir terraform-hello-world
   cd terraform-hello-world
   ```

2. **Create the `main.tf` File**:
   ```bash
   touch main.tf
   ```

3. **Add the Following Content to `main.tf`**:
   ```hcl
   provider "aws" {
     region = "us-east-1"  # Choose your preferred AWS region
   }

   resource "aws_instance" "hello_world" {
     ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI in us-east-1
     instance_type = "t2.micro"  # Free tier eligible instance type

     tags = {
       Name = "HelloWorldInstance"
     }
   }
   ```

#### Step 3: Initialize the Terraform Working Directory

Run the following command to initialize the working directory:

```bash
terraform init
```

This command will download the necessary provider plugins and set up the working environment.

#### Step 4: Validate the Configuration

Before applying the configuration, validate it by running:

```bash
terraform plan
```

This command will display the actions Terraform will take to create the resources.

#### Step 5: Deploy the Infrastructure

To create the EC2 instance, run the following command:

```bash
terraform apply
```

When prompted, type `yes` to confirm the deployment.

#### Step 6: Verify the Deployment

After the deployment completes, verify the creation of the EC2 instance by logging into the AWS Management Console and navigating to the EC2 dashboard.

#### Step 7: Clean Up Resources

When you no longer need the resources, you can clean them up by running:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction of the resources.

### Conclusion

This guide covers the complete process of setting up AWS access using IAM for Terraform and deploying a simple "Hello, World" EC2 instance on AWS. By following these steps, you ensure secure access management and can easily extend this example to deploy more complex infrastructure using Terraform.
