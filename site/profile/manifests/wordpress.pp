

class profile::wordpress {
  ## Mysql Server
  class { 'mysql::server':
    root_password => 'puppetlabs',
  }

  class { 'mysql::bindings':
    php_enable => true,
  }

  ## Wordpress config
  include ::wordpress

  ## Apache VHost Config
  include apache
  include apache::mod::php
  apache::vhost { $::fqdn:
    port     => '80',
    priority => '00',
    docroot  => '/opt/wordpress',
  }
}
