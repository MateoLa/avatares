class Actor < ActiveRecord::Base
  
  acts_as_avatarable

  def avatar_string
    name
  end
end
