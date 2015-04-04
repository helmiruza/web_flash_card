class CreateRounds < ActiveRecord::Migration
  def change
  	create_table :rounds do |u|
  		u.integer :deck_id
  		u.integer :user_id
  		u.integer :count
  		u.integer :correct_guess
  		u.integer :incorrect_guess
  		u.timestamps null:false
  	end
  end
end
