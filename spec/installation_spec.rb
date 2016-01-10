require 'serverspec'

describe 'owncloud Ansible role' do

    if ['debian', 'ubuntu'].include?(os[:family])
        describe 'Specific Debian and Ubuntu family checks' do

            describe file('/etc/apt/sources.list.d/owncloud.list') do
                it { should be_file }
                it { should exist }
            end

            it 'install role packages' do
                packages = Array[ 'apache2', 'openssl',
                                  'mysql-server',
                                  'owncloud', 'owncloud-server' ]

                packages.each do |pkg_name|
                    expect(package(pkg_name)).to be_installed
                end
            end

            describe 'should manage Apache configuration' do

                # Check all default endpoints removed
                removed_endpoints = Array[
                    '/etc/apache2/sites-enabled/000-default.conf',
                    '/etc/apache2/conf-enabled/owncloud.conf'
                ]

                removed_endpoints.each do |file_name|
                    describe file(file_name) do
                        it { should_not exist }
                    end
                end

                describe file('/etc/apache2/sites-available/owncloud.conf') do
                    it { should exist }
                    it { should be_file }
                end

                describe file('/etc/apache2/sites-enabled/owncloud.conf') do
                    it { should exist }
                    it { should be_symlink }
                end

                describe x509_certificate('/etc/ssl/certs/owncloud.pem') do
                    it { should be_certificate }
                    it { should be_valid }
                end

                describe x509_private_key('/etc/ssl/private/owncloud.key') do
                    certificate = '/etc/ssl/certs/owncloud.pem'
                    it { should_not be_encrypted }

                    # https://github.com/infOpen/ansible-role-owncloud/issues/1
                    if ENV['TRAVIS'].nil?
                        it { should be_valid }
                        it { should have_matching_certificate(certificate) }
                    end
                end

                describe port(80) do
                    it { should_not be_listening }
                end

                describe port(443) do
                    it { should be_listening }
                end
            end

            describe 'should manage Mysql configuration' do

                describe process('mysqld') do
                    it { should be_running }
                    its(:user) { should eq 'mysql' }
                end

                describe port(3306) do
                  it { should be_listening.on('127.0.0.1').with('tcp') }
                end
            end

      end # Debian and Ubuntu describe end
    end # Debian and Ubuntu if condition end
end # Top level describe end

