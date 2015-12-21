#
# Cookbook Name:: dude
# Spec:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

require "spec_helper"

describe "dude::default" do
  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "sets up the dude service in runit" do
    expect(chef_run).to enable_runit_service("dude").with(
      default_logger: true
    )
  end
end
