# owncloud

[![Build Status](https://travis-ci.org/infOpen/ansible-role-owncloud.svg?branch=master)](https://travis-ci.org/infOpen/ansible-role-owncloud)

Install owncloud package.

## Requirements

This role requires Ansible 2.0 or higher,
and platform requirements are listed in the metadata file.

## Testing

This role contains two tests methods :
- locally using Vagrant
- automatically with Travis

### Testing dependencies
- install [Vagrant](https://www.vagrantup.com)
- install [Vagrant serverspec plugin](https://github.com/jvoorhis/vagrant-serverspec)
    $ vagrant plugin install vagrant-serverspec
- install ruby dependencies
    $ bundle install

### Running tests

#### Run playbook and test

- if Vagrant box not running
    $ vagrant up

- if Vagrant box running
    $ vagrant provision

## Role Variables

### Default role variables

    # Installation variables
    #-----------------------
    owncloud_repository_key_id: 'BCECA90325B072AB1245F739AB7C32C35180350A'

    # Repository urls can be customized, else default distribution used
    owncloud_repository_key_url: ''
    owncloud_repository_source_url: ''

    owncloud_repository_file_name: 'owncloud.list'
    owncloud_repository_file_owner: 'root'
    owncloud_repository_file_group: 'root'
    owncloud_repository_file_mode: '0644'

    owncloud_version: 8.2
    owncloud_package_state: 'present'
    owncloud_webserver_service_name: 'apache2'

### Ubuntu distribution vars

    owncloud_repository_apt_base: "{{ 'https://download.owncloud.org/download'
                                        ~ '/repositories/' }}"
    owncloud_repository_apt_source_url: "{{ owncloud_repository_apt_base
                                            ~ owncloud_version
                                            ~ '/Ubuntu_'
                                            ~ ansible_distribution_version }}/"
    owncloud_repository_apt_key_url: "{{ owncloud_repository_apt_base
                                          ~ owncloud_version
                                          ~ '/Ubuntu_'
                                          ~ ansible_distribution_version
                                          ~ '/Release.key' }}"
    owncloud_packages:
      - owncloud
      - owncloud-server

## Dependencies

None

## Example Playbook

    - hosts: servers
      roles:
         - { role: achaussier.owncloud }

## License

MIT

## Author Information

Alexandre Chaussier (for Infopen company)
- http://www.infopen.pro
- a.chaussier [at] infopen.pro

