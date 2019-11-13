# Proof of Skill  Terraform aws web cluster


This is on request from Ask Nicely as a skills test. 

The requested project; 

```
Write a Terraform resource that launches:

- A VPC. This should include a subnet, route table, and internet gateway.
- An EC2 instance, running a web server that serves a page with the content of your choice. This can be an AWS Free Tier instance, and based off a free tier image.
- An Application Load Balancer targeting the EC2 instance.

This task will require the use of Terraform and the AWS provider. Feel free to use other providers as you see fit.

We use Terraform version 0.11, but use whatever version you are comfortable with.

Make sure that you are running an appropriate `.gitignore` file that excludes your Terraform state. We recommend [https://github.com/github/gitignore/blob/master/Terraform.gitignore](https://github.com/github/gitignore/blob/master/Terraform.gitignore)

What are we looking for?

- Resources should be contained within the VPC
- EC2 instances should not be directly publicly accessible by HTTP/HTTPS (You should be able to access web server content via the Load Balancer.)
- Resources should be well named, well structured and logically separated. It's good to have use of modules and input/output variables when appropriate.

Extra Tasks:

- Ports available on Load Balancers and EC2 instances should be limited to only the necessary ports
- It should be possible to adjust the number of EC2 instances by only changing a variable

How to submit your work?

- Commit your Terraform project as a Github repo.
- Include a README.md that explains the intended way of executing the terraform plan, and how to access the content of your web server(s).
- Send us a link to your Github repository for the Terraform project.
```

# Strategy 

This project is a proof of skill for the use as terraform as a Infra as Code example. All parts of this project will be coded (except this readme, the license file and the initial .gitignore file which were generated by github project creation. And the project-template folder that will hold the generation code for the rest of the project) so it should be completely reproducable from code. 

# Architecture 

Architecural decisions are placed in the docs/doc/adr folder in the form of [Architecture Decision Records](https://github.com/joelparkerhenderson/architecture_decision_record) 
# Implementation 

## Technology stack
- Terraform 0.12.13
- Bash 5.0 
- Linux Gnome 3.34 
- IDE: IntelliJ 2019.2.4  
- Ansible 2.9.0 
- [ADR-tools](https://github.com/npryce/adr-tools/releases/tag/3.0.0)  

## Skeleton project generation. 
The start phase is the generation of the directory structure of the site. Projects should follow a standard pattern that makes automation over several projects easier.
This is from a template project, normally this would come from a template repo. For simplicity sake we have it integral in this project. 

Needs; Ansible, Bash

run as 

```bash 
cd project-template/
bash build-skeleton-project.sh
```

## Run by Environment 
In the infra folder there are three definitions, `non-prod/dev`. `non-prod/uat`, and `prod`. 
For each of these environments there is a provision block assigning the account to run form, and a call to the terraform module in the terraform folder of the project.  
From each of the folders the terraform provision will work by: 

Needs: Terraform

```bash
terraform init
terrafrorm plan -out env.plan
terraform apply env.plan
``` 

## Deployment 


 