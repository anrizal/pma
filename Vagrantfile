#Vagrant API Version
#Currently, there are only two supported versions: "1" and "2".
#Version 1 represents the configuration from Vagrant 1.0.x.
#"2" represents the configuration for 1.1+ leading up to 2.0.x.
VAGRANTFILE_API_VERSION = "2"

# The BOX used is Ubuntu 12.04 LTS 64 bit
BOX = "precise64"
BOX_URL = "http://files.vagrantup.com/precise64.box"

# We set the vm's memory to 1024 MB
MEMORY = "1024"

# Network
IP_MASTER = "10.0.1.10"
IP_AGENT = "10.0.1.11"

# Share/synced folder configuration
HOST_FOLDER_MASTER = "./data/master"
HOST_FOLDER_AGENT = "./data/agent"
GUEST_FOLDER = "/home/vagrant/data"

#provision script
#We use shell for provision
SHELL_PATH_MASTER = "./provision/pmaster.sh"
SHELL_PATH_AGENT = "./provision/pagent.sh"


#==========================================================================
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. For a detailed explanation
  # and listing of configuration options, please view the documentation
  # online. http://docs.vagrantup.com/v2/

config.vm.define "master" do |master|
  # The BOX
    master.vm.box = BOX
    master.vm.box_url = BOX_URL

  # We set the vm's memory, enable ioapic, set natdnsresolver
    master.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", MEMORY]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--cpus", 1]
    end    
  # Network Settings. Note, in 1.1++ no host only and no forward port option 
    master.vm.network :private_network, ip: IP_MASTER

  case RUBY_PLATFORM.downcase
    when /cygwin|mswin|mingw|bccwin|wince|emx/ #windows
      master.vm.synced_folder HOST_FOLDER_MASTER, GUEST_FOLDER, id: "vagrant-root", nfs: false
    when /darwin|mac os/ #OSX
      master.vm.synced_folder HOST_FOLDER_MASTER, GUEST_FOLDER, id: "vagrant-root", :owner=> 'vagrant', :group=>'www-data', :mount_options => ['dmode=775', 'fmode=775']
    when /linux/ #linux
      master.vm.synced_folder HOST_FOLDER_MASTER, GUEST_FOLDER, id: "vagrant-root", nfs: true
    else
      puts "un-supported Operating System"
  end

  master.vm.provision :shell, :path=> SHELL_PATH_MASTER

#end of master config
end

config.vm.define "agent" do |agent|
  # The BOX
    agent.vm.box = BOX
    agent.vm.box_url = BOX_URL

  # We set the vm's memory, enable ioapic, set natdnsresolver
    agent.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", MEMORY]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--cpus", 1]
    end    
  # Network Settings. Note, in 1.1++ no host only and no forward port option 
    agent.vm.network :private_network, ip: IP_AGENT

  case RUBY_PLATFORM.downcase
    when /cygwin|mswin|mingw|bccwin|wince|emx/ #windows
      agent.vm.synced_folder HOST_FOLDER_AGENT, GUEST_FOLDER, id: "vagrant-root", nfs: false
    when /darwin|mac os/ #OSX
      agent.vm.synced_folder HOST_FOLDER_AGENT, GUEST_FOLDER, id: "vagrant-root", :owner=> 'vagrant', :group=>'www-data', :mount_options => ['dmode=775', 'fmode=775']
    when /linux/ #linux
      agent.vm.synced_folder HOST_FOLDER_AGENT, GUEST_FOLDER, id: "vagrant-root", nfs: true
    else
      puts "un-supported Operating System"
  end

  agent.vm.provision :shell, :path=> SHELL_PATH_AGENT

#end of agent config
end

#en of vagrant file
end