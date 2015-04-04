helpers do
  # This will return the current user, if they exist
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  def current_deck
    if session[:deck_id]
      @current_deck ||= Deck.find_by_id(session[:deck_id])
    end
  end

  def current_round
    if session[:round_id]
      @current_round ||= Round.find_by_id(session[:round_id])
    end
  end

  def current_card
    if session[:card_id]
      @current_card ||= Card.find_by_id(session[:card_id])
    end
  end
end