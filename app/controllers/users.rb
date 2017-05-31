# load '.env'

get '/users/new' do
	erb :'users/sign_up'
end

post '/users' do
	@user = User.create(username: params[:username], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
	# to check if user is saved:
	if @user 
		session[:user_id] = @user.id
		redirect "/user/#{session[:user_id]}/tasks"
	else
		@error = "Sign up failed, please try again."
		erb :'users/sign_up'
	end
end

get '/sessions/new' do
	erb :'users/sign_in'
end

# user authentication && start new sessions
post '/sessions' do
	@user = User.find_by(username: params[:username])

	# if user exists and they can authenticate successfully, take them to the next thing
	if @user && User.authenticate(params[:username], params[:password])
		session[:user_id] = @user.id
		# session is a hash the browser will pass thru url to server
		# passing small, simple things makes the website faster

		redirect "/user/#{session[:user_id]}/tasks"
	else
		@error = "Login failed, please try again."
		erb :'users/sign_in'
	end
end

# logout && clear session
delete '/sessions/:id' do
	if session[:user_id] == params[:id].to_i
		session.clear
		redirect '/sessions/new'
	else
		redirect '/tasks'
	end
end