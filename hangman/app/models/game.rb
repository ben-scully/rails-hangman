class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy

  validates_presence_of :secret_word
  validates_length_of :secret_word, :minimum => 3
  validates_format_of :secret_word, :with => /\A[a-z]+\z/i, message: "is only allowed to contain alphabetic characters [s,w,g NOT @,*,4]"

  before_save :downcase_fields

  def guessed_letters
    guesses.pluck(:letter)
  end

  def lives
    secret_word.chars.size - (guessed_letters - secret_word.chars).size
  end

  def game_finished?
    won? || lost?
  end

  def won?
    all_letters_guessed? && lives > 0
  end

  def lost?
    lives <= 0
  end

  private

  def all_letters_guessed?
    (secret_word.chars - guessed_letters).empty?
  end

  def downcase_fields
     self.secret_word.downcase!
  end
end
