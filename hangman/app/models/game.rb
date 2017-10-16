class Game < ApplicationRecord
  has_many :guesses, dependent: :destroy
  validates_presence_of :secretword
  validates_length_of :secretword, :minimum => 3
  validates_format_of :secretword, :with => /\A[a-z]+\z/i, message: "is only allowed to contain alphbetic characters [s,w,g NOT @,*,4]"

  def masked_letters
    secret_letters.map { |letter| letter if guessed_letters.include?(letter) }
  end

  def guessed_letters
    guesses.pluck(:letter)
  end

  def remaining_lives
    secret_letters.size - incorrect_guesses.size
  end

  def game_finished?
    dead? || won?
  end

  def won?
    guessed_every_letter?
  end

  private
    def secret_letters
      secretword.chars
    end

    def incorrect_guesses
      guessed_letters - secret_letters
    end

    def dead?
      remaining_lives <= 0
    end

    def guessed_every_letter?
      (secret_letters - guessed_letters).empty?
    end
end
