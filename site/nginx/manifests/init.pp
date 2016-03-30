class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  $confdir = '/etc/nginx'
  
  package { 'nginx':
    ensure => installed,
  }
  
  file { "${confdir}/nginx.conf":
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
  
  file { '/var/www/':
    ensure => directory,
  }
  
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
