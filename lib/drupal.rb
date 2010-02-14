require 'optparse'
require 'ostruct'
require File.join(File.dirname(__FILE__), 'drupal', 'update.rb')

class Drupal

  MAJOR = 0
  MINOR = 0
  TINY = 11
  VERSION = [MAJOR, MINOR, TINY].join('.')
  
  def run(arguments)
    abort 'Arguments required. Use --help for additional information.' if arguments.empty?

    options = parse_options arguments
    handler = determine_handler arguments
    
    execute_handler(handler, options)
  end
  
  def parse_options(arguments)
    options = OpenStruct.new
    commands = ['update', 'install', 'upgrade', 'generate']
    
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: drupal command [options]"

      opts.separator ""
      opts.separator "Command:"
      opts.separator "one of #{ commands.join(', ') }"
      
      opts.separator ""
      opts.separator "Specific options:"
      
      opts.separator "Common options:"
      opts.on_tail('-h', '--help', 'Show (this) help') do
        puts opts
        exit
      end

      opts.on_tail('--version', 'Show version') do
        output_version
      end
    end

    opts.parse!(arguments)
    options 
  end
    
  # Determine handler based on the current arguments.
  def determine_handler(arguments)
    handler = arguments.shift.capitalize
    while !arguments.empty? && !is_handler(handler) do
      handler << '_' + arguments.shift.capitalize
    end
    return handler
  end

  # Execute the handler if it was found.
  def execute_handler(handler, options)
    abort 'Invalid command.' if !is_handler(handler) #@TODO: move into argument-parsing logic.
    eval("Drupal::#{handler}.new.run(options)")
  end
  
  # Check existance of a handler.
  def is_handler(klass)
    Drupal.const_defined?(klass) 
  end
  
  def output_help
    puts "@TODO: parse README rdoc here"
  end

  # Output version information.
  def output_version
    puts "Version #{Drupal::VERSION}"
    exit
  end
end
