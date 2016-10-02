class CreateQaGames < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_games do |t|
      t.string :name

      t.timestamps
    end
  end
end
