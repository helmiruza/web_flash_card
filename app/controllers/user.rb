enable :sessions

get '/' do
	erb :index
end

get '/register' do

erb :register
end

post '/register' do
u = User.find_by(email: params[:user][:email])
	if u.nil?
		@user = User.create(params[:user])
		redirect to '/login'
	else
		@errors = ["Email is already in the system. Try another email"]
		# @errors = @user.errors.full_messages
		erb :register
	end
end

get '/logout' do
	session.clear
	redirect to '/'
end

get '/login' do

erb :login
end

post '/login' do
	@user = User.authenticate(params[:user][:username], params[:user][:password])	
 if @user
 	session[:user_id] = @user.id
 	session[:username] = @user.username
 	redirect to "/dashboard/#{@user.username}"
 else
 	@errors = ["Authentication failed. Try again"]
 	erb :login
 end
end

get '/dashboard' do
	if session[:user_id] != nil
		@user = User.find_by(id: session[:user_id])
  		session[:username] = @user.username
		redirect to "/dashboard/#{@user.username}"
	else
		@errors = ["You must be logged in to view Dashboard Panel"]
		erb :login
	end
end