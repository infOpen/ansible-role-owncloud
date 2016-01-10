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

    # INSTALLATION VARIABLES
    #==========================================================================
    owncloud_repository_key_id: 'BCECA90325B072AB1245F739AB7C32C35180350A'

    # Base URL of OwnCloud downloads, used to build distribution URL
    owncloud_repository_base_url: "{{ 'https://download.owncloud.org/download'
                                        ~ '/repositories/' }}"

    # Repository urls can be customized, else default distribution used
    owncloud_repository_key_url: ''
    owncloud_repository_source_url: ''

    owncloud_repository_file_name: 'owncloud.list'
    owncloud_repository_file_owner: 'root'
    owncloud_repository_file_group: 'root'
    owncloud_repository_file_mode: '0644'

    owncloud_version: 8.2
    owncloud_package_state: 'present'


    # GENERAL CONFIGURATION
    #==========================================================================
    owncloud_data_directory: '/var/www/owncloud/data'
    owncloud_www_directory: '/var/www/owncloud'


    # ADDITIONAL PACKAGES MANAGEMENT
    #==========================================================================

    # Webserver configuration
    #------------------------
    owncloud_webserver_managed_by_this_role: True

    owncloud_webserver_cn: ''
    owncloud_webserver_name: 'apache' # Only Apache managed today
    owncloud_webserver_packages_state: 'present'
    owncloud_webserver_remove_existing_endpoints: True
    owncloud_webserver_use_only_ssl: True

    # SSL management
    owncloud_webserver_ssl_certificate:
      directory:
        name: '/etc/ssl/certs'
        owner: 'root'
        group: 'root'
        mode: '0755'
      file:
        name: 'owncloud.pem'
        owner: 'root'
        group: 'root'
        mode: '0644'
    owncloud_webserver_ssl_certificate_content: ''

    owncloud_webserver_ssl_private_key:
      directory:
        name: '/etc/ssl/private'
        owner: 'root'
        group: 'ssl-cert'
        mode: '0710'
      file:
        name: 'owncloud.key'
        owner: 'root'
        group: 'ssl-cert'
        mode: '0640'
    owncloud_webserver_ssl_private_key_content: ''

    # VHOST management
    owncloud_webserver_vhost_file_name: 'owncloud.conf'
    owncloud_webserver_vhosts:
      - alias: []
        name: "{{ owncloud_webserver_cn or ansible_fqdn }}"
        ip: '*'
        use_ssl: True
        port: 443

### Ubuntu distribution vars

    # OwnCloud APT repository URL
    owncloud_repository_apt_source_url: "{{ owncloud_repository_base_url
                                            ~ owncloud_version
                                            ~ '/Ubuntu_'
                                            ~ ansible_distribution_version }}/"

    # Owncloud GPG key URL for distribution
    owncloud_repository_apt_key_url: "{{ owncloud_repository_apt_source_url
                                          ~ 'Release.key' }}"

    # Packages name
    owncloud_packages:
      - owncloud
      - owncloud-server

    # All distribution settings about webserver management
    owncloud_webserver_management:
      - name: 'apache'
        default_site_endpoints:
          - '000-default'
        default_conf_endpoints:
          - 'owncloud'
        folders:
          conf_enabled: '/etc/apache2/conf-enabled'
          site_enabled: '/etc/apache2/site-enabled'
          vhost_destination: '/etc/apache2/sites-available'
          vhost_symlink_destination: '/etc/apache2/sites-enabled'
        packages:
          - 'apache2'
        port_configuration_files:
          - '/etc/apache2/ports.conf'
        required_modules:
          - 'ssl'
        service_name: 'apache2'
        vhost_file:
          owner: 'root'
          group: 'root'
          mode: '0644'

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

