

class profile::wordpress {
  ## Mysql Server
  include mysql::server
  class { 'mysql::bindings':
    php_enable => true,
  }

  ## Wordpress config
  include ::wordpress

  ## Apache VHost Config
  include apache
  apache::vhost { $::fqdn:
    port     => '80',
    priority => '00',
    docroot  => '/opt/wordpress',
  }
}
