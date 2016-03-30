class users::admins {
  users::managed_user { 'gary': }

  users::managed_user { 'elvis':
    username  => 'theking',
    groupname => 'neverland',
  }

  users::managed_user { 'luke':
    homedir => '/var/tmp/luke',
  }
}
