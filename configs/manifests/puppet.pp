# execute 'apt-get update'
exec { 'apt-update':
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => 'apt-get update'
}

exec { 'add-docker-apt1':
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -',
}

exec { 'add-docker-apt2':
    require => Exec['add-docker-apt1'],
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => 'sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
}


package { ['docker-ce','docker-compose','net-tools'] :
    require => Exec['apt-update','add-docker-apt2'],
    ensure => installed,
}

exec { 'add-docker-sudo':
    require => Package['docker-ce'],
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => 'usermod -aG docker $(whoami)',
}
