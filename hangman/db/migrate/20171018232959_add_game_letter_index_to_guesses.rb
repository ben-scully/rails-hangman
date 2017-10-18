class AddGameLetterIndexToGuesses < ActiveRecord::Migration[5.1]
  def change
    add_index :guesses, [:game_id, :letter], unique: true
  end
end
