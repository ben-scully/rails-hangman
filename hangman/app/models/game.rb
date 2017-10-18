class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy

  validate :game_has_not_begun?
  validates_presence_of :secret_word
  validates_length_of :secret_word, :minimum => 3
  validates_format_of :secret_word, :with => /\A[a-z]+\z/i, message: GamesHelper::ONLY_ALPHABETIC

  before_save :downcase_fields

  def guessed_letters
    guesses.pluck(:letter)
  end

  def lives
    secret_letters.size - incorrect_guesses.size
  end

  def secret_letters
    secret_word.chars
  end

  def incorrect_guesses
    guessed_letters - secret_letters
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
    (secret_letters - guessed_letters).empty?
  end

  def game_has_not_begun?
    errors.add(:game, GamesHelper::UNCHANGEABLE_AFTER_GUESS_MADE) unless guesses.empty?
  end

  def downcase_fields
     self.secret_word.downcase!
  end
end
