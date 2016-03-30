
# $REPO/site/users/manifests/managed_user.pp

define users::managed_user (
  $username  = $title,
  $uid       = undef,
  $groupname = $title,
  $homedir   = "/home/${username}",
) {
  File {
    owner  => $username,
    group  => $groupname,
    mode   => '0644',
  }

  user { $title:
    ensure => present,
    uid    => $uid,
    gid    => $groupname,
    home   => $homedir,
    name   => $username,
  }

  group { $title:
    ensure => present,
    name   => $groupname,
  }

  file { [ $homedir, "${homedir}/.ssh" ]: 
    ensure => directory
  }
}
