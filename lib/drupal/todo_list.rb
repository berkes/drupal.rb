
class Drupal
  class Todo_List
    
    # Run todo list
    def run(arguments)
      @total = 0
      @arguments = arguments
      @total_only = true if @arguments[0] == 'total'
      @arguments.shift if @total_only == true
      parse_dir('.') if @arguments.empty?
      for argument in @arguments
        parse_file(argument) if File.file?(argument)
        parse_dir(argument) if File.directory?(argument)
      end
      puts "Total todo items: #{@total}" if @total_only == true
    end
    
    # Parse file for todo items.
    def parse_file(filepath)
      File.open(filepath) do |file|
        items = []
        linenumber = 0
        file.each_line do |line|
          linenumber += 1
          if summary = ToDo.extract_summary(line)
            context = ToDo.extract_context(linenumber, file)
            item = ToDo.new(linenumber, summary, context)
            @total += 1
            items << item.to_s
          end
        end
        puts "\n" + filepath unless items.empty? || @total_only == true
        items.each{ |item| puts item } unless @total_only == true
      end
    end
    
    # Parse directory for todo items.
    def parse_dir(dir)
      Dir["#{dir == '.' ? '.' : dir}/**/*"].each do |file|
        parse_file(file) if File.file?(file)
      end
    end
  end
end

# TODO: example.
class ToDo
  attr_accessor :linenumber, :summary, :context
  
  def initialize (linenumber, summary, context)
    @linenumber = linenumber
    @summary = summary
    @context = context
  end
  
  def to_s
    "#{@linenumber}: #{@summary}\n#{@context}\n"
  end
  
  def ToDo.extract_summary(line)
    matches = line.match /(?:#|\/\/|\/\*|@)[\s]*todo:?[\s]*(.+)$/i
    matches[1] unless matches.nil? || matches.length <= 0
  end
  
  def ToDo.extract_context(linenumber, file)
    file.rewind
    list = file.to_a
    #rewind one line (one line above) then add the line itself and three lines below.
    list.slice!(linenumber - 1, 5)
  end
end
