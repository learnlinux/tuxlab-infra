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
up:
	rm ~/.ssh/known_hosts | true;
	vagrant up;

# Test Application
test: destroy up
	vagrant ssh meteor --command "cd /var/www && forever stopall";
	vagrant ssh meteor --command "cd /var/tuxlab && /usr/local/bin/meteor npm install && /usr/local/bin/meteor npm test";

# Down Vagrantfile
destroy:
	vagrant destroy --force;
	rm -rf .vagrant/;
	rm -rf ~/.tuxlab;
