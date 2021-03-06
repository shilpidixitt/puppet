if $facts['os']['family'] == 'Redhat' {

notify {'Hello World': }

file { '/etc/motd1' :
  ensure => 'file',
  content => 'Welcome to my server',
}

file { 'Message File':
  ensure => 'file',
  content => 'Welcome to my server',
  path => '/etc/motd',
}




package { 'httpd':
  ensure => 'installed', #'absent', 'purged','latest','4.1'
  #name => 'http', #not used here as we make use of title
  provider => 'yum', #normally not requied
}

service { 'httpd':
  ensure => 'running', #'stopped',
  #name => 'http', #Useful where service name differs,
  enable => true, #false
}

package { 'ntp':
  ensure => 'installed', #'absent', 'purged','latest','4.1'
  #name => 'ntp', #not used here as we make use of title
  provider => 'yum', #normally not requied
}

service { 'ntpd':
  ensure => 'running', #'stopped',
  #name => 'ntp', #Useful where service name differs,
  enable => true, #false
}

$ntp_conf = '#Managed by Puppet server 192.168.0. iburst driftfile /var/lib/ntp/drift'
 

file { '/etc/ntp.conf':
  ensure => 'file',
  content => $ntp_conf, }



group { 'sudo': 
  ensure => 'present'}

user { 'bob':
  ensure => 'present',
  managehome => true,
  groups => ['sudo', 'users'],
  password => pw_hash('Password1','SHA-512','salt'),
}


## following resource for host entry

host{ 'timeserver':
  ip   => '192.168.0.3',
  host_aliases => 'tock',
}

}
