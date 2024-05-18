# CyberConnexion_Capstone

Introduction

With the everchanging Information Technology field we have moved to an era of Cloud Computing. With the cloud computing platform, we have been introduced with the shared responsibility model from the Public Cloud perspective. Now we are dealing with IaaS, PaaS, SaaS, Service as a Service, and Infrastructure as Code. With all these new concepts, securing the Cloud Platform became more challenging compared to the On-prem Data Center Facilities.
Capstone Project
The idea of the capstone project is to introduce the students to a real-world problem, with the expectations that the students will be able to solve it with minimum guidance. Students should be able to explain each decision they have made to successfully achieve the goals set by the project admin.
By solving this real-world problem, students will be able to create a portfolio and showcase their ability on a specific topic, which will help them in their professional career.

Project Scope & Synapsis
Deploy a Secure “Hybrid Cloud” environment with the following characteristics:
1. A three tier “highly available” application environment in a Production VPC
2. A Non-Prod environment
3. A Transit Gateway for routing traffic between VPCs
4. An On-Prem environment (simulated with an AWS VPC)
5. A network scanner and endpoint agents (linked a SaaS platform)

Three Tier Application in PROD VPC

Students are expected to use the Web Tier as a “Jump Box”. The application should be behind an
Application Load Balancer. And the database should be behind the application servers.
The application should be accessible from the internet, round robin load balancing should be working.
The database should be accessible from the application interface.

Non-Prod VPC

Students are expected to create a single subnet where they should deploy 5 virtual machines. Each
virtual machine should have different operating systems installed (so 5 OSes in total). These VMs are
being placed here for instructive purposes, as you will use them as targets for vulnerability scanning.

On-Prem Environment

Students are expected to create a customer gateway from which they should create a site-to-site VPN
tunnel connecting the on-prem VPC to the transit gateway to simulate the hybrid cloud scenario. They
should also create an EC2 instance to simulate the on-prem workload.

Architecture

Students should be able to create a detailed visual representation of the architecture that they are going
to deploy. They should provide the IP/subnet planning, routing table information, NACL/security group
information as needed. They will also prepare a report (5-6 pages) documenting the architecture and
briefly explaining major design choices.
Students may want to use the web tool draw.io to create your architecture diagrams.
N.B: Students should be able to clearly explain the overall architecture.

Required AWS Services

Students will create their own AWS account (each team can create 1 account), use the IAM to provide
permission to the team members. AWS provides Free Tier to do this kind of projects, but keep in mind
that there might be a small cost associated with it, which will be covered by Cyber Connexion. It is
recommended that the students Stop the EC2 Instances while they are not using it. Also, the Elastic IP
address, NAT Gateway, Internet Gateway, and Application Load Balancer might add some cost to the
account – it is recommended that students disassociate and delete these services while they are not
using the environment.
