# rubocop:disable Style/SingleSpaceBeforeFirstArg
name             "dude"
maintainer       "sweeper.io"
maintainer_email "developers@sweeper.io"
license          "mit"
description      "Installs and configures dude"
long_description "Installs and configures dude"
version          "0.1.1"
# rubocop:enable Style/SingleSpaceBeforeFirstArg

supports "ubuntu"

depends "apt", "~> 2.0"
depends "runit", "~> 1.0"

chef_version ">= 12.5" if respond_to?(:chef_version)
source_url "https://github.com/sweeperio/chef-dude" if respond_to?(:source_url)
issues_url "https://github.com/sweeperio/chef-dude/issues" if respond_to?(:issues_url)
