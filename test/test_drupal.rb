require 'helper'

class TestDrupalRb < Test::Unit::TestCase
  context "Update" do
    setup do
      start_time = Time.new()
      Update.all
      cache_path = File.join(File.dirname(__FILE__), '..', 'cache')
      cache_file = File.join(cache_path, 'projects.xml')
    end
    
    should "cache directory must be writable" do
      assert File.new('test', 'w+')
      assert File.unlink('test')
    end

    should "file must exist" do
      assert File.exists? cache_file
    end
    
    should "file must be accessed just now" do
      assert File.new(cache_file).ctime >= start_time
    end
    
    should "file must not be empty" do
      assert File.size?(cache_file)
    end
    
  end
end
