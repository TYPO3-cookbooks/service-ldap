name "service-ldap"
maintainer       "TYPO3 Association"
maintainer_email "fabien.udriot@typo3.org"
license          "Apache 2.0"
description      "Installs/Configures docs.typo3.org"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

#_packages
depends "apt", '~> 2.3.0'
depends "openldap", '~> 2.1.0'
