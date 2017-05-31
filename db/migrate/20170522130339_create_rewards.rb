class CreateRewards < ActiveRecord::Migration
  def change
	  	create_table :rewards do |t|
	  		t.integer :user_id
	  		t.integer :task_id
	  		t.string :reward_type

	  		t.timestamp
	  	end
	end
end