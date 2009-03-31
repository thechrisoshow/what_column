class WhatColumnizer

  HEADER = "=== List of columns ==="
  FOOTER = "======================="

  def self.columnize
    decolumnize
    Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '**', '*')].each do |dir|
      next if File.directory?(dir)
      columnize_file(dir)
    end
  end

  def self.decolumnize
    Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '**', '*')].each do |dir|
      next if File.directory?(dir)      
      decolumnize_file(dir)
    end
  end

  private
  def self.columnize_file(filepath)
    File.open(filepath, "r+") do |file|
      if file.read.match(/class (.*)\</)
        ar_class = $1.strip.constantize

        if ar_class.respond_to?(:columns)

          file.rewind
          lines = file.readlines
          lines.unshift "# " + FOOTER + "\n"
          ar_class.columns.reverse.each do |column|
            lines.unshift "#   #{column.name}: #{column.type.to_s}" + "\n"        
          end

          lines.unshift "# " + HEADER + "\n"
          file.pos = 0
          file.print lines
          file.truncate(file.pos)

        end
      end
    end
  end

  def self.decolumnize_file(filepath)
    File.open(filepath, 'r+') do |file|
      lines = file.readlines
      removing_what_columns = false
      out = ""
      lines.each do |line|

        if line.match /^# #{HEADER}$/
          removing_what_columns = true
        end

        out << line unless removing_what_columns

        if line.match /^# #{FOOTER}$/
          removing_what_columns = false
        end

      end    
      file.pos = 0
      file.puts out
      file.truncate(file.pos)      
    end
  end

end