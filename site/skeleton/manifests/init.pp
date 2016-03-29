class skeleton {
  ## Manage /etc/skel directory
  file { '/etc/skel':
    ensure => directory,
  }
  
  ## Manage /etc/skel/.bashrc file
  ##   NOTE: Source the file from the module
  ##   NOTE: Copy from /etc/skel/.bashrc in your container and modify it a bit
  file { '/etc/skel/.bashrc':
    ensure => file,
    source => 'puppet:///modules/skeleton/.bashrc',
  }
}
