class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :rounds

  def self.authenticate(username, password)
    @user = User.find_by_username(username)

    return false if @user.nil?
	    if @user.password == password
	      return @user
	    else
	      return false
	    end
  	end
end
