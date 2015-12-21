#
# Cookbook Name:: dude
# Recipe:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

include_recipe "runit"

template_options = {
  chpst:  node["runit"]["chpst_bin"],
  user:   node["dude"]["run_as_user"],
  path:   node["dude"]["install_dir"]
}

package "ruby"
gem_package "bundler"

runit_service "dude" do
  default_logger true
  options template_options.merge(params)
end
