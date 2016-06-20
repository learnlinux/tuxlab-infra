# TuxLab
TuxLab is an open source platform for creating Interactive Linux Courses.  This repository
contains the infrastructure configuration (done using Ansible).  It will automatically
create the necessary network configuration, security groups, provision and install Ansible
Tower and configure Elastic Load Balancing and Autoscaling groups for the application in
AWS EC2.

If you are instead looking for the application source code itself, visit the [App Repository](https://github.com/learnlinux/tuxlab-app).

The TuxLab infrastructure is configured as follows:


![TuxLab Infrastructure Diagram](https://docs.google.com/drawings/d/1jLnkbWYxgBlfEEc6eldGdA_ONhBRTjJ6KmwGvpoFXkY/pub?w=960&h=720)

## Running the Development Environment
In order to make development easier, we have created a Vagrant Enviornment to simulate the servers needed to run the TuxLab Site. You can get this up and running by first installing the following pre-requisites:
 * Vagrant
 * Vagrant Hosts Plugin
 * VirtualBox
 * Ansible (>2.2)
 * SSHPass

You can then initialize this environment by running `vagrant up`.  The TuxLab site will be
visible at `10.100.0.10:8080`.

## Running on AWS Cloud
You need the following things:
 * Install Python, pip and Ansible (>2.2) via your package manager.
 * Install boto and tower-cli using pip (`sudo pip install -U boto ansible-tower-cli`)
 * Place your Ansible Tower license in /aws/keys/tower.txt, and add the JSON property `"eula_accepted" : true`, indicating you have read and accepted the Ansible Tower EULA.
 * Edit the `aws/vars/` files based on your configuration.
 * Set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY Enviornment Variables, and run the ansible playbook:
    ```
    export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXX
    export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXX
    ansible-playbook site.yml
    ```
 * Finally, create DNS records to route your domain to the TuxLab instance. If you wanted for the tuxlab app to be displayed at domain.com.
   ```
   NS   *.domain.com     <SWARM_NODE_IP>
   A    domain.com       <LOAD_BALANCER_DNS_NAME>
   ```
   Alternatively, If you are using Amazon Route 53, you can use [Aliases](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/using-domain-names-with-elb.html#dns-associate-custom-elb) to more easily configure these IP addresses.
