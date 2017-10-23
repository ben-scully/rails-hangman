# features/start_game.feature

Feature: Create a Game

  Scenario: Create a new Game
    Given I am on the home page
    When I start a new game
    Then I should see a new game
