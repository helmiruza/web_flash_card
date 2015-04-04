class CreateCards < ActiveRecord::Migration
  def change
  	create_table :cards do |u|
  		u.integer :deck_id
  		u.string :header
  		u.string :question
  		u.string :answer
  		u.timestamps null:false
  	end
  end
end
