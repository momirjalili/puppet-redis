require 'spec_helper'

describe 'redis::user' do
  let(:title) { 'test_user' }

  it { is_expected.to contain_class('redis::user') }

  it do
    is_expected.to contain_file('/etc/redis/users.acl').with({
      'username' => 'test_user',
      'password' => 'test_pass',
      'status' => 'on',
      'acl_rules' => '~* &* +@all',
      'aclfile' => '/etc/redis/users.acl',
      'config_file_mode' => '0644',
      'config_owner' => 'redis',
      'config_group' => 'redis',
    })

  context 'with username => test_user' do
    let(:params) { { 'compress' => true }}

    it do
      is_expected.to contain_file('/etc/redis/users.acl') \
        .with_content(/^\s*test_user$/)
    end
  end
end
