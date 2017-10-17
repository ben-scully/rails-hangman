class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :secret_word, null: false

      t.timestamps
    end
  end
end
