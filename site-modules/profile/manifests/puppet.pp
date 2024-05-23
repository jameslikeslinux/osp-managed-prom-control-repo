class profile::puppet (
  Boolean $server = false,
) {
  if $server {
    class { 'puppet':
      agent_server_hostname => $trusted['certname'],
      autosign              => true,
      environment           => 'production',
      server                => true,
      server_external_nodes => '',
      server_foreman        => false,
      server_reports        => 'puppetdb',
      server_storeconfigs   => true,
    }

    include puppetdb

    class { 'puppet::server::puppetdb':
      server => $trusted['certname'],
    }

    class { 'r10k':
      cachedir => '/var/r10k',
      sources  => {
        'control-repo' => {
          'remote'  => 'https://github.com/jameslikeslinux/osp-workshop-control-repo.git',
          'basedir' => '/etc/puppetlabs/code/environments',
        },
      },
    }
  } else {
    class { 'puppet':
      agent_server_hostname => 'osp',
    }
  }
}
