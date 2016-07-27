##########################################
#          TUXLAB INFRASTRUCTURE         #
##########################################

# Automatically Provision AWS
.PHONY: aws
aws:
	if [ -z ${AWS_ACCESS_KEY_ID+x}]; then echo "AWS_ACCESS_KEY_ID IS UNSET."; exit 1; fi;
	if [ -z ${AWS_SECRET_ACCESS_KEY+x}]; then echo "AWS_SECRET_ACCESS_KEY IS UNSET."; exit 1; fi;
	ansible-playbook site.yml;

# Automatically Provision via Vagrant
vagrant: destroy
	vagrant up;

# Destroy Vagrant
destroy:
	vagrant destroy -f;
	rm -rf .vagrant/;
	rm -rf ~/.tuxlab;
	rm -rf ~/VirtualBox\ VMs/*;
