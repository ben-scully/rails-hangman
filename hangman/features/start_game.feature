# features/start_game.feature

Feature: Start Game

  Scenario: Start a new Game
    Given I am on the home page
    When I start a new game
    Then I should see a new game screen
