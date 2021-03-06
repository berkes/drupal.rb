require 'yaml'

class Drupal
  class Create_Module

    # Create a module using the module builing wizard.
    def run(arguments)
      @arguments = arguments
      @dir = @arguments[1] || '.' # TODO remove trailing slash, check validity, and existance
      self.check_module_name
      self.run_wizard
    end

    # Ensure module name is supplied and that it is
    # formatted correctly as module names must be alphanumeric
    # and must begin with a letter.
    def check_module_name
      case
        when @arguments.empty?; puts 'Module name required.'; exit 3
        when !@arguments[0].match(/^[a-z][\w]+/); puts 'Invalid module name.'; exit 4
        else @module = @arguments[0]
      end
    end

    # Run module generation wizard.
    def run_wizard
      # TODO create self.log() with padding to even output
      defaults = get_defaults

      # TODO make each ask have a commandline-option equivalent.
      @version = self.ask('What drupal version to scaffold for?:', defaults[:version])
      @author = self.ask('What is your name?:', defaults[:author])
      @link = self.ask('What is the URI to your companies website?:', defaults[:link])
      @email = self.ask('What is your email?:', defaults[:email])
      @module_name = self.ask('Enter a human readable name for your module:', defaults[:module_name])
      @table = self.ask('Database table name for your module. Without the modulename. A table name "pirates" on the module "cool_people" we would give us a table "cool_people_pirates" Leave empty for no database-scaffolding.')
      @module_description = self.ask('Enter a short description of your module:', defaults[:module_description])
      @module_dependencies = self.ask('Enter a list of dependencies for your module:', defaults[:module_dependencies], true)
      # Hooks
      puts self.list_templates('Hooks:', 'hooks')
      @hooks = self.ask('Which hooks would you like to implement?:', '', true)
      # Files
      puts self.list_templates('Files:', 'txt')
      @files = self.ask('Which additional files would you like to include?:', '', true)
      # Dirs
      puts "\nCommon directories:"
      puts ['js', 'images', 'css'].collect{ |d| " - " << d }
      @dirs = self.ask('Which directories would you like to create?:', '', true)
      # Finish
      self.create_tokens
      self.create_hook_weights
      self.create_module
    end

    # Create global tokens.
    def create_tokens
      if not @table.nil?
        @record = @table.singularize
      else
        @record = ''
      end
      
      @tokens = {
          :module => @module,
          :link => @link,
          :email => @email,
          :author => @author,
          :module_name => @module_name,
          :module_description => @module_description,
          :module_dependencies => @module_dependencies,
          :table => @table,
          :record => @record,
        }
    end

    # Register hook weights
    def create_hook_weights
      @hook_weights = [
          'perm',
          'cron',
          'boot',
          'init',
          'menu',
          'theme',
          'form_alter',
          'block',
        ]
    end

    # Create module from wizard results.
    def create_module
      puts "\n... Creating module '#{@module}' in '#{@dir}'"
      # Base directory
      create_dir("#{@module}")
      self.create_module_dirs
      self.create_module_files
      self.create_module_file
      self.create_module_database_files
      self.create_module_info_file
      puts 'Module created :)'
    end

    # Create directories.
    def create_module_dirs
      @dirs.each{ |dir| create_dir("#{@module}/#{dir}") }
    end

    # Create file templates.
    def create_module_files
      @files.each do |file|
        filepath = "#{file.upcase}.txt"
        create_file(filepath)
        append_template(filepath, "txt/#{file}", @tokens)
      end
    end

    # Create .module file.
    def create_module_file
      create_file("#{@module}.module", "<?php\n")
      append_template("#{@module}.module", 'comments/file', @tokens)
      append_template("#{@module}.module", 'comments/large', {'title' => 'Hook Implementations'})
      for hook in @hook_weights
        if @hooks.include?(hook)
          append_template("#{@module}.module", "hooks/#{hook}", @tokens)
        end
      end
    end

    # Create .install file, database includes and schema..
    def create_module_database_files
      if not @table.empty?
        create_file("#{@module}.install", "<?php\n")
        append_template("#{@module}.install", 'comments/file', @tokens)
        ['install', 'schema'].each do |hook|
          append_template("#{@module}.install", "incs/#{hook}", @tokens)
        end
        
        create_file("#{@module}_db.inc", "<?php\n")
        append_template("#{@module}_db.inc", 'comments/file_db', @tokens)
        append_template("#{@module}_db.inc", "incs/module_db", @tokens)
        
        append_template("#{@module}.module", "hooks/init", @tokens) unless @hooks.include('init')
      end
    end

    # Create info file.
    def create_module_info_file
      tokens = {
        'module_name' => @module_name,
        'module_description' => @module_description,
        'version' => @version,
      }

      if !@module_dependencies.nil?
        #In 6.x each dep has a new line. In 5.x they are on a single line.
        if (@version == '6.x')
          @module_dependencies.each do |dependency|
           tokens['dependencies_chunk'] = "\ndependencies[] = #{dependency}"
          end       
        elsif (@version == '5.x')
          tokens['dependencies_chunk'] = "dependencies = " + @module_dependencies.join(',')
        end
      end
      
      filepath = "#{@module}.info"
      create_file(filepath)
      append_template(filepath, "base/info", tokens)
    end

    # Create a new directory.
    def create_dir(dir)
      dir = "#{@dir}/#{dir}"
      puts "... Creating directory '#{dir}'"
      Dir.mkdir(dir)
    end

    # Create a new file.
    def create_file(filepath, contents = '')
      filepath = "#{@dir}/#{@module}/#{filepath}"
      puts "... Creating file '#{filepath}'"
      File.open(filepath, 'w') do |f|
        f.write contents
      end
    end

    # Append a tokenized template template to a file.
    def append_template(filepath, template, tokens = {})
      # TODO: ensure template exists
      # TODO: is \n included with STDIN?
      _template = template
      filepath = "#{@dir}/#{@module}/#{filepath}"
      template = get_template_location << template
      puts "... Adding template '#{_template}' to '#{filepath}'"
      contents = File.read(template)
      tokens.each_pair do |token, value|
        if value.class == String && contents.include?("[#{token}]")
          contents.gsub!(/\[#{token}\]/, value)
        end
      end
      File.open(filepath, 'a') do |f|
        f.write contents
      end
    end

    # Prompt user for input
    def ask(question, default = '', list = false)
      if not default.to_s.empty? then question = question << " (#{default})" end
      puts "\n" << question

      # TODO: support 'all'
      # TODO: why is gets not working?
      # TODO: not catching exception when CTRL+C ?
      begin
        case list
          when true; input = STDIN.gets.split
          when false; input = STDIN.gets.gsub!(/\n/, '')
        end
      rescue => e
        puts ':)'
      end

      if input.empty?
        return default
      else
        return input
      end
    end

    # List templates available of a certain type.
    def list_templates(title, type)
      "\n" << title << self.get_templates(type).collect{ |t| "\n - " << File.basename(t) }.join
    end

    # Get array of templates of a certain type.
    def get_templates(type)
      Dir[get_template_location << type << '/*']
    end


    private
    def get_template_location
      location = File.expand_path "~/.drupal.rb/templates/#{@version}"

      unless File.directory? location
        location = File.dirname(__FILE__) + "/templates/#{@version}"
      end

      return location + '/'
    end

    # @TODO: implement defaults that can be altered for list of hooks and files
    def get_defaults
      defaults = {}
      location = File.expand_path '~/.drupal.rb/defaults.yml'
      if File.readable? location
        defaults_yml = File.open( location ) { |yf| YAML::load( yf ) }

        # @TODO: There is most probably a much nicer Rubyism for this nested looping.
        # If you know Ruby better then I do, please chime in and change this.
        create_tokens().each do |token|
          defaults_yml.each do |d|
            if (d.has_key? token.first.to_s)
              defaults[token.first] = d[token.first.to_s]
            end
          end
        end
      else
        defaults = create_tokens
      end

      return defaults
    end
  end
end

