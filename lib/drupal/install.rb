require 'zlib'
require 'net/http'
require 'rexml/document'

class Drupal
  class Install
    include REXML
    # Attempt to download core installation or module.
    def run(arguments)
      @project = arguments[0]
      @dest = arguments[1] || '.'
      @version = arguments[2] || '6.x'
      abort "Destination #{@dest} is not a directory." unless File.directory?(@dest)
      abort 'Project name required (core | <project>).' if arguments.empty?
      install_projects
    end

    def debug(message)
      puts '... ' + message
    end

    # Install single project or iterate lists.
    def install_projects
      if @project.include? ','
        projects = @project.split ','
        projects.each do |p|
          @project = p
          check_core
          install_project
          puts
        end
      else
        check_core
        install_project
      end
    end

    # Check if the destination is empty.
    def destination_empty?
      Dir['*'].length == 0
    end

    # Allow users to type 'core' instead of 'drupal install drupal'
    def check_core
      @project = 'drupal' if @project =~ /^core|drupal$/
    end

    # Check if a uri is available.
    def uri_available?(uri)
      open(uri) rescue false
    end

    # Install project.
    # @TODO move all the updates.drupal.org xml parsing into a separate Class
    def install_project
      xmldoc = get_xml(@project, @version)
      release = get_release(xmldoc, 'latest')
      @tarpath = get_tarball(release)

      # Extract tarball
      @pwd = Dir.getwd
      Dir.chdir File.dirname(@tarpath) and debug "Changed cwd to #{File.dirname(@tarpath)}" unless @dest == '.'
      Kernel.system "tar -xf #{@tarpath}" rescue abort "Failed to extract #{@tarpath}"
      Dir.chdir @pwd and debug "Reverted cwd back to #{@pwd}" unless @dest == '.'

      # Remove tarball
      Kernel.system "rm #{@tarpath}" rescue abort "Failed to remove #{@tarpath}"

      # Installation complete
      debug "Project installed to #{File.dirname(@tarpath)}" unless @dest == '.'
      debug 'Installation complete'
    end

    def get_xml project, version='6.x'
      debug "Locating #{project} page"
      # Locate tarball from project page
      begin
        response = Net::HTTP.get_response(URI.parse("http://updates.drupal.org/release-history/#{project}/#{version}"))
        # TODO: unhardcode the dependency on Drupal 6, make this an environment or static var.
        # TODO: check 404, 403 etc.
        xmldoc = Document.new response.body
        if xmldoc.root.name == 'error' #TODO: better error handling here.
          message = xmldoc.root.text
          raise message
        end
      rescue
        debug "Could not fetch #{project}. Error: #{message}"
      end

      return xmldoc
    end

    def get_releases(xmldoc)
      releases = Hash.new

      xmldoc.root.each_element('//release') do |release|
        releases[release.text('version')] = release
      end

      return releases
    end

    # returns the release with releasenumber 'which' from xmldoc.
    # use 'latest' for which, if you want the latest stable release
    def get_release(xmldoc, which)
      releases = get_releases(xmldoc)

      ordered = releases.keys.sort_by {|k| k.to_s.split(/\.|-/).map {|v| v.to_i} }

      if ( which == 'latest' )
        release = releases[ordered.last]
      elsif ordered.include? which
        release = releases[which]
      else
        raise "Failed to find requested release #{which}"
      end

      return release
    end

    def get_tarball(release)
      tarball = release.elements['//download_link'].text
      tarpath = File.basename(tarball)

      abort "Failed to find Drupal 6 tar of #{@project}" if tarball.nil?
      debug "Found tarball #{tarball}"

      # Fetch tarball
      begin
        response = Net::HTTP.get_response(URI.parse(tarball))
        puts tarpath
        File.open(tarpath, 'w') do |f|
          f.write response.body
        end
        debug "Copied tarball to #{tarpath}"
      rescue
        abort "Failed to copy remote tarball #{tarball} to #{tarpath}"
      end

      return tarpath
    end
  end
end
