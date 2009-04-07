What Column?!?
==============

A Rails plugin that details columns in ActiveRecord models.

Tired of having to look at schema.rb to figure out what columns belong to a model?  
Well no more!

With the what_column plugin a comment appears at the top of your models displaying the column details.

INSTALLATION
------------
Go into your Rails folder and type:

    script/plugin install git://github.com/thechrisoshow/what_column.git

USAGE
------------
Once what_column is installed everytime you run migrations in development mode your models will get a comment block plonked into all your models that details column information:

    class User < ActiveRecord::Base

    # === List of columns ===
    #   id         : integer 
    #   name       : string 
    #   created_at : datetime 
    #   updated_at : datetime 
    # =======================

    end


Should you wish to run the commands manually there are rake commands.  Check 'em out:

    rake what_column:add #=> Adds column details to models
  
    rake what_column:remove #=> Removes column details from models


Copyright (c) 2009 Chris O'Sullivan, released under the MIT license
