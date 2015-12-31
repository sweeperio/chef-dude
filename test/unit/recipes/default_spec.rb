#
# Cookbook Name:: dude
# Spec:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2015 sweeper.io
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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

  it "does not install ruby" do
    expect(chef_run).to_not install_package("ruby")
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

  context "with the test_run flag set" do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["test_run"] = true
      end

      runner.converge(described_recipe)
    end

    it "installs ruby (for testing)" do
      expect(chef_run).to install_package("ruby")
    end
  end
end
