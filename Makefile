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
	vagrant rsync meteor
	vagrant ssh meteor --command "cd /tuxlab-sync && /usr/local/bin/meteor npm install && /usr/local/bin/meteor npm test";

# Access Various Containers
meteor:
	vagrant ssh meteor; exit 0;
dswarm:
	vagrant ssh dswarm; exit 0;
dhost:
	ssh -i ~/.vagrant.d/insecure_private_key -p 2222 -o UserKnownHostsFile=/dev/null vagrant@10.100.1.11; exit 0;

# Down Vagrantfile
destroy:
	vagrant destroy --force;
	rm -rf .vagrant/;
	rm -rf ~/.tuxlab;

.PHONY: up run test destroy
