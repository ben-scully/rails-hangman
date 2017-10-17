module GamesHelper
  def masked_letters(secret_letters, guessed_letters)
    secret_letters.map { |letter| guessed_letters.include?(letter) ? letter : '_' }.join(' ')
  end

  def guessed_letters(guessed_letters)
    guessed_letters.empty? ? 'no guesses made' : guessed_letters.each { |letter| letter }.join(' ')
  end

  def success_message(won)
    won ? 'You WON!' : 'You LOST!'
  end
end
