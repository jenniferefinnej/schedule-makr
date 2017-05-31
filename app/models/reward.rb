class Reward < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :task
  belongs_to :user
end
