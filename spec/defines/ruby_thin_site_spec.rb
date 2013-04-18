require 'spec_helper'

describe 'thin::site', :type => :define do
  let(:title) { 'test_site' }
  let(:params) { { 'chdir' => '/var/somewhere' } }

  it { should contain_file('/etc/thin/test_site.yml') }
  it { should contain_service('thin-test_site') }
  it { should contain_file('/var/log/test_site') }

  context "when setting parameters" do
    let(:params) { {
      :chdir                => '/var/somewhere',
      :address              => '127.0.0.1',
      :daemonize            => false,
      :environment          => 'development',
      :log                  => '/var/log/somelog',
      :group                => 'groupname',
      :max_conns            => 123,
      :max_persistent_conns => 12,
      :pid                  => '/var/myapp/lock',
      :port                 => 4567,
      :servers              => 1,
      :timeout              => 10,
      :user                 => 'username'
    } }

    it { should contain_file('/etc/thin/test_site.yml').with_content(/chdir:\s\/var\/somewhere/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/address:\s127\.0\.0\.1/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/port:\s4567/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/pid:\s\/var\/myapp\/lock/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/log:\s\/var\/log\/somelog/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/timeout:\s10/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/max_conns:\s123/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/environment:\sdevelopment/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/max_persistent_conns:\s12/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/servers:\s1/) }
    it { should contain_file('/etc/thin/test_site.yml').with_content(/group:\sgroupname/) }

  end
end