require 'tty-prompt'

openstack_release = ENV["OPENSTACK_RELEASE"]

if !ENV["ANSIBLE_TAGS"].nil?
  ansible_tags = ENV["ANSIBLE_TAGS"].split(",")
end

def get_ansible_tags(openstack_release)
  prompt = TTY::Prompt.new
  return prompt.multi_select("What would you like to do?") do |menu|
    menu.default 1
    menu.choice "Full Install", "install_full"

    # Manila not available in rocky
    if openstack_release != "rocky"
      menu.choice "Install Additional Service: Manila", "install_manila"
    end
  end
end

def get_openstack_release()
  prompt = TTY::Prompt.new
  return prompt.select("Which version of OpenStack should be targeted?") do |menu|
    menu.choice "Rocky", "rocky"
    menu.choice "Stein", "stein"
    menu.choice "Train", "train"
    menu.choice "Ussuri", "ussuri"
  end
end

if openstack_release.nil?
  openstack_release = get_openstack_release()
  ENV["OPENSTACK_RELEASE"] = openstack_release
end

if ARGV.include?("--provision") && ansible_tags.nil?
  ansible_tags = get_ansible_tags(openstack_release)
  ENV["ANSIBLE_TAGS"] = ansible_tags.join(",")
elsif ARGV.include?("up") && ansible_tags.nil?
  ansible_tags = get_ansible_tags(openstack_release)
  ENV["ANSIBLE_TAGS"] = ansible_tags.join(",")
end

Vagrant.configure("2") do |config|
  N = 1
  (1..N).each do |machine_id|
    config.vm.define "machine-#{openstack_release}-#{machine_id}" do |machine|
      machine.vm.box = "centos7:2004"
      machine.vm.synced_folder '.', '/vagrant', disabled: true
      machine.vm.hostname = "machine-#{openstack_release}-#{machine_id}"

      # If we end up running multiple releases next to each other, make sure networking does not collide
      if openstack_release.to_s.downcase == 'rocky'
        third_octect = "239"
      elsif openstack_release.to_s.downcase == 'stein'
        third_octect = "240"
      elsif openstack_release.to_s.downcase == 'train'
        third_octect = "241"
      elsif openstack_release.to_s.downcase == 'ussuri'
        third_octect = "242"
      else
        third_octect = "243"
      end

      machine.vm.network "private_network", ip: "192.168.#{third_octect}.#{10 + machine_id}"

      machine.vm.provider "virtualbox" do |vb|
        # ----------------------------------------------------------
        # CPUs
        # ----------------------------------------------------------
        vb.cpus = 4

        # ----------------------------------------------------------
        # Memory
        # ----------------------------------------------------------
        vb.memory = "8192"

        # ----------------------------------------------------------
        # Disks
        # ----------------------------------------------------------
        (0..0).each do |disk_id|
          disk = "./tmp/machine-#{openstack_release}-#{machine_id}-osd#{disk_id}.vdi"
          size = 100 * 1024
          unless File.exist?(disk)
            vb.customize ['createhd', '--filename', disk, '--variant', 'Fixed', '--size', size]
          end
          vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', disk_id, '--device', 1, '--type', 'hdd', '--medium', disk]
        end
      end

      # Only execute once the Ansible provisioner,
      # when all the machines are up and ready.
      if machine_id == N
        machine.vm.provision :ansible do |ansible|
          # Disable default limit to connect to all the machines
          ansible.compatibility_mode = "2.0"
          ansible.limit = "all"
          ansible.playbook = "ansible/playbook.yaml"
          ansible.groups = {
            "aio" => ["machine-#{openstack_release}-1"],
          }
          ansible.extra_vars = {
            "openstack_release" => openstack_release,
          }
          ansible.tags = ansible_tags
        end
      end
    end
  end
end
