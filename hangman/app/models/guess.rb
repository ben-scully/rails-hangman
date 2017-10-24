class Guess < ApplicationRecord
  ONLY_ALPHABETIC = "is only allowed to contain alphabetic characters [s,w,g NOT @,*,4]"
  REPEATED_GUESS = "has already been guessed"

  belongs_to :game

  validates_presence_of :letter
  validates_length_of :letter, :maximum => 1
  validates_format_of :letter, :with => /\A[a-z]+\z/i, message: ONLY_ALPHABETIC
  validates_uniqueness_of :letter, scope: :game, message: REPEATED_GUESS

  before_save :downcase_letter!

  private

  def downcase_letter!
    self.letter.downcase!
  end
end
