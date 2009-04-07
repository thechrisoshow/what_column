module WhatColumn
  class Columnizer

    HEADER = "# === List of columns ==="
    FOOTER = "# ======================="

    def add_column_details_to_models
      remove_column_details_from_models    
      Dir[File.join(RAILS_ROOT, 'app', 'models', '**', '*')].each do |dir|
        next if File.directory?(dir)
        add_column_details_to_file(dir)
      end
    end

    def remove_column_details_from_models
      Dir[File.join(RAILS_ROOT, 'app', 'models', '**', '*')].each do |dir|
        next if File.directory?(dir)      
        remove_column_details_from_file(dir)
      end
    end

    private
    def add_column_details_to_file(filepath)
      File.open(filepath, "r+") do |file|
        if file.read.match(/class (.*)\</)
          ar_class = $1.strip.constantize

          if ar_class.respond_to?(:columns)

            max_width = ar_class.columns.map {|c| c.name.length + 1}.max
            # the format string is used to line up the column types correctly
            format_string = "#   %-#{max_width}s: %s \n"
            
            file.rewind            
            read_lines = file.readlines
            output_lines = []
            # find the lines that start with the appropriate class
            read_lines.each do |line|
              output_lines << line
              if line.match(/class (.*)\</) and $1.strip.constantize == ar_class
                output_lines << "\n" + HEADER + "\n"
                ar_class.columns.each do |column|
                  values = [column.name, column.type.to_s]
                  output_lines << format_string % values
                end
                output_lines << FOOTER + "\n\n"

              end
            end
            
            file.pos = 0
            file.print output_lines
            file.truncate(file.pos)

          end
        end
      end
    end

    def remove_column_details_from_file(filepath)
      File.open(filepath, 'r+') do |file|
        lines = file.readlines
        removing_what_columns = false
        out = []
        lines.each_with_index do |line, index|
          if line.match(/^#{HEADER}$/)
            removing_what_columns = true
            # And remove previous empty line
            out.pop if out.last == "\n"
          end


          previous_line = index > 0 ? lines[index - 1] : ""
          if !should_remove_line(removing_what_columns, line, previous_line)
            out << line
          end

          if line.match(/^#{FOOTER}$/)
            removing_what_columns = false
          end

        end    
        file.pos = 0
        file.puts out
        file.truncate(file.pos)      
      end
    end
    
    def should_remove_line(removing_what_columns, line, previous_line)
      (removing_what_columns and line.match(/^\s*#/)) or (previous_line.match(/^#{FOOTER}$/) and line == "\n")
    end

  end
end