module GamesHelper
  # TODO where do strings go?
  NO_GUESS_MADE = 'no guesses made'
  WON = 'You WON!'
  LOST = 'You LOST!'
  MASK = '_'
  SPACE = ' '
  ONLY_ALPHABETIC = "is only allowed to contain alphabetic characters [s,w,g NOT @,*,4]"
  UNCHANGEABLE_AFTER_GUESS_MADE = "in unable to be changed once a Guess has been made"

  def masked_letters(secret_letters, guessed_letters)
    secret_letters.map { |letter| guessed_letters.include?(letter) ? letter : MASK }.join(SPACE)
  end

  def guessed_letters(guessed_letters)
    guessed_letters.empty? ? NO_GUESS_MADE : guessed_letters.each { |letter| letter }.join(SPACE)
  end

  def success_message(won)
    won ? WON : LOST
  end
end
