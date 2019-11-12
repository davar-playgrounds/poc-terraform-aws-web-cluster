# 2. Infrastructure layout

Date: 2019-11-12

## Status

Accepted

## Context

When creating a piece of infrastructure it is implied that this code would be able to be run in several environments. To illustrate this, there are three environments created, dev, uat, and prod. There will be one and only one 
terraform module and each environment will feed it with different parameters to create distinct instances. 

## Decision

The terraform code is made multi environment, it has not been made multi account as there are better tools to do that with, like terragrunt, which is outside the scope of the PoS. 

## Consequences

It will be possible to create multiple environments, but it will be limited to one account. 
