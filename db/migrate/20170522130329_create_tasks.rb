class CreateTasks < ActiveRecord::Migration
  def change
  	create_table :tasks do |t|
  		t.integer :user_id
  		t.boolean :completion #need something to keep track of tasks
  		t.text :goal
  		# t.text :reward

  		t.timestamp
  	end
  end
end
