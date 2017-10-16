class CreateGuesses < ActiveRecord::Migration[5.1]
  def change
    create_table :guesses do |t|
      t.string :letter
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
