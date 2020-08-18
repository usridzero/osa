# OpenStack-Ansible Development Wrapper
This is currently as Work In Progress.

The goal is that a user can use this to stand up one or many OpenStack-Ansible based AIO VMs
all on the same workstation. It also allows for piece-part installation of services.

## Required software
* ansible 2.9.9
* vagrant 2.2.9
* VirtualBox 6.1.12 r139181

## Getting Started
* `./lib/low/get_box.sh`
* `vagrant plugin install tty-prompt`
* `vagrant up` 

## Operating Operationally
* You can ssh into an AIO via `vagrant ssh`
* You can run multiple AIOs simultaniously by using diffent enviornments
  * For example, opening a new terminal
* You can specify ENV variable for your terminal if you so choose:
  * `OPENSTACK_RELEASE` 
    * Valid choices are one of: ['rocky', 'stein', 'train', 'ussuri']
    * Ex. `OPENSTACK_RELEASE=stein vagrant up`
      * This will no longer prompt you for which version of openstack you wish to `up`s