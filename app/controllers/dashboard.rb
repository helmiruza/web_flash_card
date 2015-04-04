enable :sessions

get '/dashboard/:username' do |username|
	# @posts = Post.all
	# session[:username] = params[:user][:username]
	@user = User.find_by(username: username)

	redirect to "/login" unless session[:user_id] != nil
erb :dashboard
end

post '/create/round' do
	if logged_in?
		@selected_round = current_user.rounds.create(count: 10, correct_guess: 0, incorrect_guess: 0)
		session[:round_id] = @selected_round.id
		redirect to "/selectdeck"
	else
		redirect to "/login"
	end
	
end

get '/selectdeck' do
	erb :selectdeck
end

post '/selectdeck' do
	session[:deck_id] = params[:rounds][:deck_id]

	current_round.deck_id = session[:deck_id]
	current_round.save!

	@guess = Guess.create(round_id: current_user.rounds.last.id, card_id: current_deck.cards.sample.id)
	redirect to "/card/#{@guess.card_id}"

end

get '/card/:id' do |id|
	session[:card_id] = Card.find_by(id: id)
	@card = session[:card_id]
	current_round.count -= 1
	current_round.save!

	erb :showcards
end

post '/card/submit/:id' do |id|
	@card = Card.find_by(id: id)
	#submit provided data. compare with answer.
	current_guess = @card.guesses.last
	current_guess.answer = params[:cards][:user_input].downcase
	current_guess.save

	if @card.answer == params[:cards][:user_input]
		current_round.correct_guess += 1
		current_round.save!
	else
		current_round.incorrect_guess += 1
		current_round.save!
	end

	if current_round.count != 0
		@guess = Guess.create(round_id: current_user.rounds.last.id, card_id: current_deck.cards.sample.id)
		redirect to "/card/#{@guess.card_id}"
	else
		redirect to "/results"
	end
end

get '/results' do
	#allguess returns an array of guesses made by current user. provides user_input (answer)
	@allguesses = current_user.rounds.last.guesses
	# @current_round = current_round

	erb :results
end

post '/dashboard/:id/post/create' do |id|

	if session[:user_id] != nil

		cur_user = User.find(session[:user_id])
		@post = cur_user.posts.create(params[:post])
		tags = params[:tags][:name]
		tags.split(",").each do |tagname|
			if Tag.find_by(name: tagname).nil?
				Tag.create(name: tagname,post_id:@post[:id])
			end
		end

		redirect to "/post/#{@post[:id]}"
	else
		# @url = Url.create(params[:url])
		
	end
	# redirect to "/get/#{@url.short_url}"
end

get '/post/:id' do |id|
	@posts = Post.all
	@post = Post.find_by(id: id)
	@tags = @post.tags
	erb :post
end

get '/edit/:id' do |id|
	@post = Post.find_by(id: id)
	erb :post_edit
end

post '/edit/:id' do |id|
	if session[:user_id] != nil
		@post = Post.find_by(id: id)
		@post.title = params[:post][:title]
		@post.post = params[:post][:post]
		@post.save
	end

	redirect to "/dashboard/#{session[:user_id]}"
end

post "/delete/:id" do |id|
	if session[:user_id] != nil
		@post = Post.find_by(id: id)
		@post.destroy
	end

	redirect to "/dashboard/#{session[:user_id]}"
end

