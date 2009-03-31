class User < ActiveRecord::Base
  
  def name_and_age
    "#{name} and #{age}"
  end
end
