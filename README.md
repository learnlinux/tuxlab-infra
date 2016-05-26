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
 * Ansible
 * SSHPass

You can then initialize this environment by running `vagrant up`.  The TuxLab site will be
visible at `10.100.0.10:8080`.

## Running on AWS Cloud
You need the following things:
 * Edit the `ansible/aws/vars/` based on your configuration.
 * Python, pip
 * `sudo pip install -U boto`
 * Ansible

 Then simply run: `ansible-playbook ./ansible/site.yml`
