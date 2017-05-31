get '/tasks' do
	@tasks = Task.all

	erb :"tasks/index"
end

get '/tasks/new' do
	if session[:user_id] #check for log in 
		erb :"tasks/new"
	else
		redirect "/sessions/new"
	end
end
#get shows
get '/tasks/:id' do
	@task = Task.find_by(id: params[:id])
	if session[:user_id] && @task.user_id == session[:user_id]
		erb :"tasks/show"
	else
		redirect "/sessions/new"
	end
end

post '/tasks' do
	@task = Task.new(params[:task])
	@task.user_id = session[:user_id]
	@task.save #save to database
	# .new doesn't save things right away

	redirect "/tasks/#{@task.id}"
	# double quotes allow string interpolation (#{})
end

get "/tasks/:id/edit" do
	@task = Task.find(params[:id])

	#check if user id exists AND the session user id matches the photo's user id
	if session[:user_id] && session[:user_id]==@tasks.user_id
		@task = Task.find(params[:id])
		erb :"task/edit"
	else
		redirect '/sessions/new'
	end
end

patch '/tasks/:id' do
	@task = Task.find(params[:id])
	@task.update(params[:task])
	redirect "/tasks/#{@task.id}"
end

patch '/tasks/:id/reward' do 
	@task = Task.find(params[:id])
	if @task.completion == true
		@task.update(completion: false) #we want the oppoiste
	else
		@task.update(completion: true)
	end
	redirect "/user/#{session[:user_id]}/tasks" #specifically the user's tasks

end 

delete '/tasks/:id' do
	@task = Task.find(params[:id])

	if session[:user_id] && session[:user_id]== @task.user_id
		@task.destroy()
		redirect "/user/#{session[:user_id]}/tasks"
	else
		redirect '/sessions/new'
	end
end

# to redirect user to their task after login
get '/user/:id/tasks' do
	if session && params[:id].to_i == session[:user_id]
 		@user = User.find(session[:user_id])
 		@tasks = @user.tasks
		erb :"tasks/user_tasks"
	else
		redirect '/sessions/new'
	end
end