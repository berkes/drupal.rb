require 'helper'

class TestDrupalRb < Test::Unit::TestCase
  context "Update" do
    setup do
      @cache_path = File.join(File.dirname(__FILE__), '..', 'cache')
      @cache_file = File.join(@cache_path, 'projects.xml')
    end
    
    should "cache directory must be writable" do
      assert File.new(File.join(@cache_path, 'test'), 'w+')
      assert File.unlink(File.join(@cache_path, 'test'))
    end

    should "file should be downloaded" do
      Drupal::Update.new.run(1)
      assert File.exists? @cache_file
    end
    
    should "file must be accessed just now" do
      assert File.new(@cache_file).ctime <= Time.now() #@TODO: a better bandwith to test agains: something like 'updated in last 2 minutes?
    end
    
    should "file must not be empty" do
      assert File.size?(@cache_file)
    end    
  end
end
