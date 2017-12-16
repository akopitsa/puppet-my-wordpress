class wordpress::wp (
    String $file_name = $wordpress::conf::file_name
) {

    # Copy the Wordpress bundle to /tmp
    file { '/tmp/latest.tar.gz':
        ensure => present,
        source => "puppet:///modules/wordpress/$file_name"
    }

    # Extract the Wordpress bundle
    exec { 'extract':
        cwd => "/tmp",
        command => "tar -xvzf $file_name",
        require => File['/tmp/latest.tar.gz'],
        path => ['/bin'],
    }

    # Copy to /var/www/
    exec { 'copy':
        command => "cp -r /tmp/wordpress/* /var/www/html",
        require => Exec['extract'],
        path => ['/bin'],
    }

    # Generate the wp-config.php file using the template
    file { '/var/www/html/wp-config.php':
        ensure => present,
        require => Exec['copy'],
        content => template("wordpress/wp-config-sample.php.erb")
    }

    file {'/var/www/html/index.html':
        ensure => absent,
    }
}
