#-*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

unless Vagrant.has_plugin?("vagrant-hostsupdater")
  raise 'vagrant-hostsupdater is not installed!'
end

Vagrant.configure(2) do |vagrant|

  # Provider Setup
    vagrant.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end

  # TuxLab Swarm Controller
    vagrant.vm.define "dswarm" do |dswarm|
      dswarm.vm.box = "centos/atomic-host"
      dswarm.vm.box_version = "7.20161006"

      # Disable Guest Additions Installing
          dswarm.vm.provider :virtualbox do |v|
            # On VirtualBox, we don't have guest additions or a functional vboxsf
            # in CoreOS, so tell Vagrant that so it can be smarter.
            v.check_guest_additions = false
            v.functional_vboxsf     = false
          end
          if Vagrant.has_plugin?("vagrant-vbguest") then
            dswarm.vbguest.auto_update = false
          end

      # Disable Folder Syncing
      dswarm.vm.synced_folder '.', '/home/vagrant/sync', disabled: true

      # Setup Network and SSH
      dswarm.vm.network "private_network", ip: "10.100.1.10"
      dswarm.hostsupdater.aliases = ["dswarm.tuxlab.local"]

      dswarm.ssh.insert_key = false
      dswarm.ssh.private_key_path = '~/.vagrant.d/insecure_private_key'

      # Force Refresh Network
      dswarm.vm.provision "shell", path: "local/vagrant_network_conf.sh"
    end

    # TuxLab Swarm Host
      vagrant.vm.define "dhost" do |dhost|
        dhost.vm.box = "centos/atomic-host"
        dhost.vm.box_version = "1706.01"

        # Disable Guest Additions Installing
            dhost.vm.provider :virtualbox do |v|
              # On VirtualBox, we don't have guest additions or a functional vboxsf
              # in CoreOS, so tell Vagrant that so it can be smarter.
              v.check_guest_additions = false
              v.functional_vboxsf     = false
            end
            if Vagrant.has_plugin?("vagrant-vbguest") then
              dhost.vbguest.auto_update = false
            end
        # Disable Folder Syncing
        dhost.vm.synced_folder '.', '/home/vagrant/sync', disabled: true

        # Setup Network and SSH
        dhost.vm.network "private_network", ip: "10.100.1.11"
        dhost.hostsupdater.aliases = ["dhost.tuxlab.local"]

        dhost.ssh.insert_key = false
        dhost.ssh.private_key_path = '~/.vagrant.d/insecure_private_key'

        # Force Refresh Network
        dhost.vm.provision "shell", path: "local/vagrant_network_conf.sh"
      end

  # Meteor Host
    vagrant.vm.define "meteor" do |meteor|
      meteor.vm.box = "centos/7"

      meteor.vm.provider :virtualbox do |v|
        v.memory = 2048
        v.cpus = 2
      end

      # Disable Folder Syncing
      meteor.vm.synced_folder ".", "/vagrant", disabled: true

      # Set Key
      meteor.ssh.username="vagrant"
      meteor.ssh.insert_key = false
      meteor.ssh.private_key_path = '~/.vagrant.d/insecure_private_key'

      # Add to Network
      meteor.vm.network "private_network", ip: "10.100.1.2"
      meteor.hostsupdater.aliases = ["meteor.tuxlab.local"]

      meteor.vm.provision "shell", path: "local/vagrant_network_conf.sh"

      # Configure All Hosts via Ansible
      meteor.vm.provision :ansible do |ansible|
        ansible.playbook = "./setup.yml"
        ansible.limit = 'all'
        ansible.force_remote_user = false
        ansible.host_key_checking = false
        ansible.inventory_path = "./local/vagrant_ansible_inventory"
        ansible.verbose = true
        ansible.extra_vars = {
          host_key_checking: "False",
          swarm_node_ip: "10.100.1.10"
        }
      end

    end
end
