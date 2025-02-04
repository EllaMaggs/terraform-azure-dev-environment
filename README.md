# Azure Infrastructure Deployment with Terraform

This repository contains a Terraform configuration designed to automate the deployment and creation of Azure infrastructure. The configuration is architected for development environments and is modular, allowing for easy extension to include additional resources as required.

## Overview

The deployment includes:

- Resource Group `emtf-resources`: Organises all resources.
- Virtual Network `emtf-network` & Subnet `emtf-subnet`: Defines private IP address space.
- Network Security Group `emtf-sg`: Includes an inbound rule to allow traffic.
- Public IP Address `emtf-ip`: Allows external access to the VM.
- Network Interface `emtf-nic`: Connects the VM to the network.
- Linux Virtual Machine `emtf-vm`: A Ubuntu-based VM for development and testing.

 The `custom_data field` in the `emtf-vm` resource allows you to pass a script to the virtual machine during initialisation. This script can be used to install software, configure settings, or perform other setup tasks.

## Roadmap
- Add SSH command to the output value.
- Improve inbound/outbound rules in the Network Security Group (NSG) to restrict certain ports/protocols to only what is neccesary. 
- Avoid hardcoding dynamic values. Instead, use Terraform variables.




