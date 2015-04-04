class Round < ActiveRecord::Base
  # Remember to create a migration!
  has_many :guesses
  has_many :cards, through: :guesses
  belongs_to :user
  belongs_to :deck
end
