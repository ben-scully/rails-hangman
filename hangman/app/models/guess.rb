class Guess < ApplicationRecord
  belongs_to :game
  validates_presence_of :letter
  validates_length_of :letter, :maximum => 1
  validates_format_of :letter, :with => /\A[a-z]+\z/i, message: "must be an alphbetic character [s,w,g NOT @,*,4]"
  validates_uniqueness_of :letter, scope: :game_id, message: "has already been guessed"
end
