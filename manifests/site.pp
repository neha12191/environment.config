## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
#node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
#}
class {'java' :
   distribution => 'jre',
}
tomcat::install { '/opt/tomcat':
 source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.x/bin/apache-tomcat-7.0.x.tar.gz',
}
tomcat::instance { 'default':
 catalina_home => '/opt/tomcat',
}
tomcat::config::server { 'tomcat7':
  catalina_base => '/opt/tomcat7',
  port          => '8105',
}
tomcat::config::server::connector { 'tomcat7-http':
  catalina_base         => '/opt/tomcat7',
  port                  => '8180',
  protocol              => 'HTTP/1.1',
  additional_attributes => {
    'redirectPort' => '8543'
  },
}
tomcat::config::server::connector { 'tomcat7-ajp':
  catalina_base         => '/opt/tomcat7',
  port                  => '8109',
  protocol              => 'AJP/1.3',
  additional_attributes => {
    'redirectPort' => '8543'
  },
}
tomcat::war { 'sample.war':
  catalina_base => '/opt/tomcat9/first',
  war_source    => '/opt/tomcat9/webapps/docs/appdev/sample/sample.war',
}
