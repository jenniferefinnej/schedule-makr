class Task < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_one :reward  
end
