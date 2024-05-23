class profile::puppet_agent {
  class { 'puppet':
    agent_server_hostname => 'osp',
  }
}
