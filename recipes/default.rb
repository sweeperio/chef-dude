#
# Cookbook Name:: dude
# Recipe:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

runit_service "dude" do
  default_logger true
  options({ install_dir: "/home" }.merge(params))
end
