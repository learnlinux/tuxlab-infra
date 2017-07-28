##########################################
#          TUXLAB INFRASTRUCTURE         #
##########################################

# Up Vagrantfile
up: destroy
	rm ~/.ssh/known_hosts | true;
	# git submodule update --recursive --remote;
	vagrant up;

# Run Meteor
run:
	rm ~/.ssh/known_hosts | true;
	vagrant rsync meteor
	vagrant ssh meteor --command "cd /tuxlab-sync && /usr/local/bin/meteor npm install && ROOT_URL=http://tuxlab.local:3000 /usr/local/bin/meteor --settings ./private/settings.json";

# Test Application
test:
	ansible-playbook ./test.yml --inventory ./local/vagrant_ansible_inventory
	vagrant rsync meteor
	vagrant ssh meteor --command "cd /tuxlab-sync && /usr/local/bin/meteor npm install && /usr/local/bin/meteor npm test";

# Down Vagrantfile
destroy:
	vagrant destroy --force;
	rm -rf .vagrant/;
	rm -rf ~/.tuxlab;

.PHONY: up run test destroy
