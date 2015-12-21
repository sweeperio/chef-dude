require "spec_helper"

describe "dude::default" do
  describe file("/etc/service/dude") do
    it { should exist }
    it { should be_directory }
    it { should be_symlink }
    it { should be_linked_to "/etc/sv/dude" }
  end
end
