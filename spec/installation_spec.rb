require 'serverspec'

describe 'owncloud Ansible role' do

if ['debian', 'ubuntu'].include?(os[:family])
    describe 'Specific Debian and Ubuntu family checks' do

        describe file('/etc/apt/sources.list.d/owncloud.list') do
            it { should be_file }
            it { should exist }
        end

        it 'install role packages' do
            packages = Array[ 'owncloud', 'owncloud-server' ]

            packages.each do |pkg_name|
                expect(package(pkg_name)).to be_installed
            end
        end

    end
end

end

