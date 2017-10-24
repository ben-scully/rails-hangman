# features/make_guess.feature

Feature: Make Guess
  Background: A game already exists
    Given A game already exists
    And I am playing hangman

  Scenario: Make a correct guess
    When I make a correct guess
    Then I should see a hangman letter revealed
    And I should see my guess in the list of guesses

  Scenario: Make an incorrect guess
    When I make an incorrect guess
    Then I should see no hangman letters revealed
    And I should see my incorrect guess in the list of guesses
