##########################################
#          TUXLAB INFRASTRUCTURE         #
##########################################

# Run AWS Playbook
.PHONY: aws
aws:
	if [ -z ${AWS_ACCESS_KEY_ID+x}]; then echo "AWS_ACCESS_KEY_ID IS UNSET."; exit 1; fi;
	if [ -z ${AWS_SECRET_ACCESS_KEY+x}]; then echo "AWS_SECRET_ACCESS_KEY IS UNSET."; exit 1; fi;
	ansible-playbook site.yml;

# Up Vagrantfile
up: destroy
	rm ~/.ssh/known_hosts | true;
	# git submodule update --recursive --remote;
	vagrant up;

# Run Meteor
run:
	rm ~/.ssh/known_hosts | true;
	vagrant rsync meteor
	vagrant ssh meteor --command "cd /tuxlab-sync && /usr/local/bin/meteor npm install && ROOT_URL=http://tuxlab.local:3000 /usr/local/bin/meteor";

# Test Application
test:
	vagrant rsync meteor
	vagrant ssh meteor --command "cd /tuxlab-sync && /usr/local/bin/meteor npm install && /usr/local/bin/meteor npm test";

# Down Vagrantfile
destroy:
	vagrant destroy --force;
	rm -rf .vagrant/;
	rm -rf ~/.tuxlab;
