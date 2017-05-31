users = ["dopey", "sneezy", "grumpy", "sleepy", "happy", "doc", "bashful"]

users.each do |username|
	user =User.new(username: username, first_name: username, last_name: username)
	user.password = "password"
	user.save
end

50.times do
	task = Task.create(user_id: rand(1..7), day_id: rand(1..7), completion: false, goal: "finish work")
	Reward.create(user_id: task.user_id, task_id: task.id, day_id: rand(1..7), reward_type: "a snack", reached: false)
end
