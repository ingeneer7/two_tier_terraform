Prerequisites:

Before proceeding with the deployment, you will need to create an SSH key pair on the AWS EC2 console. Here are the steps:

Navigate to https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#KeyPairs
Click on "Create Key Pair"
Name the key "my-pem-key"
Download the pem key file and save it to your local machine. This file will be used to SSH to the bastion host, and then from there, you will be able to SSH to the web servers as required by the project.
Note that if you prefer a different name for the key, you can change it in the "variables.tf" file before running the Terraform apply command. Just look for the following variable:

variable "key_name" {
  default = "my-pem-key"
}

Run the command terraform init to initialize the Terraform working directory.
Run the command terraform plan to create an execution plan.
Review the plan and make sure that everything is correct.
Run the command terraform apply to apply the changes.
Wait for the deployment to complete (around 5-10 minutes).
To access the web servers, SSH to the bastion host first. Use the following command to move the key pair file to the bastion host's home directory:
rsync -avz -e "ssh -i ~/Desktop/my-pem-key.pem" ~/Desktop/my-pem-key.pem ec2-user@bastion-host-ip:/home/ec2-user/

Replace my-pem-key.pem with the name of your EC2 key pair file and bastion-host-ip with the public IP address or DNS name of the bastion host.

SSH to the bastion host using the following command:

ssh -i ~/Desktop/my-pem-key.pem ec2-user@bastion-host-ip

Replace my-pem-key.pem with the name of your EC2 key pair file and bastion-host-ip with the public IP address or DNS name of the bastion host.

Once you are logged in to the bastion host, you can SSH to the web servers using their private IP addresses.

ssh -i ~/my-pem-key.pem ec2-user@private-ip-of-web-server

Once you are logged in to the web servers, you can test the web application by opening a web browser and navigating to the public IP address of the load balancer.

Note: If you do not want to use SSH to access the bastion host, you can attach an SSM full administrator role to the EC2 instances and use the AWS Systems Manager Session Manager to access the instances from the AWS console.




