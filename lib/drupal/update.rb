require 'net/http'

class Drupal
  class Update
    def run (options)
      # Locate tarball from project page
      updates_location = "http://updates.drupal.org/release-history/project-list/all"
        #@TODO: make this into a resources list and foreach trough them, 
        #       so you can provide your own repository. Like sources.list in apt.
      cache_path = File.join(File.dirname(__FILE__), '..', '..', 'cache')
      cache_file = File.join(cache_path, 'projects.xml')

      begin
        response = Net::HTTP.get_response(URI.parse(updates_location))
      rescue Exception => e 
        abort "Could not fetch release-history. Error: #{e.message}"
      end
      
      begin
        File.open(cache_file, 'w') do |file|
          file.puts response.body
        end
      rescue Exception => e 
        abort "Could not write release-history. Error: #{e.message}"
      end
    end
  end
end
