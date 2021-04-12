# defining acl users for redis
define redis::user (
  String $username,
  String $password,
  String $status,
  String $acl_rules,
  Optional[String] $aclfile                = $redis::aclfile,
  Stdlib::Filemode $config_file_mode        = $redis::config_file_mode,
  String[1] $config_group                  = $redis::config_group,
  String[1] $config_owner                  = $redis::config_owner,
  Stdlib::Absolutepath $config_file         = $redis::config_file,
) {
  if $aclfile {
    concat::fragment { "redis_user_fragment_${username}":
      target  => $aclfile,
      content => "user ${username} ${status} ${acl_rules} >${password} \n",
    }
  }
}
