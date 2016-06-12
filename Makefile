##########################################
#          TUXLAB INFRASTRUCTURE         #
##########################################

# Automatically Provision AWS
aws:
	ansible-playbook site.yml;

# Automatically Provision via Vagrant
vagrant:
	rm -rf ~/.tuxlab/discovery_url ~/.tuxlab;
	vagrant up;

# Destroy Vagrant
destroy:
	vagrant destroy -f;
	rm -rf .vagrant/;
	rm -rf ~/.tuxlab/discovery_url ~/.tuxlab;
