# features/step_definitions/make_guess_steps.rb

Given /^A game already exists$/ do
  @game = Game.create!(secret_word: 'pirate')
end

Given /^I am playing hangman$/ do
  visit(game_url(@game))
end

When /^I make a correct guess$/ do
  fill_in('guess[letter]', with: @game.secret_word.chars.first)
  click_button('Create Guess')
end

Then /^I should see a hangman letter revealed$/ do
  expect(page).to have_content("Masked Letters: #{@game.secret_word.chars.first} _ _ _ _ _")
end

Then /^I should see my guess in the list of guesses$/ do
  expect(page).to have_content("Guessed Letters: #{@game.secret_word.chars.first}")
end

When /^I make an incorrect guess$/ do
  fill_in('guess[letter]', with: 'z')
  click_button('Create Guess')
end

Then /^I should see no hangman letters revealed$/ do
  expect(page).to have_content("Masked Letters: _ _ _ _ _ _")
end

Then /^I should see my incorrect guess in the list of guesses$/ do
  expect(page).to have_content("Guessed Letters: z")
end
