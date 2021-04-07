# defining acl users for redis
define redis::user (
  String $username,
  String $password,
  String $status,
  String $acl_rules,
  String $aclfile = $redis::aclfile,
  Stdlib::Filemode $config_file_mode        = $redis::config_file_mode,
  String[1] $config_group                  = $redis::config_group,
  String[1] $config_owner                  = $redis::config_owner,
) {
  if $aclfile {
    concat { $aclfile:
      owner => $config_owner,
      group => $config_group,
      mode  => $config_file_mode,
    }

    concat::fragment { 'user':
      target  => $aclfile,
      content => "user ${username} ${status} ${acl_rules} >${password} \n",
    }
  } else {
    fail('redis::aclfile: needs to have a value')
  }
}
