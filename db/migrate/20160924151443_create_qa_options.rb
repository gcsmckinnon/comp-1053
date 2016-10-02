class CreateQaOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_options do |t|
      t.references :qa_game, foreign_key: true
      t.string :option

      t.timestamps
    end
  end
end
