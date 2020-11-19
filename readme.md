# Using Ansible, Packer, Terraform to Create AWS EC2 Instances

1. Edit `secrets.json` in packer folder, Give your AMI a name and AWS region to deploy to. I'm using `us-west-1` in this example.

_NOTE:_ The timestamp (epoch format) will be appeneded to the name of the AMI.

EX: `my-ami-1605800314` 

2. Build AMI image.
```
cd packer
packer build -var-file secrets.json ami.json
```

3. Edit `secrets.tfvars` inside of the terraform folder, I'm using `us-west-1` as the region in this example. Change this depending on the region you're deploying to.
Supply the following:
- AWS ID
- SSH Key name
- Desired security to use   

4. Build the EC2 instance.
```
cd terraform
terraform plan -var-file secrets.tfvars -out apply.tfplan
terraform apply apply.tfplan