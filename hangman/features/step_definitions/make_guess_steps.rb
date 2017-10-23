# features/step_definitions/make_guess_steps.rb

secret_word = 'pirate'

Given /^A game already exists$/ do
  @game = Game.create!(secret_word: secret_word)
end

Given /^I am on the hangman page$/ do
  visit(game_url(@game))
end

When /^I make a correct guess$/ do
  fill_in('guess[letter]', with: secret_word[0])
  click_button('Create Guess')
end

Then /^I should see a hangman letter revealed$/ do
  expect(page).to have_content("Masked Letters: #{secret_word[0]} _ _ _ _ _")
end

And /^I should see my guess in the list of guesses$/ do
  expect(page).to have_content("Guessed Letters: #{secret_word[0]}")
end

When /^I make an incorrect guess$/ do
  fill_in('guess[letter]', with: 'z')
  click_button('Create Guess')
end

Then /^I should see no hangman letters revealed$/ do
  expect(page).to have_content("Masked Letters: _ _ _ _ _ _")
end

And /^I should see my incorrect guess in the list of guesses$/ do
  expect(page).to have_content("Guessed Letters: z")
end
