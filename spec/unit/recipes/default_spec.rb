#
# Cookbook Name:: dude
# Spec:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

require "spec_helper"

describe "dude::default" do
  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node|
      node.set["dude"]["run_as_user"] = "run_user"
      node.set["dude"]["install_dir"] = "/path"
      node.set["runit"]["chpst_bin"]  = "/usr/bin/chpst"
    end

    runner.converge(described_recipe)
  end

  it "includes the runit recipe" do
    expect(chef_run).to include_recipe("runit")
  end

  it "installs ruby" do
    expect(chef_run).to install_package("ruby")
  end

  it "installs bundler (if necessary)" do
    expect(chef_run).to install_gem_package("bundler")
  end

  it "sets up the dude service in runit" do
    expect(chef_run).to enable_runit_service("dude").with(
      default_logger: true,
      options: {
        chpst: "/usr/bin/chpst",
        user: "run_user",
        path: "/path"
      }
    )
  end
end
