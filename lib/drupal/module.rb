  class Module
    require 'libxml'
    include LibXML
    
    def list
      document = get_cache
      projs = document.find("/projects")
      projs.each do |project|
         project.short_name.to_s
      end
    end
    
    
    private
      
    def get_cache
      #cache_path = File.join(File.dirname(__FILE__), '..', '..', 'cache') #TODO: we want a cache class, not such ugly hardcoded stuff lying around.
      #cache_file = File.join(cache_path, 'projects.xml')
      cache_file = 'cache/projects.xml'
      
      begin 
        return doc = XML::Document.file(cache_file)
      rescue Exception => e 
        abort "Could not open release-history. Error: #{e.message}"
      end
    end
    
  end

mod = Module.new
mod.list

