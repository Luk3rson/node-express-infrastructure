# node-express-infrastructure
This repo includes a basic setup needed for infrastructure deployment of node-express project.
The main application is located in the repository: [node-express-realworld-example-app](https://github.com/Luk3rson/node-express-realworld-example-app) 
The application and infrastructure is built using the CircleCi.

##Initialization
In order to start with terraform following command needs to be called from the solutions' folder:

```
~/terraform/solutions/network>terraform init -input=false -backend-config=bucket=web-app-terraform-state-dev
```
The bucket differentiate based on the branch the command is being called from.
This is handled in config.yml. Also the AWS Credentials are set as variables.
Each workspace is deployed to a different AWS account within the AWS Organization.

##Plan
Once the init phase is done the right workspace needs to be selected and trigger the plan:
```shell script
terraform workspace select dev
terraform plan -out tfapply -var-file ../../environments/network/dev.tfvars
```

##Apply
The generated state file now needs to be applied to our infrastructure if there are any changes using following command:
```shell script
terraform apply tfapply
```

###Destroy
In a case the infrastructure is no longer needed the resources need to be removed in following order:
1. application solution
2. network solution

Example of destroy execution of application solution:
```shell script
terraform plan -destroy -out tfdestroy -var-file ../../environments/application/dev.tfvars
```
After the destroy-plan creation, use the following command the remove all resources from AWS:
```shell script
terraform apply -auto-approve tfdestroy
```