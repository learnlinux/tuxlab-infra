#-*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |vagrant|

  # Provider Setup
    vagrant.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end

  # Docker Swarm Controller
    vagrant.vm.define "dswarm" do |dswarm|
      dswarm.vm.box = "coreos-stable"
      dswarm.vm.box_url = "https://storage.googleapis.com/stable.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json"

      # Disable Guest Additions Installing on CoreOS
          dswarm.vm.provider :virtualbox do |v|
            # On VirtualBox, we don't have guest additions or a functional vboxsf
            # in CoreOS, so tell Vagrant that so it can be smarter.
            v.check_guest_additions = false
            v.functional_vboxsf     = false
          end
          if Vagrant.has_plugin?("vagrant-vbguest") then
            dswarm.vbguest.auto_update = false
          end

      # Add to Network
      dswarm.vm.network "private_network", ip: "10.100.1.10"
      dswarm.vm.network "forwarded_port", guest: 2375, host: 2375

      # Create Container Forwarded Ports
      for i in 32768..32867
        dswarm.vm.network "forwarded_port", guest: i, host: i
      end

      # Configure via Ansible
      dswarm.vm.provision :ansible do |ansible|
        ansible.playbook = "./config.yml"
        ansible.groups = {
           'tuxlab-swarm-host' => ["dswarm"],
           'tuxlab-swarm-manager' => ["dswarm"]
         }
        ansible.extra_vars = {
          swarm_node_ip: "10.100.1.10"
        }
      end
    end

  # MongoDB Host
    vagrant.vm.define "mongodb" do |mongodb|

      mongodb.vm.box = "centos/7"

      # Add to Network
      mongodb.vm.network "private_network", ip: "10.0.1.0"

      # Configure via Ansible
      mongodb.vm.provision :ansible do |ansible|
        ansible.playbook = "./config.yml"
        ansible.groups = {
           'tuxlab-mongodb' => ["mongodb"],
         }
      end

    end

  # Meteor Host
    vagrant.vm.define "meteor" do |meteor|

      meteor.vm.box = "centos/7"

      # Add to Network
      meteor.vm.network "private_network", ip: "10.100.0.10"
      meteor.vm.network :forwarded_port,
                         guest: 80,
                         host: 8080,
                         auto_correct: false

      # Configure via Ansible
      meteor.vm.provision :ansible do |ansible|
        ansible.playbook = "./config.yml"
        ansible.groups = {
           'tuxlab-meteor' => ["meteor"],
         }
      end

    end


end
