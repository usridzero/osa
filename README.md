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
      * This will no longer prompt you for which version of openstack you wish to `up`

### Forwarded ports
You can access the UI using your host computer's browser: `localhost:<port>` or `https://localhost:<port>`
#### Rocky
* HTTP: 8080
* HTTPS: 8443
#### Stein
* HTTP: 8081
* HTTPS: 8444
#### Train
* HTTP: 8082
* HTTPS: 8445
#### Ussuri
* HTTP: 8083
* HTTPS: 8446
#### Any other
* HTTP: 8084
* HTTPS: 8447
