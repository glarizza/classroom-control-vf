class memcached {
  ## Manage the package
  package { 'memcached':
    ensure => present,
  }
  
  ## Manage the file
  file { '/etc/sysconfig/memcached':
    ensure  => file,
    source  => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
    notify  => Service['memcached'],
  }
  
  ## Manage the service
  service { 'memcached':
    ensure => running,
    enable => true,
  }
}
