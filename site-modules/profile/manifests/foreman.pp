class profile::foreman {
  include foreman::repo
  include foreman

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
