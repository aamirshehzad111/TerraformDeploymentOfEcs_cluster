# TerraformDeploymentOfEcs_cluster
Running php and mysql application on ec2 cluster using terraform.

Modules:

* virtual_private_gateway
* ecs_cluster
* iam_roles
* task_definition
* services
* application_loadbalancer 

every module contain 3 files
   * main.tf
   * variables.tf
   * output.tf
   
other main files are:

* backend.tf
   To store state remotely on AWS S3 
   Creating DyanmoDB for locking 

* main.tf 
   it's the file where we call all modules and let modules having interaction with each other. Modules interact with each other with output files of moudle.
   
* variable.tf 
   it's file which contain inputs variable 

* starter.tf 
   it's use to assign values to input variable
   
* starter.sh 
   bash script to assign values to variables
   
   
