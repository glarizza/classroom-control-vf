
# $REPO/site/users/manifests/managed_user.pp

define users::managed_user (
  $username  = $title,
  $uid       = undef,
  $groupname = undef,
  $homedir   = "/home/${title}",
) {
  File {
    owner  => $username,
    group  => $groupname,
    mode   => '0644',
  }

  user { $username:
    ensure => present,
    uid    => $uid,
    gid    => $groupname,
    home   => $homedir,
  }

  group { $username:
    ensure => present,
    name   => $groupname,
  }

  file { [ $homedir, "${homedir}/.ssh" ]: 
    ensure => directory
  }
}
