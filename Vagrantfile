Vagrant.configure("2") do |config|
  # maquina virtual do docker
  config.vm.define "ubuntu-docker" do |d|


    # Provedor ESXI
    #d.vm.provider :vmware_esxi do |v|
    #  v.esxi_hostname = "10.0.1.4"
    #  v.esxi_username = "---"
    #  v.esxi_password = "----"
    #  v.esxi_virtual_network = ["ATIVOS Network","ATIVOS Network"]
    #  v.esxi_disk_store = "datastore1"
    #  v.guest_memsize = "2048"
    #  v.guest_numvcpus = "2"
    #  v.guest_mac_address = ["00:50:56:3f:01:01"]
    #end
    d.vm.provider "virtualbox"
    # config.vm.box_version = "3.2.4"
    d.vm.box = "generic/ubuntu2004"
    d.vm.hostname = "vagrant-ubuntu-docker"
    # network
    #d.vm.network "private_network", ip: "192.168.11.2", auto_config: "false"
    d.vm.network "public_network", ip: "192.168.1.251", bridge: "Intel(R) Dual Band Wireless-N 7265"
    config.vm.provision "shell",  run: "always",  inline: "route add default gw 192.168.1.1"
    # shared folder
    d.vm.synced_folder "./configs", "/configs"
    d.vm.synced_folder ".", "/vagrant", disabled: true
    # Provisionamento
    #d.vm.provision "shell",
    #  run: "always",
    #  inline: "route add default gw 10.0.1.1"
    d.vm.provision "shell", inline: "cat /configs/key.pub >> .ssh/authorized_keys"
    d.vm.provision "shell", inline: "apt-get update && apt-get install -y puppet"
    d.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "./configs/manifests"
      puppet.manifest_file = "puppet.pp"
    end

  end
end
