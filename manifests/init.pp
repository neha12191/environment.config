class jenkins {
    # get key
    exec { 'install_jenkins_key':
        command => 'wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -',
        #command => 'wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
    }
    # update
    exec { 'apt-get update':
        command => 'apt-get update',
        require => File['/etc/apt/sources.list.d/jenkins.list'],
    }

    # source file
    file { '/etc/apt/sources.list.d/jenkins.list':
        content => "deb http://pkg.jenkins-ci.org/debian binary/\n",
        #content => "deb https://pkg.jenkins.io/debian-stable binary/\n",
        mode    => '0644',
        owner   => root,
        group   => root,
        require => Exec['install_jenkins_key'],
    }

    # jenkins package
    package { 'jenkins':
        ensure  => latest,
        require => Exec['apt-get update'],
    }

    # jenkins service
    service { 'jenkins':
        ensure  => running,
        require => Package['jenkins'],
    }
}
