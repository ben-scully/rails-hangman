# features/step_definitions/start_game_steps.rb

Given /^I am on the home page$/ do
  visit('/')
end

When /^I start a new game$/ do
  click_link('New Game')
end

Then /^I should see a new game$/ do
  expect(page).to have_content("New Game")
end
