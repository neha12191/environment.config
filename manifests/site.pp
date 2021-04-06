## site.pp ##
Exec {
    path => ['/bin', '/usr/bin'],
}
File { backup => false }

node default {
  include jenkins

class { 'java':
   distribution => 'jre',
 }
class { 'tomcat': }
tomcat::install { '/opt/tomcat':
  #source_url => 'https://www.mirrorservice.org/sites/ftp.apache.org/tomcat/tomcat-8/v8.5.63/src/apache-tomcat-8.5.63-src.tar.gz',
  #source_url => 'https://www.mirrorservice.org/sites/ftp.apache.org/tomcat/tomcat-8/v8.5.63/bin/apache-tomcat-8.5.63.tar.gz',
  source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.63/bin/apache-tomcat-8.5.63.tar.gz',
}
tomcat::instance { 'default':
  catalina_home => '/opt/tomcat',
}
}

