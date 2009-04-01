module WhatColumnMigrator
  
  def self.included(base)
    base.class_eval do
      alias_method_chain :migrate, :columnizer
    end
  end

  def migrate_with_columnizer
    puts "columns"
    migrate_without_columnizer
    WhatColumn::Columnizer.add_column_details_to_models
  end

end