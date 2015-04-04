class CreateDecks < ActiveRecord::Migration
  def change
  	create_table :decks do |u|
  		u.string :name
  		u.timestamps null:false
  	end
  end
end
