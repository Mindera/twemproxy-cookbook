name             'twemproxy'
maintainer       'Miguel Fonseca'
maintainer_email 'miguel.fonseca@mindera.com'
license          'MIT'
description      'Installs/Configures twemproxy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports 'centos'
supports 'redhat'

depends 'build-essential', '~> 2.2.3'
depends 'ark', '~> 0.9.0'
