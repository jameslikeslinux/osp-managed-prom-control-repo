class profile::foreman {
  include foreman::repo
  include foreman
  include foreman::plugin::puppet

  class { 'foreman_proxy':
    puppet   => true,
    puppetca => false,
    tftp     => false,
    dhcp     => false,
    dns      => false,
    bmc      => false,
    realm    => false,
  }

  group { 'puppet':
    system => true,
  }

  user { 'puppet':
    gid    => 'puppet',
    system => true,
  }

  # Foreman uses Puppet keys by default; make them readable
  file { '/etc/puppetlabs/puppet/ssl':
    owner   => 'puppet',
    group   => 'puppet',
    recurse => true,
    before  => Class['foreman'],
  }
}
