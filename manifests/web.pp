class wordpress::web () {
  class {'apache':
    mpm_module => prefork
  }
  class { '::apache::mod::php': }

}
