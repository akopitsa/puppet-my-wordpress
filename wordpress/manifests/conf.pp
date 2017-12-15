class wordpress::conf {
  $root_password = 'password'
  $db_name = 'wordpress'
  $db_user = 'wp'
  $db_user_password = 'password'
  $db_host = 'localhost'

  $db_user_host = "${db_user}@${db_host}"
  $db_user_host_db = "${db_user}@${db_host}/${db_name}.*"
}
