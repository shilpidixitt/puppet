### If O is Redhat, then install http, create index.html and start the service. if there is changes in index.html, service should be reloaded as well.
#############

if $facts['os']['family'] == 'Redhat' {





package { 'httpd':
  ensure => 'installed', #'absent', 'purged','latest','4.1'
  #name => 'http', #not used here as we make use of title
  provider => 'yum', #normally not requied
}

service { 'httpd':
  ensure => 'running', #'stopped',
  #name => 'http', #Useful where service name differs,
  enable => true, #false
  subscribe => File['/var/www/html/index.html'],
}


 

file { '/var/www/html/index.html':
  ensure => 'file',
  content => 'Welcome to my Server',
  notify => Service['httpd'],
 }



}
