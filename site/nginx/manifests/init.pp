class nginx (
  $package = $nginx::params::package,
  $owner   = $nginx::params::owner,
  $group   = $nginx::params::group,
  $confdir = $nginx::params::confdir,
  $logdir  = $nginx::params::logdir,
  $docroot = $nginx::params::docroot,
  $root    = $nginx::params::root,
) inherits nginx::params {
  case $::osfamily {
    'redhat', 'debian': {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
      $docroot = $root ? {
        'nothing' => '/var/www',
        default   => $root,
      }
    }
    'windows': {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'
      $docroot = $root ? {
        'nothing' => 'C:/ProgramData/nginx/html',
        default   => $root,
      }
    }
    default: { fail("OS Family ${::osfamily} is not supported with this nginx module") }
  }

  ## Because Redhat and Debian are different here, we can't specify the user of
  ## of the nginx service in the big case statement above. Thus we have the
  ## selector here...
  $user = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
  
  File {
    owner => $owner,
    group => $group,
    mode  => '0644',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  package { 'nginx':
    ensure => installed,
    name   => $package,
  }
  
  file { "${confdir}/nginx.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => template('nginx/nginx.conf.erb'),
  }
  
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    #source => 'puppet:///modules/nginx/default.conf',
    content => template('nginx/default.conf.erb'),
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
  
  file { $docroot:
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
