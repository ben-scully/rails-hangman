# features/start_game.feature

Feature: Start a game

  Scenario: From the homepage
    Given I am on the home page
    When I start a new game
    Then I should see a new game
