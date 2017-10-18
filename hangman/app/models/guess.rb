class Guess < ApplicationRecord
  belongs_to :game

  validates_presence_of :letter
  validates_length_of :letter, :maximum => 1
  validates_format_of :letter, :with => /\A[a-z]+\z/i, message: GuessesHelper::ONLY_ALPHABETIC
  validates_uniqueness_of :letter, scope: :game, message: GuessesHelper::REPEATED_GUESS

  before_save :downcase_fields

  private

  def downcase_fields
    self.letter.downcase!
  end
end
