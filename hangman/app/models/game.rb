class Game < ApplicationRecord
  has_many :guesses
  validates :secretword, presence: true,
                    length: { minimum: 3 }

  def masked_letters
    secret_letters.map { |letter| letter if guessed_letters.include?(letter) }
  end

  def guessed_letters
    guesses.pluck(:letter)
  end

  def remaining_lives
    secret_letters.size - incorrect_guesses.size
  end

  private
    def secret_letters
      secretword.chars
    end

    def incorrect_guesses
      guessed_letters - secret_letters
    end
end
