class wordpress::db {
  class {'::mysql::server':
    root_password => $wordpress::conf::root_password,

    databases => {
      "${wordpress::conf::db_name}" => {
        ensure => 'present',
        charset => 'utf8'
      }
    },

    users => {
      "${wordpress::conf::db_user_host}" => {
        ensure => 'present',
        password_hash => mysql_password("${wordpress::conf::db_user_password}")
      }
    },
    grants => {
      "${wordpress::conf::db_user_host_db}" => {
        ensure => 'present',
        options => ['GRANT'],
        privileges => ['ALL'],
        table => "${wordpress::conf::db_name}.*",
        user => "${wordpress::conf::db_user_host}",
      }
    },
  }

  class { '::mysql::client':
    require => Class['::mysql::server'],
    bindings_enable => true
  }
}
