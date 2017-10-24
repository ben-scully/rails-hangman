module GamesHelper
  NO_GUESS_MADE = 'no guesses made'
  WON = 'You WON!'
  LOST = 'You LOST!'
  MASK = '_'

  def masked_letters(secret_letters, guessed_letters)
    secret_letters.map { |letter| guessed_letters.include?(letter) ? letter : MASK }.join(' ')
  end

  def gameover_message(won)
    won ? WON : LOST
  end
end
