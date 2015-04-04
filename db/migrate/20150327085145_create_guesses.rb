class CreateGuesses < ActiveRecord::Migration
  def change
  	create_table :guesses do |u|
  		u.integer :card_id
  		u.integer :round_id
  		u.string :answer
  		u.timestamps null:false
  	end
  end
end
