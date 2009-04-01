require 'test_helper'

class WhatColumnTest < ActiveSupport::TestCase

  context "works?" do
    should "work" do
      assert false
    end
  end

=begin
  def open_file(name)
    new_rails_root = "#{File.dirname(__FILE__)}/rails_root"
    File.open(File.join(new_rails_root, "app", "models", name))
  end

  context "before columnization" do
    should "not have name column detailed if not columnized" do
      assert_no_match(/# name:\sstring/, open_file("user.rb").read)
    end    
  end
  
  context "decolumnizing" do
    setup do
      WhatColumnizer.columnize
      WhatColumnizer.decolumnize
      @file = open_file("user.rb")
    end

    should "not display column details" do
      assert_no_match(/name:\sstring/, @file.read)      
    end

    should "not display footer" do
      assert_no_match(/#{WhatColumnizer::FOOTER}/, @file.read)      
    end

    should "not remove class information" do
      assert_match(/class User < ActiveRecord::Base/, @file.read)
    end
            
    should "not have extra line feed" do
      assert_no_match(/^\nclass User < ActiveRecord::Base/, @file.read)      
    end
  end
  
  context "columnizing a standard model" do
    setup do
      @file = open_file("user.rb")
      WhatColumnizer.columnize
    end
    
    teardown do
      WhatColumnizer.decolumnize
    end

    should "have age column detailed" do
      assert_match(/age:\sinteger/, @file.read)
    end

    should "have name column detailed" do
      assert_match(/name:\sstring/, @file.read)
    end
    
    should "not write over code alredy in class" do      
      assert_match(/def name_and_age/, @file.read)      
    end
    
    should "add column details at the top" do
      assert_match(/#{WhatColumnizer::FOOTER}.*class/, @file.read.delete("\n"))
    end
    
    should "add header to comments" do
      assert_match(/#{WhatColumnizer::HEADER}/, @file.read)
    end
    
    should "add footer to comments" do
      assert_match(/#{WhatColumnizer::FOOTER}/, @file.read)
    end
    
    should "only have the one columnization if columnizing twice" do
      WhatColumnizer.columnize
      assert_no_match(/#{WhatColumnizer::FOOTER}.*#{WhatColumnizer::FOOTER}/, @file.read.delete("\n"))
    end
    
    should_eventually "justify the columns" do
      assert_match(/age:        integer/, @file.read)
    end
  end
  
  context "columnizing a model in a subfolder" do
    setup do
      @file = open_file("shop/product.rb")
      WhatColumnizer.columnize
    end
    
    teardown do
      WhatColumnizer.decolumnize
    end

    should "have price column detailed" do
      assert_match(/price:\sfloat/, @file.read)
    end

    should "have integer column detailed" do
      assert_match(/quantity:\sinteger/, @file.read)
    end    
  end
  
  context "columnizing a file in a subfolder" do
    setup do
      @file = open_file("shop/product.rb")
      WhatColumnizer.columnize
    end
    
    teardown do
      WhatColumnizer.decolumnize
    end

    should "have price column detailed" do
      assert_match(/price:\sfloat/, @file.read)
    end

    should "have integer column detailed" do
      assert_match(/quantity:\sinteger/, @file.read)
    end    
  end

  
  context "columnizing an inherited model" do
    setup do
      @file = open_file("admin_user.rb")
      WhatColumnizer.columnize
    end

    should "have name column detailed" do
      assert_match(/name:\sstring/, @file.read)
    end
  end
  
  context "columnizing a module" do
    setup do
      @file = open_file("user_methods.rb")
      WhatColumnizer.columnize      
    end

    should "not have any what column stuff" do
      assert_no_match(/#{WhatColumnizer::FOOTER}/, @file.read)
    end
  end

  context "columnizing a class that's not an activerecord model" do
    setup do
      @file = open_file("authorizer.rb")
      WhatColumnizer.columnize      
    end

    should "not have any what column stuff" do
      assert_no_match(/#{WhatColumnizer::FOOTER}/, @file.read)
    end
  end    
=end
end